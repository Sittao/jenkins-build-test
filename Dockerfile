FROM jenkins/inbound-agent:4.3-4
USER root
RUN apt-get -y update && \
 apt-get -y install apt-transport-https ca-certificates curl gnupg-agent software-properties-common libseccomp2 && \
 apt-get -y install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common && \
 curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
RUN add-apt-repository \
 "deb [arch=amd64] https://download.docker.com/linux/debian \
 $(lsb_release -cs) \
 stable"
RUN apt-get update
RUN apt-get -y install docker-ce docker-ce-cli containerd.io
RUN curl -L "https://github.com/docker/compose/releases/download/1.25.5/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose && \
 chmod +x /usr/local/bin/docker-compose && \
 ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
RUN gpasswd -a jenkins docker && usermod -aG docker jenkins 
USER jenkins
