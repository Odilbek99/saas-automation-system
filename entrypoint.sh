#!/usr/bin/env bash
set -e

# Apply database migrations
python3 src/manage.py migrate --noinput

# Collect static files
python3 src/manage.py collectstatic --noinput

# Start Gunicorn
exec gunicorn automation_system.wsgi:application \
    --bind 0.0.0.0:${PORT:-8000} \
    --workers 3 \
    --log-level info