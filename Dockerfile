

FROM python:3.10.9-slim

WORKDIR /app

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

COPY ./requirements.txt /app/requirements.txt

RUN apt update && apt upgrade -y && apt install -y wget && apt install -y unzip && apt install -y redis && \
    wget -qO /tmp/google-chrome-stable_current_amd64.deb https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && \
    apt -y install /tmp/google-chrome-stable_current_amd64.deb && service redis-server start
RUN export PATH=$PATH:/app/.chromedriver
RUN pip install -r /app/requirements.txt

CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
COPY . .