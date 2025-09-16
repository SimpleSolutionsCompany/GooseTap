# TGBotTemplate

A Telegram bot template built with Python and aiogram.

## Setup

### Ensure that the `.env` file contains valid values

## Installation

### Installing Poetry
```bash
pip install poetry
```

### Installing project dependencies
```bash
poetry install --no-root
```

## Running the project
```bash
poetry run python src/__main__.py
```

## Project Structure

### Root (`GooseTapTgBot`) directory
- `poetry.lock` - libraries that will be installed in the project (`poetry add new_library`)
- `pyproject.toml` - project configuration (name, description, dependencies, etc.)

### `src` Directory
- `callbacks` - callback handlers
- `handlers` - message handlers
- `filters` - custom filters
- `keyboards` - keyboards (inline, factory, reply, builders)
- `states` - states
- `middlewares` - middlewares

- `__main__.py` - main file responsible for launching the bot
- `config_reader.py` - handles loading variables from the `.env` file