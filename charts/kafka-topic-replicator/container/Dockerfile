FROM python:3.10.0-slim-bullseye as base

ENV POETRY_VERSION=1.1.12

RUN pip install "poetry==$POETRY_VERSION"
COPY app/* /app/
COPY poetry.lock pyproject.toml ./
RUN poetry install

FROM base as production
CMD ["poetry", "run" "python3", "-u", "/app/kafka-topic-replicator.py"]
