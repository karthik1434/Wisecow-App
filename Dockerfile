# Use a lightweight Ubuntu base
FROM ubuntu:22.04

# Set environment variables to avoid interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies: fortune, cowsay, netcat, bash
RUN apt-get update && \
    apt-get install -y fortune-mod cowsay netcat-openbsd && \
    rm -rf /var/lib/apt/lists/*

# Copy the application script into the container
WORKDIR /app
COPY wisecow.sh /app/wisecow.sh

# Make script executable
RUN chmod +x /app/wisecow.sh

# Expose port
EXPOSE 4499

# Start the server
CMD ["./wisecow.sh"]
