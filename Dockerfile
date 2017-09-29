FROM python:3.5-alpine

RUN apk update && \
    apk add git

RUN git clone -b master https://github.com/opsdroid/opsdroid.git /usr/src/app
WORKDIR /usr/src/app

COPY ./config/ /ect/opsdroid
COPY ./modules/ /usr/src/app/modules

RUN pip3 install --upgrade pip
RUN pip3 install --no-cache-dir -r requirements.txt
RUN pip3 install -U tox

EXPOSE 8080

CMD ["python", "-m", "opsdroid"]