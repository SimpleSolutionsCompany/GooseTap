"""Зачем нужен Pydantic?

Pydantic - это библиотека Python для проверки и валидации данных,
что делает ее полезной для обработки данных в приложениях.

- Код ниже определяет класс Settings, который наследуется от BaseSettings из библиотеки Pydantic.
В классе Settings определены атрибуты ADMIN_IDS (список целых чисел)
и BOT_TOKEN (строка, скрытая с использованием SecretStr).
Также создается объект model_config класса SettingsConfigDict,
который предполагает чтение конфигурационных данных из файла .env
в текущем каталоге с использованием кодировки UTF-8.
"""

import os

from pydantic import SecretStr
from pydantic_settings import BaseSettings, SettingsConfigDict


class Settings(BaseSettings):
    ADMIN_IDS: list[int] = [000] # [000, 111, ...]
    BOT_TOKEN: SecretStr

    model_config = SettingsConfigDict(
        env_file=os.path.join(os.path.dirname(__file__), ".env"), # Указываем абсолютный путь.
        env_file_encoding="utf-8"
    )


config = Settings()