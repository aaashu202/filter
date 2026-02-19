FROM python:3.11-slim-bookworm

# Prevent Python from writing .pyc files & enable unbuffered logs
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Install system dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends git && \
    rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /VJ-FILTER-BOT

# Copy only requirements first (better Docker caching)
COPY requirements.txt .

# Upgrade pip & install dependencies
RUN pip install --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

# Copy project files
COPY . .

# Start bot
CMD ["python", "bot.py"]
