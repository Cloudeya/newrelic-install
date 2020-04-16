FROM 0xnu/alpine3-python3-docker

MAINTAINER Finbarrs Oketunji <finbarrs@mindhug.io>

ENV APP_HOME /app
WORKDIR $APP_HOME

COPY ./src $APP_HOME
RUN pip3 install --no-cache-dir -r requirements.txt

RUN chmod 444 main.py
RUN chmod 444 requirements.txt

# Service must listen to $PORT environment variable.
# This default value facilitates local development.
ENV PORT 8080

# Run the web service on container startup.
CMD [ "python3", "main.py" ]

