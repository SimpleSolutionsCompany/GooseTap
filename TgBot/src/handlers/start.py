from aiogram import Router
from aiogram.types import Message
from aiogram.filters import CommandStart, Command

from src.keyboards.inline import get_inline_keyboard

router = Router()


@router.message(CommandStart())
async def start(message: Message) -> None:
    await message.answer(
        "GooseTap is just started🦆\n"
         "We are here to start a new era of tap earning😉!\n"
         "Wellcome to GooseTap: a new world of adventures is waiting for you🚀",
         reply_markup=get_inline_keyboard()
    )


