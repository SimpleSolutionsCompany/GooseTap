from typing import Callable, Awaitable, Any

from aiogram import BaseMiddleware
from aiogram.types import Message, CallbackQuery

from cachetools import TTLCache


class ThrottlingMiddleware(BaseMiddleware):

    def __init__(self, time_limit: float = 1.0) -> None:
        """
        :param time_limit:
            - Задержка, при срабатывании "отключает" хендлер на определенное время.
            По умолчанию 1 секунда.
        """

        self._limit = TTLCache(maxsize=10_000, ttl=time_limit)

    async def __call__(
        self,
        handler: Callable[[Message | CallbackQuery, dict[str, Any]], Awaitable[Any]],
        event: Message | CallbackQuery,
        data: dict[str, Any]
    ) -> Any:
        if event.from_user.id in self._limit:
            return
        else:
            self._limit[event.from_user.id] = None
        return await handler(event, data)