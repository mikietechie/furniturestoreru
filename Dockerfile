# syntax=docker/dockerfile:1
FROM python:3.10
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1
WORKDIR /src
COPY requirements.txt /src/
RUN pip install -r requirements.txt
COPY . /src/
# RUN mkdir -p ./media/logs
# RUN touch ./media/logs/gunicorn.access.log
# RUN touch ./media/logs/gunicorn.error.log
# RUN chmod 666 ./media/logs/gunicorn.access.log
# RUN chmod 666 ./media/logs/gunicorn.error.log
# RUN chmod +x ./entrypoint.sh
# ENTRYPOINT ["/bin/bash", "./entrypoint.sh"]
RUN python manage.py migrate
RUN python manage.py createsu
EXPOSE 8000
ENTRYPOINT [ "python", "manage.py", "runserver", "0.0.0.0:8000" ]