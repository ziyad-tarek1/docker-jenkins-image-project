# Base Image
FROM fedora:latest

# Update and Upgrade
RUN dnf -y update && \
    dnf -y upgrade && \
    dnf clean all

# Install Java 11 (OpenJDK) and clean cache
RUN dnf install -y java-11-openjdk-devel && \
    dnf clean all

# Install wget and download Jenkins repository definition
RUN dnf install -y wget && \
    wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo

# Import Jenkins GPG key
RUN rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key

# Alternative: Configure Jenkins repository file using shell script
RUN echo "[jenkins]" > /etc/yum.repos.d/jenkins.repo
RUN echo "name=Jenkins" >> /etc/yum.repos.d/jenkins.repo
RUN echo "baseurl=https://pkg.jenkins.io/redhat-stable/" >> /etc/yum.repos.d/jenkins.repo
RUN echo "gpgcheck=1" >> /etc/yum.repos.d/jenkins.repo
RUN echo "gpgkey=https://pkg.jenkins.io/redhat-stable/jenkins.io.key" >> /etc/yum.repos.d/jenkins.repo
RUN echo "enabled=1" >> /etc/yum.repos.d/jenkins.repo

# Install Jenkins and clean cache
RUN dnf install -y jenkins && \
    dnf clean all

# Expose Jenkins port
EXPOSE 8080

# Set Jenkins home directory environment variable
ENV JENKINS_HOME /var/lib/jenkins
