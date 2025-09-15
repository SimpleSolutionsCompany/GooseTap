from aiogram import Router


def setup_callback_routers() -> Router:
    from . import simple

    router = Router()
    router.include_router(simple.router)
    return router