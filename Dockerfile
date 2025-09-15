FROM ubuntu:22.04

# Prevent interactive prompts during package install
ENV DEBIAN_FRONTEND=noninteractive

# Install required packages
RUN apt-get update && apt-get install -y \
    fortune-mod \
    cowsay \
    netcat-openbsd \
    && rm -rf /var/lib/apt/lists/*

# Copy your script into container
COPY wisecow.sh /wisecow.sh

# Make script executable
RUN chmod +x /wisecow.sh

# Expose the port your app listens on
EXPOSE 4499

# Run the script
CMD ["/wisecow.sh"]
