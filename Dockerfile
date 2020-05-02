FROM mindhug/alpine3-python3-docker

MAINTAINER Finbarrs Oketunji <finbarrs@mindhug.io>

ENV APP_HOME /app
WORKDIR $APP_HOME

COPY requirements.txt $APP_HOME
RUN pip3 install --no-cache-dir -r requirements.txt
RUN chmod 444 requirements.txt

COPY ./src $APP_HOME
RUN chmod 444 main.py

COPY Pipfile $APP_HOME

ENV PORT 8080

CMD [ "python3", "main.py" ]
