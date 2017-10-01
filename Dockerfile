FROM python:3.5-alpine

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

RUN apk update && apk add git

RUN git clone https://github.com/opsdroid/opsdroid/
WORKDIR /usr/src/app/opsdroid

COPY config/ .

RUN pip3 install --upgrade pip
RUN pip3 install --no-cache-dir -r requirements.txt
RUN pip3 install -U tox

EXPOSE 8080

CMD ["python", "-m", "opsdroid"]