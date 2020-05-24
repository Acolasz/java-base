FROM debian:buster

ARG artifactory_url
ARG artifactory_user
ARG artifactory_password
ARG tech_user
ARG jdk_version

# Unix tools
RUN apt-get update && apt-get install -y \
		sudo \
		curl \
		wget \
		net-tools \
		nano \
		git

RUN mkdir -p /usr/lib/jvm/java-8-oracle/ \
	&& cd /usr/lib/jvm/java-8-oracle/ \
	&& wget --user=${artifactory_user} --password=${artifactory_password} ${artifactory_url}/docker-installer/oracle/jdk/jdk-8u${jdk_version}-linux-x64.tar.gz \
	&& tar zxvf jdk-8u${jdk_version}-linux-x64.tar.gz --strip 1 -C /usr/lib/jvm/java-8-oracle/ \
	&& rm ./jdk-8u${jdk_version}-linux-x64.tar.gz

# Create user
RUN useradd -ms /bin/bash "${tech_user}" \
	&& chown -R "${tech_user}" /var/ \
	&& chown -R "${tech_user}" /opt/ \
	&& chmod -R go-w /opt/ \
	&& chmod -R go-w /usr/local/bin \
	&& chmod -R go-w /var/lib \
	&& usermod -aG sudo "${tech_user}"

WORKDIR /home/"${tech_user}"
USER "${tech_user}"

# Settup git config
RUN git config --global user.name "${tech_user}" \
	&& git config --global user.email "${tech_user}@gmail.com"
	
# Environment variables
ENV JAVA_HOME=usr/lib/jvm/java-8-oracle/
ENV	PATH=${JAVA_HOME}\bin:${PATH}