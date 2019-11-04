# docker-rstudio-tutorial

[Set-up: software installation](#setup)  
[1: Run data analysis locally](#local)  
[2: Run template Docker container](#template)
[3: Build your own Docker container](#build)
 
### Set-up: software installation <a name="setup"></a>

Please install (or update) these programs:  
1.	R  
2.	RStudio  
3.	Docker Desktop or Toolbox*  

R and RStudio installation guides from Data Carpentry can be found here: https://datacarpentry.org/R-ecology-lesson/index.html#setup_instructions  
Open the programs and check for errors.  

Docker Desktop installation guides from Cyverse can be found here (Section 2): https://github.com/sanjanasudarshan/container_camp_workshop_2019/blob/master/docker/dockerintro.rst  
Test the Docker installation by following Section 2.1.  

*Older versions of Mac and Windows may need to install Docker Toolbox instead of Docker Desktop:  
https://docs.docker.com/toolbox/toolbox_install_windows/  
https://docs.docker.com/toolbox/toolbox_install_mac/  
 
When you install Docker Desktop/Toolbox, you’ll create a Docker Hub username and password. We will use these during the tutorial.

### 1: Run data analysis locally <a name="local"></a>

### 2: Run template Docker container <a name="template"></a>

### 3: Build your own Docker container <a name="build"></a>

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

