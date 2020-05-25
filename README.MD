docker build -t acolasz/java-base:1.8.172 \
	--build-arg artifactory_url=https://artifactory.dorsum.eu/artifactory \
	--build-arg artifactory_user=user \
	--build-arg artifactory_password=psw \
	--build-arg tech_user=acolasz \
	--build-arg jdk_version=172 \
	.
