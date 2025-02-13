FROM python:3.11-slim

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

WORKDIR /app

COPY requirements.txt .

RUN pip install --upgrade pip
RUN pip install -r requirements.txt

COPY . /app

EXPOSE 8000

CMD ["sh", "-c", "python manage.py makemigrations && python manage.py migrate --noinput && python manage.py seed_db && gunicorn worldtour.wsgi:application --bind 0.0.0.0:8000 --workers 3"]