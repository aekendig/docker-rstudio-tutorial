# docker-rstudio-tutorial
 
The objective of this tutorial is to learn how to create a Docker container that specifies an RStudio environment in order to reproduce a simple data analysis. The specifications include the versions of RStudio and two packages. This tutorial is aimed at new users of Docker. Prior experience with Rstudio is helpful, but  not required. You will need to download and install RStudio at https://rstudio.com/ and Docker Desktop at https://www.docker.com/. In the process, you should create a Docker Hub login. See the PDF for more background information

### Tutorial 

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

