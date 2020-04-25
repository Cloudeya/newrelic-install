FROM mindhug/alpine3-python3-docker

MAINTAINER Finbarrs Oketunji <finbarrs@mindhug.io>

ENV APP_HOME /app
WORKDIR $APP_HOME

COPY ./src $APP_HOME
RUN pip3 install --no-cache-dir -r requirements.txt

RUN chmod 444 main.py
RUN chmod 444 requirements.txt

ENV PORT 8080

CMD [ "python3", "main.py" ]

