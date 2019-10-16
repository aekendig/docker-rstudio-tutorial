Testing the Docker installation
```
docker run hello-world
```
Running a Docker container
```
docker run -d -e USER=<username> -e PASSWORD=<password> -p 8787:8787 rocker/tidyverse
```
Stopping a Docker container
```
docker ps
```
```
docker stop <container ID>
```
Write the Dockerfile
```
cd <file path to docker-rstudio-tutorial>
```
```
vi Dockerfile
```
```
FROM rocker/tidyverse:3.6.1
RUN R --no-restore --no-save -e 'devtools::install_version("nlme", version="3.1-137")' -e 'devtools::install_version("ggplot2", version="3.1.1")'
```
Build the container
```
docker build -t <Docker username>/docker-rstudio-tutorial:1.0 .
```
Run your container and add your code
```
docker run -d -e USER=<username> -e PASSWORD=<password> -p 8787:8787 -v <file path to docker-rstudio-tutorial>:/home/rstudio <Docker username>/docker-rstudio-tutorial:1.0
```
Push image
```
docker login
```
```
docker push <Docker username>/docker-rstudio-tutorial:1.0
```
