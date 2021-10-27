# Use an official Python runtime as a parent image
FROM python:3.6

# Set the working directory to /src
WORKDIR /src

COPY requirements.txt /src/requirements.txt

# Install any needed packages specified in requirements.txt
RUN pip install --trusted-host pypi.python.org -r requirements.txt

# Copy the current directory contents into the container at /src
COPY . /src

# Make port 5000 available to the world outside this container
EXPOSE 5000

# Run app.py when the container launches
CMD ["python3", "app.py"]