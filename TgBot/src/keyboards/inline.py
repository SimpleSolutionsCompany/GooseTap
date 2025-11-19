from aiogram.types import InlineKeyboardMarkup, InlineKeyboardButton, WebAppInfo


def get_inline_keyboard() -> InlineKeyboardMarkup:
    keyboard = InlineKeyboardMarkup(inline_keyboard=[
        [
            InlineKeyboardButton(
                text="🪿 GOOSE TAP 🪿",  # uppercase
                web_app=WebAppInfo(url="https://519af5c53ad3.ngrok-free.app")
            )
        ],
        [
            InlineKeyboardButton(
                text="ℹ️ ABOUT US ℹ️",  # info icon + uppercase
                callback_data="about_us"
            )
        ],
        [
            InlineKeyboardButton(
                text="💖 SUPPORT US 💖",  # heart icon + uppercase
                url="https://send.monobank.ua/jar/5rtjWLsFcW"
            )
        ],
        [
            InlineKeyboardButton(
                text="📢 NEWS & UPDATES 📢",
                url="https://t.me/goosetapnews"
            )
        ]
    ])
    return keyboard