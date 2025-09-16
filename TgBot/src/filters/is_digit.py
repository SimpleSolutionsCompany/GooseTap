from aiogram.filters import BaseFilter
from aiogram.types import Message


class IsDigit(BaseFilter):

    async def __call__(self, message: Message) -> bool:
        if (
            message.text.isnumeric()
            or (message.text.count(".") == 1 and message.text.replace(".", "").isnumeric())
        ):
            return True
        return False
    

""" Второй вариант с помощью регулярных выражений.
import re

from aiogram.filters import BaseFilter
from aiogram.types import Message


class IsDigit(BaseFilter):

    async def __call__(self, message: Message) -> None:
        pattern = re.compile(r'^\d+(\.\d+)?$')
        return False if not pattern.match(message.text) else True
"""