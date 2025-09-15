from typing import Callable, Awaitable, Any

from aiogram import BaseMiddleware
from aiogram.types import Message


class CheckSubscription(BaseMiddleware):

    async def __call__(
        self,
        handler: Callable[[Message, dict[str, Any]], Awaitable[Any]],
        event: Message,
        data: dict[str, Any]
    ) -> Any:
        """Проверка подписки на канал

        - При желании укажите клавиатуру с ссылкой на ваш канал.
        - [!] Также, чтобы все работало, бот должен состоять в группе/канале с правами администратора.
        """

        chat_member = await event.bot.get_chat_member("@fsoky_community", event.from_user.id)
        if chat_member.status == "left":
            return await event.answer("Подпишись на канал, чтобы пользоваться ботом!")
        return await handler(event, data)