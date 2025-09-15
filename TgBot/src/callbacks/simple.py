from aiogram import Router, F
from aiogram.types import CallbackQuery

router = Router()


@router.callback_query(F.data == "about_us")
async def about_us(query: CallbackQuery) -> None:
    await query.message.answer(
        "Why Goose? Because a goose means strength 💪\n"
        "We are a team ... who decided to prove: geese also deserve their own tapper.\n\n"
        "Our mission is to bring people together and give you a simple yet fun Goose Tapper,\n"
        "where every player truly matters.\n\n"
        "Each tap you make helps the goose grow, evolve, and conquer the world.\n\n"
        "So join the army of geese and show everyone who’s the real top bird 🪿🏆"
    )



@router.callback_query(F.data == "say_hello")
async def say_hello(query: CallbackQuery) -> None:
    await query.answer("Hello!")