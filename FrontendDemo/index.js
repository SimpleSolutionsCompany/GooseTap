const API_BASE_URL = 'http://localhost:5274/api';
const TOKEN_KEY = 'goose_tap_token';

// State
let gameState = {
    balance: 0,
    currentEnergy: 0,
    maxEnergy: 1000,
    profitPerClick: 1,
    energyRestorePerSecond: 1
};
let isBusy = false;

// DOM Elements
const loadingOverlay = document.getElementById('loading-overlay');
const balanceEl = document.getElementById('balance');
const energyTextEl = document.getElementById('energy-text');
const energyFillEl = document.getElementById('energy-fill');
const gooseBtn = document.getElementById('goose-btn');
const upgradesModal = document.getElementById('upgrades-modal');
const upgradesList = document.getElementById('upgrades-list');
const openUpgradesBtn = document.getElementById('open-upgrades-btn');
const closeUpgradesBtn = document.getElementById('close-upgrades-btn');

// --- Initialization ---
async function init() {
    // Check for token
    let token = localStorage.getItem(TOKEN_KEY);

    if (!token) {
        console.log('No token found, attempting auto-login...');
        token = await login();
    }

    if (token) {
        // Sync State
        console.log('Syncing game state...');
        const syncd = await syncGame(token);
        if (syncd) {
            updateUI();
            setLoading(false);
            startEnergyTimer();
        } else {
            console.error('Sync failed, maybe token expired. Clearing token.');
            localStorage.removeItem(TOKEN_KEY);
            alert("Session expired. Please refresh.");
        }
    } else {
        alert("Login failed.");
    }
}

function setLoading(active) {
    if (active) {
        loadingOverlay.style.opacity = '1';
        loadingOverlay.style.pointerEvents = 'all';
    } else {
        loadingOverlay.style.opacity = '0';
        loadingOverlay.style.pointerEvents = 'none';
    }
}

function startEnergyTimer() {
    setInterval(() => {
        if (gameState.currentEnergy < gameState.maxEnergy) {
            gameState.currentEnergy = Math.min(gameState.maxEnergy, gameState.currentEnergy + gameState.energyRestorePerSecond);
            updateUI();
        }
    }, 1000);
}

// --- API Calls ---

async function login() {
    try {
        const response = await fetch(`${API_BASE_URL}/Auth/login-telegram`, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ initDataRaw: "" })
        });

        if (!response.ok) throw new Error('Login failed');

        const data = await response.json();
        localStorage.setItem(TOKEN_KEY, data.accessToken);
        return data.accessToken;
    } catch (err) {
        console.error("Login Error:", err);
        return null;
    }
}

async function syncGame(token) {
    try {
        const response = await fetch(`${API_BASE_URL}/v1/Game/sync`, {
            method: 'GET',
            headers: { 'Authorization': `Bearer ${token}` }
        });

        if (!response.ok) return false;

        const data = await response.json();
        gameState = { ...gameState, ...data }; // Merge
        return true;
    } catch (err) {
        console.error("Sync Error:", err);
        return false;
    }
}

async function sendClick() {
    const token = localStorage.getItem(TOKEN_KEY);
    if (!token) return;

    try {
        const response = await fetch(`${API_BASE_URL}/v1/Game/click`, {
            method: 'POST',
            headers: { 'Authorization': `Bearer ${token}` }
        });

        if (response.ok) {
            const data = await response.json();
            gameState = { ...gameState, ...data };
            updateUI();
        }
    } catch (err) {
        console.error("Click Sync Error:", err);
    }
}

async function fetchUpgrades() {
    const token = localStorage.getItem(TOKEN_KEY);
    if (!token) return;

    try {
        const response = await fetch(`${API_BASE_URL}/v1/Game/upgrades`, {
            method: 'GET',
            headers: { 'Authorization': `Bearer ${token}` }
        });

        if (response.ok) {
            const upgrades = await response.json();
            renderUpgrades(upgrades);
        }
    } catch (err) {
        console.error(err);
    }
}

