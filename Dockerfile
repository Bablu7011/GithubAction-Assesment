Stage 1: Build stage
FROM python:3.9 AS builder

WORKDIR /app


COPY . .


Stage 2: Prod Stage

FROM python:3.9-slim

WORKDIR /app


COPY --from=builder /app/app.py .


CMD ["python", "app.py"]
