# Simple Docker

## Part 1. Ready-made docker

* Taking the official docker image from nginx and downloading it using ```docker pull```:\
![Using docker pull](./screenshots/part1_1.png)

* Checking for the docker image with ```docker images```:\
![Using docker images](./screenshots/part1_2.png)

* Running docker image with ```docker run -d [image_id|repository]```:\
![Using docker run](./screenshots/part1_3.png)

* Checking that the image is running with ```docker ps```:\
![Using docker ps](./screenshots/part1_4.png)

* Viewing container information with ```docker inspect [container_id|container_name]```:\
![Using docker incpect](./screenshots/part1_5.png)
    * the container size:\
    ![The container size](./screenshots/part1_6.png)
    * the list of mapped ports:\
    ![The list of mapped ports](./screenshots/part1_7.png)
    * the container ip:\
    ![The container ip](./screenshots/part1_8.png)

* Stopping docker image with ```docker stop [container_id|container_name]```:\
![Using docker stop](./screenshots/part1_9.png)

* Checking that the image has stopped with ```docker ps```:\
![Using docker ps](./screenshots/part1_10.png)

* Running docker with ports 80 and 443 in container, mapped to the same ports on the local machine, with ```run``` command:\
![Using docker run -p](./screenshots/part1_11.png)

* Checking that the nginx start page is available in the browser at *localhost:80*:\
![The nginx start page in the browser](./screenshots/part1_12.png)

* Restarting docker container with ```docker restart [container_id|container_name]```:\
![Using docker restart](./screenshots/part1_13.png)

* Checking in any way that the container is running:\
![Using docker ps](./screenshots/part1_14.png)

## Part 2. Operations with container

* Reading the *nginx.conf* configuration file inside the docker container with the ```exec``` command:\
![Using docker exec](./screenshots/part2_1.png)

* Creating a *nginx.conf* file on a local machine and configuring it on the */status* path to return the nginx server status page:\
![nginx.conf configuration file](./screenshots/part2_2.png)

* Copying the created *nginx.conf* file inside the docker image using the ```docker cp``` command:\
![Using docker cp](./screenshots/part2_3.png)

* Restarting nginx inside the docker image with ```exec```:\
![Restarting nginx using docker exec](./screenshots/part2_4.png)

* Checking that *localhost:80/status* returns the nginx server status page:\
![The nginx server status page](./screenshots/part2_5.png)

* Exporting the container to a *container.tar* file with the ```export``` command:\
![Using docker export](./screenshots/part2_6.png)

* Stopping the container:\
![Using docker stop](./screenshots/part2_7.png)

* Delete the image with ```docker rmi [image_id|repository]``` without removing the container first:\
![Using docker rmi](./screenshots/part2_8.png)

* Deleting stopped container:\
![Using docker rm](./screenshots/part2_9.png)

* Import the container back using the ```import``` command:\
![Using docker import](./screenshots/part2_10.png)

* Running the imported container:\
![Running the imported container](./screenshots/part2_11.png)

* Checking that *localhost:80/status* returns the nginx server status page:\
![The nginx server status page after importing](./screenshots/part2_12.png)

## Part 3. Mini web server

* Installing the services and the libraries:
```bash
sudo apt install libfcgi-dev
sudo apt install spawn-fcgi
sudo apt install nginx
```

* To change the nginx.conf file:
```bash
sudo cp ./nginx/nginx.conf /etc/nginx/
sudo service nginx restart
```

* The commands for running:
```bash
gcc -Wall -Werror -Wextra ./server/app.c -lfcgi -o server.fcgi
spawn-fcgi -p 8080 -n server.fcgi
```

## Part 4. Your own docker

* The commands to run the server using docker:
```bash
docker build -f Dockerfile.4 . -t my-server
docker run -d -p 80:81 my-server
```

## Part 5. Dockle

* To install [dockle](https://github.com/goodwithtech/dockle) I used the next commands:
```bash
VERSION=$(
 curl --silent "https://api.github.com/repos/goodwithtech/dockle/releases/latest" | \
 grep '"tag_name":' | \
 sed -E 's/.*"v([^"]+)".*/\1/' \
) && curl -L -o dockle.deb https://github.com/goodwithtech/dockle/releases/download/v${VERSION}/dockle_${VERSION}_Linux-64bit.deb
sudo dpkg -i dockle.deb && rm dockle.deb
```

* To check docker container using *dockle*:
```bash
docker build -f Dockerfile.5 . -t my-server:5
dockle -ak NGINX_GPGKEY -ak NGINX_GPGKEY_PATH my-server:5
```

* Running the server to check that it works:
```bash
docker run -d -p 80:81 my-server:5
```

## Part 6. Basic Docker Compose

* Building and running the project:
```bash
docker-compose build
docker-compose up
```