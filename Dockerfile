# Initial stage
FROM python:3.11 AS builder

WORKDIR /app
COPY app.py .

# prod stage
FROM python:3.11-alpine

WORKDIR /app

COPY --from=builder /app/app.py .

CMD ["python", "app.py"]
