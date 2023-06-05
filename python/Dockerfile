FROM python:3.10-slim

COPY . /code
COPY ./requirements.txt /code/requirements.txt

RUN pip install --no-cache-dir --upgrade -r /code/requirements.txt

WORKDIR /code/app

CMD ["uvicorn", "run:app", "--reload", "--host", "0.0.0.0", "--port", "8000"]

EXPOSE 8000
