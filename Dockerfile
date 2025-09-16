# Use an official Ubuntu base image
FROM ubuntu:22.04

# Install dependencies
RUN apt-get update && apt-get install -y \
    fortune-mod \
    cowsay \
    netcat-openbsd \
    && rm -rf /var/lib/apt/lists/*

# Add /usr/games to PATH (for cowsay & fortune)
ENV PATH="$PATH:/usr/games"

# Set working directory
WORKDIR /app

# Copy your script into the container
COPY wisecow.sh .

# Make it executable
RUN chmod +x wisecow.sh

# Expose the service port
EXPOSE 4499

# Run the script
CMD ["./wisecow.sh"]
