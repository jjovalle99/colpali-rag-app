.PHONY: clean-pycache clean-ruff-cache clean-mypy-cache clean-all \
        lint format imports mypy pretty all dev prod \
		create_collection


include .env

# ------------------------------------------------------------------------------
# Cleaning Targets
# ------------------------------------------------------------------------------
# These targets remove various cache directories generated by Python tools.
clean-pycache:
	find ./ -type d -name '__pycache__' -exec rm -rf {} +

clean-ruff-cache:
	find ./ -type d -name '.ruff_cache' -exec rm -rf {} +

clean-mypy-cache:
	find ./ -type d -name '.mypy_cache' -exec rm -rf {} +

# Removes all caches (pycache, ruff_cache, and mypy_cache).
clean-all: clean-pycache clean-ruff-cache clean-mypy-cache

# ------------------------------------------------------------------------------
# Code Quality and Formatting Targets
# ------------------------------------------------------------------------------
# Lint the code and automatically fix issues where possible.
lint:
	uv run ruff check src/* --fix
	uv run ruff check server.py --fix

# Format the code using Ruff's built-in formatting capabilities.
format:
	uv run ruff format src/*
	uv run ruff format server.py

# Sort imports using Ruff, automatically fixing them.
imports:
	uv run ruff check src/* --select I --fix
	uv run ruff check server.py --select I --fix

# Perform static type checking with mypy.
mypy:
	uv run mypy src server.py

# Run all code quality improvements: linting, formatting, and sorting imports.
pretty: lint format imports

# ------------------------------------------------------------------------------
# Meta Targets
# ------------------------------------------------------------------------------
# Run all code quality checks (lint, format, imports), static type checks,
# and then clean up caches.
all: pretty mypy clean-all

# ------------------------------------------------------------------------------
# Run Targets
# ------------------------------------------------------------------------------
create_collection:
	uv run python scripts/create_collection.py


# Run the server in development mode with hot-reloading.
dev:
	uv run uvicorn server:app \
		--host 0.0.0.0 \
		--port 8000 \
		--reload

# Run the server in production mode without reloading.
prod:
	uv run uvicorn server:app \
		--host 0.0.0.0 \
		--port 8000