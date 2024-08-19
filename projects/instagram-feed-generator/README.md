# Instagram Feed Generator

## Run in locale

1. Create a virtualenv if not exists with `python3 -m venv .venv`.
2. Activate virtualenv with `source .venv/bin/activate`.
3. Install dependencies with `pip3 install -r requirements.txt`.
4. Set environment variables with `cp .env.example .env` and edit `.env`.
5. Run with `uvicorn main:app --reload`.

## Run in Docker

1. Build image with `docker build -t instagram-feed-generator .`.
2. Run container with `docker run -p 9090:8000 instagram-feed-generator`.
3. Access `http://localhost:8000`.
