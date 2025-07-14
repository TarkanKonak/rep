# pull official base image
FROM python:3.13-slim

RUN apt-get update

RUN apt-get install python3-dev build-essential -y

# set environment variable
ENV PYTHONDONTWRITEBYTECODE=1
ENV VIRTUAL_ENV=/srv/venv

# pip requirements
RUN pip install --upgrade pip
RUN pip install virtualenv && python -m virtualenv $VIRTUAL_ENV

ENV PATH="$VIRTUAL_ENV/bin:$PATH"

ADD ./requirements.txt /tmp/requirements.txt
RUN pip install -r /tmp/requirements.txt

COPY . /srv/app
WORKDIR /srv/app

# Run migrations


# Expose port 8000 for the Django development server
EXPOSE 8000

# Start the Django development server
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]