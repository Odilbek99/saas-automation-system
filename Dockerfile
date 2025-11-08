# Use official Python image
FROM python:3.11-slim

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

WORKDIR /app

# system deps for psycopg2 and collectstatic image optimizations
RUN apt-get update && apt-get install -y build-essential libpq-dev curl && rm -rf /var/lib/apt/lists/*

# copy requirements first for better caching
COPY requirements.txt /app/

RUN pip install --upgrade pip
RUN pip install -r requirements.txt

# copy project
COPY . /app

# make entrypoint executable
COPY ./entrypoint.sh /app/entrypoint.sh
RUN chmod +x /app/entrypoint.sh

ENV PORT 8000

EXPOSE ${PORT}

ENTRYPOINT ["/app/entrypoint.sh"]