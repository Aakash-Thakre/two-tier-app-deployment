FROM python:3.9-slim

RUN apt-get update -y \
    && apt-get upgrade -y \
    && apt-get install -y gcc default-libmysqlclient-dev pkg-config \
    && rm -rf /var/lib/apt/list/*

COPY requirements.txt .

RUN pip install mysqlclient

RUN pip install -r requirements.txt

COPY . .

CMD ["python","app.py"]

