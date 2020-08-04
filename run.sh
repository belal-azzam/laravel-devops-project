docker rm apache_server2
docker run -it -p 8080:80 --name=apache_server2 belalazzam/laravel-devops