# APS Reference Deployment

This project includes a Docker Compose template to deploy Alfresco Process Service (APS).

* [.env](.env) specifies Alfresco Process Service version to be used by Docker Compose
* [compose.yaml](compose.yaml) describes Docker Compose deployment

>> Note this is a sample deployment designed for education purposes. When using Alfresco Process Service in real world, additional requirements should impact in the design of the final deployment.

A valid license, named `activiti.lic`, must be obtained to use this project. Please ensure that this file is located in the `license` folder before initiating the project. If you are an Enterprise Customer or Partner, feel free to reach out to [Alfresco Hyland Support](https://community.hyland.com) to acquire the necessary license.


## Using

```
docker-compose up --build --force-recreate
```

## Service URLs

APS App 
* URL: http://localhost:9090/activiti-app
* Credentials: admin@app.activiti.com / admin

APS Admin:
* URL: http://localhost:9091/activiti-admin
* Credentials: admin / admin


## Running for AARCH64

When running this Docker Compose in Mac with Apple Silicon chip, apply following steps:

Build APS applications for AARCH64:

```
docker buildx create --name buildx-multi-arch --use --bootstrap

cd activiti-app
docker buildx build \
--load \
--builder=buildx-multi-arch \
--platform=linux/arm64 \
--build-arg PROCESS_SERVICES_VERSION=24.2.0 \
--tag=alfresco/process-services-aarch64:24.2.0 .

cd activiti-admin
docker buildx build \
--load \
--builder=buildx-multi-arch \
--platform=linux/arm64 \
--build-arg PROCESS_SERVICES_VERSION=24.2.0 \
--tag=alfresco/process-services-admin-aarch64:24.2.0 .
```

Modify `.env` file to use Docker Images build:

```
PROCESS_SERVICES_IMAGE=alfresco/process-services-aarch64
PROCESS_SERVICES_ADMIN_IMAGE=alfresco/process-services-admin-aarch64
```

Start Docker Compose with the regular command:

```
docker-compose up --build --force-recreate
```

## Additional resources

This project provides a basic structure to deploy APS (mainly oriented to testing purposes). Explore the resources provided by @OpenPj for a more comprehensive understanding:
* [APS Docker Deployment](https://github.com/OpenPj/alfresco-process-services-docker-deployment) for deployment
* [Alfresco Process Services SDK](https://github.com/OpenPj/alfresco-process-services-project-sdk) for development
