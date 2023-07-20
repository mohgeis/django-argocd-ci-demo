# Start from a Python 3.9 base image
FROM arm64v8/python:3.9

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Set work directory in the container
WORKDIR /code

RUN apt-get update && apt-get install -y libpq-dev build-essential

# Copy requirements.txt to the container and install Python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the code to the container
COPY . .

# Run the application with Gunicorn
CMD [ "gunicorn", "django_dev.wsgi:application", "--bind", "0.0.0.0:8000" ]
