# Use the official Python image from Docker Hub
FROM python:3.11-slim

# Set the working directory in the container
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

# Install Flask
RUN pip install flask

# Make port 80 available to the world outside this container
EXPOSE 80

# Run the app.py when the container launches
CMD ["python", "app.py"]















# # Use the official Python image from Docker Hub
# FROM python:3.11-slim

# # Set environment variables
# ENV PYTHONDONTWRITEBYTECODE=1
# ENV PYTHONUNBUFFERED=1

# # Set work directory
# WORKDIR /app

# # Copy the requirements (if any) and install them
# COPY requirements.txt .

# RUN pip install --no-cache-dir -r requirements.txt

# # Copy the rest of the application code
# COPY . .

# # Expose port 80
# EXPOSE 80

# # Command to run the app
# CMD ["python", "app.py"]
