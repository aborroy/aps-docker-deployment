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


## Additional resources

Explore the [Alfresco Process Services SDK](https://github.com/OpenPj/alfresco-process-services-project-sdk) for additional information.