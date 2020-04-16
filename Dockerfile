FROM 0xnu/alpine3-python3-docker

MAINTAINER Finbarrs Oketunji <finbarrs@mindhug.io>

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

COPY ./src/requirements.txt /usr/src/app/
RUN pip3 install --no-cache-dir -r requirements.txt

COPY src /usr/src/app

# Expose the Flask port
EXPOSE 8080

# Execute the Flask app
CMD [ "python3", "main.py" ]

