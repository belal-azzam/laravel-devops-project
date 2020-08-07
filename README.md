# laravel-devops-project
In this project i create a pipeline to deploy a laravel application to an eks cluster.</br>
pipeline stages: 
1. cloning project.
2. building the docker image.
3. run a basic liniting validation.
4. push image to docker hub.
5. updating eks cluster with the new docker image.

project files:
1- cloudformation contains the cloudformation config to create the cluster and its 3 nodes
2- web contians the laravel app
3- app.yaml contains kubernetes cluster deployment ans service config
4- start-apache the start script for the docker image
