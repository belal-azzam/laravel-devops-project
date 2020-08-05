docker rm apache_server2
docker run -it --network=docker_app-network --env-file .env -p 80:80 --name=apache_server2 belalazzam/laravel-devops