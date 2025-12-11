# GooseTap
Tap, grow and have fun with your own goose!🪿 Earn points with every tap, upgrade your goose and boost your progress step by step. Join thousands of players, climb the leaderboard and show that geese can dominate the tapper world! 🏆🔥







# Best practices для зберігання Connection String у .NET проєкті
## Робота з Connection String через ENV

### 1. У репозиторії

* В `appsettings.json` **не зберігається** справжній ключ.
  Приклад:

  ```json
  {
    "ConnectionStrings": {
      "DefaultConnection": ""
    }
  }
  ```
* У `.gitignore` додати рядок:

  ```
  .env
  ```

### 2. Для розробників (локально)

#### Варіант А – через `.env` файл

1. Створи файл `.env` у корені проєкту (цей файл **не пушиться в GitHub**).
2. Запиши туди свій ключ:

   ```
   ConnectionStrings__DefaultConnection=Server=...;Database=...;User Id=...;Password=...
   ```
3. Запусти проєкт – ключ підтягнеться автоматично.

#### Варіант Б – через `dotnet user-secrets`

1. У консолі виконай:

   ```bash
   dotnet user-secrets init
   dotnet user-secrets set "ConnectionStrings:DefaultConnection" "Server=...;Database=...;User Id=...;Password=..."
   ```
2. Запускай застосунок – ключ буде доступний тільки на твоїй машині.

---

### 3. На сервері (продакшн / тест)

* Ключ задається як **Environment Variable**.

  * Windows PowerShell:

    ```powershell
    $env:ConnectionStrings__DefaultConnection="Server=...;Database=...;User Id=...;Password=..."
    ```
  * Linux/macOS bash:

    ```bash
    export ConnectionStrings__DefaultConnection="Server=...;Database=...;User Id=...;Password=..."
    ```

* У CI/CD (GitHub Actions, Azure, Docker, etc.) – ключ зберігається у **Secrets**.

---

### 4. У коді

Доступ завжди однаковий:

```csharp
var connectionString = builder.Configuration.GetConnectionString("DefaultConnection");
```

---

✅ Результат:

* Ніяких ключів у GitHub.
* Кожен розробник має свій `.env` або user-secrets.
* На сервері ключи зберігаються у системних ENV або GitHub Secrets.

---

# 🚀 Як запустити проєкт

## 🛠 Попередні вимоги (Prerequisites)

Перед початком переконайтеся, що у вас встановлено:

*   **[.NET 8 SDK](https://dotnet.microsoft.com/en-us/download/dotnet/8.0)** (для Backend)
*   **[Flutter SDK](https://docs.flutter.dev/get-started/install)** (для Frontend)
*   **[Python 3.10+](https://www.python.org/downloads/)** та **[Poetry](https://python-poetry.org/docs/#installation)** (для Telegram Bot)
*   **[Docker](https://www.docker.com/)** (опціонально, для запуску в контейнерах)

---

## 🔙 Backend (.NET)

### Локальний запуск

1.  **Перейдіть у папку API:**
    ```bash
    cd Backend/API
    ```

2.  **Налаштуйте конфігурацію:**
    Створіть файл `.env` у корені `Backend/API` (або використовуйте `user-secrets` як описано вище) та додайте рядок підключення до БД:
    ```env
    ConnectionStrings__DefaultConnection=Server=...;Database=...;User Id=...;Password=...
    ```

3.  **Запустіть проєкт:**
    ```bash
    dotnet run --project SSC.GooseTap.Api/SSC.GooseTap.Api.csproj
    ```
    API буде доступне за адресою `http://localhost:5000` (або інший порт, вказаний у логах).

### Запуск через Docker

З кореневої папки репозиторію:

```bash
docker build -f Backend/API/SSC.GooseTap.Api/Dockerfile -t goosetap-api Backend/API
docker run -p 8080:8080 -e ConnectionStrings__DefaultConnection="..." goosetap-api
```

---

## 📱 Frontend (Flutter)

### Локальний запуск

1.  **Перейдіть у папку Frontend:**
    ```bash
    cd Frontend
    ```

2.  **Налаштуйте змінні середовища:**
    Створіть файл `.env` у папці `Frontend`:
    ```env
    API_URL=http://localhost:5000 # Або ваша URL бекенду
    ```

3.  **Встановіть залежності:**
    ```bash
    flutter pub get
    ```

4.  **Запустіть застосунок:**
    ```bash
    flutter run
    ```

### Запуск через Docker (Nginx)

```bash
cd Frontend
docker-compose up --build
```
Застосунок буде доступний на порту `8080`.

---

## 🤖 Telegram Bot (Python)

### Локальний запуск (без Docker)

1.  **Перейдіть у папку TgBot:**
    ```bash
    cd TgBot
    ```

2.  **Налаштуйте змінні середовища:**
    Створіть файл `.env` у папці `TgBot/src` (важливо: саме в `src`, оскільки `config_reader.py` шукає його там):
    ```env
    BOT_TOKEN=ваш_токен_бота
    ADMIN_IDS=[123456789, 987654321] # JSON масив ID адміністраторів
    ```

3.  **Встановіть залежності через Poetry:**
    ```bash
    poetry install
    ```

4.  **Запустіть бота:**
    ```bash
    poetry run python src/__main__.py
    ```

