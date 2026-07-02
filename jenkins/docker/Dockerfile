# Start from the official Jenkins base image
FROM jenkins/jenkins:lts-jdk21

# Switch to root user to install packages
USER root

# Update and upgrade packages
RUN apt-get update && apt-get upgrade -y

# Install required packages
RUN apt-get install -y pipx lsb-release build-essential curl

# Add Docker official GPG key
RUN curl -fsSLo /usr/share/keyrings/docker-archive-keyring.asc \
  https://download.docker.com/linux/debian/gpg

# Add Docker repository
RUN echo "deb [arch=$(dpkg --print-architecture) \
  signed-by=/usr/share/keyrings/docker-archive-keyring.asc] \
  https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" > /etc/apt/sources.list.d/docker.list

# Install from Docker repository docker-ce-cli
RUN apt-get update && apt-get install -y docker-ce-cli 

# Create Homebrew directory and set permissions
RUN mkdir -p /home/linuxbrew/.linuxbrew && \
    chown -R jenkins:jenkins /home/linuxbrew

# Switch back to the default Jenkins user for security
USER jenkins

# Install Homebrew
RUN NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Add Homebrew to PATH
ENV PATH="/home/linuxbrew/.linuxbrew/bin:${PATH}"

# Install GCC with Homebrew 
RUN brew install gcc

# Install Ansible via pipx
RUN pipx install --include-deps ansible

# Add pipx binaries to PATH
RUN pipx ensurepath

# Install Terraform and Packer
RUN brew tap hashicorp/tap && \
    brew install hashicorp/tap/terraform && \
    brew install hashicorp/tap/packer