async function buyUpgrade(upgradeId) {
    const token = localStorage.getItem(TOKEN_KEY);
    if (!token) return;

    try {
        const response = await fetch(`${API_BASE_URL}/v1/Game/buy/${upgradeId}`, {
            method: 'POST',
            headers: { 'Authorization': `Bearer ${token}` }
        });

        if (response.ok) {
            const data = await response.json();
            // Update balance and state
            gameState.balance = data.newBalance;
            gameState.profitPerClick = data.newProfitPerClick;
            gameState.maxEnergy = data.newMaxEnergy; // Should probably also update restore rate if DTO had it, but BuyUpgrade DTO might need update too if we want immediate feedback.
            // For now, next Sync or Click will catch it, or we assume restore rate didn't change unless we update BuyUpgrade DTO. 
            // The user wanted "sync has restore rate", so timer works. 

            // Re-fetch upgrades to update prices/avail
            fetchUpgrades();
            updateUI();
            alert("Upgrade Purchased!");
        } else {
            const err = await response.json();
            alert(`Error: ${err.message || "Cannot buy"}`);
        }
    } catch (err) {
        console.error(err);
    }
}


// --- Logic & UI ---

function updateUI() {
    balanceEl.innerText = gameState.balance.toLocaleString();
    energyTextEl.innerText = `${gameState.currentEnergy} / ${gameState.maxEnergy}`;

    // Calculate percentage
    const pct = Math.min(100, Math.max(0, (gameState.currentEnergy / gameState.maxEnergy) * 100));
    energyFillEl.style.width = `${pct}%`;
}

function handleTap(e) {
    if (gameState.currentEnergy < 1) return;

    // 1. Optimistic Update
    gameState.currentEnergy -= 1;
    gameState.balance += gameState.profitPerClick;
    updateUI();

    // 2. Visual Effect
    showFloatNumber(e.clientX, e.clientY, `+${gameState.profitPerClick}`);

    // 3. Network Call 
    sendClick();
}

function showFloatNumber(x, y, text) {
    const el = document.createElement('div');
    el.classList.add('float-number');
    el.innerText = text;
    el.style.left = `${x}px`;
    el.style.top = `${y}px`;
    document.body.appendChild(el);

    setTimeout(() => el.remove(), 1000);
}

function renderUpgrades(upgrades) {
    upgradesList.innerHTML = '';

    upgrades.forEach(u => {
        const el = document.createElement('div');
        el.classList.add('upgrade-item');

        let canBuy = gameState.balance >= u.price && (!u.maxLevel || u.currentLevel < u.maxLevel);
        let btnText = u.maxLevel && u.currentLevel >= u.maxLevel ? "MAX" : `${u.price}`;

        el.innerHTML = `
            <div class="upgrade-info">
                <h4>${u.name} (Lvl ${u.currentLevel})</h4>
                <p>${u.description}</p>
                <p style="color: #aaa; margin-top: 5px;">Effect: +${u.effectValue} to ${translateType(u.type)}</p>
            </div>
            <button class="buy-btn" ${canBuy ? '' : 'disabled'} onclick="buyUpgrade('${u.id}')">
                ${btnText} 💰
            </button>
        `;
        upgradesList.appendChild(el);
    });
}

function translateType(type) {
    if (type === 0) return "Multitap";
    if (type === 1) return "Max Energy";
    if (type === 2) return "Restore Speed";
    return "Unknown";
}

// Window global expose for onclick
window.buyUpgrade = buyUpgrade;

// --- Event Listeners ---

gooseBtn.addEventListener('pointerdown', (e) => {
    handleTap(e);
});

openUpgradesBtn.addEventListener('click', () => {
    upgradesModal.classList.add('active');
    fetchUpgrades();
});

closeUpgradesBtn.addEventListener('click', () => {
    upgradesModal.classList.remove('active');
});

// Start
init();
