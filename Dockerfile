# Use official lightweight Python image
FROM python:3.11-slim

# Set working directory
WORKDIR /app

# Install Python deps
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy app code
COPY . .

# Expose Flask’s default port
EXPOSE 5000

# Run your app
CMD ["python", "main.py"]
