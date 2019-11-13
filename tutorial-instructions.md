# docker-rstudio-tutorial

[Set-up: software installation](#setup)  
[1: Run data analysis locally](#local)  
[2: Run template Docker container](#template)  
[3: Build your own Docker container](#build)
 
### Set-up: software installation <a name="setup"></a>

Please install (or update) these programs:  
* R  
* RStudio  
* Docker Desktop or Toolbox*  
Note: This tutorial may be difficult to complete on a Windows computer. The majority of Windows users I've worked with during two separate workshops were unable to install or use Docker.  

R and RStudio installation guides from Data Carpentry can be found here: https://datacarpentry.org/R-ecology-lesson/index.html#setup_instructions  
Open the programs and check for errors.  

Docker Desktop installation guides from Cyverse can be found here (Section 2): https://github.com/sanjanasudarshan/container_camp_workshop_2019/blob/master/docker/dockerintro.rst  
Test the Docker installation by following Section 2.1.  

*Older versions of Mac and Windows may need to install Docker Toolbox instead of Docker Desktop:  
https://docs.docker.com/toolbox/toolbox_install_windows/  
https://docs.docker.com/toolbox/toolbox_install_mac/  
 
When you install Docker Desktop/Toolbox, you’ll create a Docker Hub username and password. We will use these during the tutorial.

### 1: Run data analysis locally <a name="local"></a>

We'll start by running a statistical analysis and visualization of a dataset that comes from the R package "datasets", npk. From R Help: "A classical N, P, K (nitrogen, phosphate, potassium) factorial experiment on the growth of peas conducted on 6 blocks. Each half of a fractional factorial design confounding the NPK interaction was used on 3 of the plots."  
  
* Create a new folder (i.e., directory) “docker-rstudio-tutorial” on your desktop*
* Navigate to: https://raw.githubusercontent.com/aekendig/docker-rstudio-tutorial/master/myScript.R
* Save the script in “docker-rstudio-tutorial” as myScript.R  
    - Copy and paste it into a new R script in RStudio  
    - Browser menu: File -> Save Page As…  
* Open the script in RStudio
* Run the script and examine the output  
* Comment out the "install packages" lines (#) once you've run these
* Save the file

*I don’t encourage saving things on your desktop, but it will make the rest of the tutorial easier if you do 


### 2: Run template Docker container <a name="template"></a>

We'll test the Docker installation and run a container created by [Rocker](https://www.rocker-project.org/). To interact with Docker, copy and paste the following into your Terminal/Command Prompt. Windows users [cannot use PowerShell ISE](https://docs.docker.com/docker-for-windows/) and may need to work in Command Prompt, Bash, or PowerShell. 

* Start Docker Desktop if it isn't already running by double clicking on the icon  
* Test the Docker installation:
    - You should get a message starting with "Hello from Docker!"  
```
docker run hello-world
```
* Save three variables: a new username to login to RStudio, a new password to login to RStudio, and your Docker Hub username (that you created while installing Docker)
    - Replace the text between the symbols (< >) with your text and remove the symbols   
* Code for Mac/bash/Powershell(?):  
```
rstudio_username=<enter-your-new-RStudio-username>
```
```
echo $rstudio_username
```
````
rstudio_password=<enter-your-new-RStudio-password>
````
```
echo $rstudio_password
```
````
docker_username=<enter-your-Docker-Hub-username>
````
```
echo $docker_username
```

* Code for Windows Command Prompt:  
    - If you use this code, substitute $text for %text% in future steps
```
SET rstudio_username=<enter-your-new-RStudio-username>
```
```
ECHO %rstudio_username%
```
````
SET rstudio_password=<enter-your-new-RStudio-password>
````
```
ECHO %rstudio_password%
```
````
SET docker_username=<enter-your-Docker-Hub-username>
````
```
ECHO %docker_username%
```
 
* Run the Docker container: 
```
docker run -d -e USER=$rstudio_username -e PASSWORD=$rstudio_password -p 8787:8787 rocker/tidyverse
```
* Explanation of code:    
    - Run the container in the background (-d = detached)
    - Set the USER and PASSWORD environmental variables (-e)
    - Map a port from the inside of the Docker container to your browser (-p 8787:8787)
    - Name of the image used to build the container (rocker/tidyverse)
* Once the "docker run" code is done running, navigate to localhost:8787 in your browser
* Login using the RStudio username and password you specified earlier
* Test out RStudio (this is the product of the container)
* Stop the Docker container by listing the running containers and then using the container ID to stop it (delete the < > symbols):    
```
docker ps
```
```
docker stop <paste-container-ID>
```

### 3: Build your own Docker container <a name="build"></a>

Now we'll build our own Docker container using the Rocker image as a template.  

* You should currently be in your home directory within the terminal (e.g., /Users/AmyKendig)
* Navigate to the docker-rstudio-tuorial:
```
cd Desktop/docker-rstudio-tutorial
```
* Create the Dockerfile by opening a text editor (note that the filename has no extension)
* Example for Mac: 
```
vi Dockerfile
```
* Example for Windows: 
```
copy con Dockerfile
```
* Paste the following into the text editor:  
    - vi: first type "i" to insert text
```
FROM rocker/tidyverse:3.6.1
RUN R --no-restore --no-save -e 'devtools::install_version("nlme", version="3.1-137")' -e 'devtools::install_version("ggplot2", version="3.1.1")'
ADD myScript.R /home/rstudio/
```
* Explanation of the code:  
    - Start with the Rocker Tidyverse image, specify the version
    - In R, install specific versions of nlme and ggplot2  
    - Add the R script to the container
* Exit the text editor:  
    - vi: press [esc] button -> type ":wq" -> press [enter] button  
    - copy con: press buttons [ctrl] and z -> press [enter] button  
* Build the container:
```
docker build -t $docker_username/docker-rstudio-tutorial:1.0 .
```
* Explanation of the code:  
    - Name the container name "whatever your username is/docker-rstudio-tutorial"
    - Tag the container (-t) as version 1.0 in case you want to update it in the future
    - The period indicates that the resources are in the current directory (we're inside docker-rstudio-tutorial)  
* Run your container to test it out:  
    - Remember to change $text to %text% if you did earlier
```
docker run -d -e USER=$rstudio_username -e PASSWORD=$rstudio_password -p 8787:8787 $docker_username/docker-rstudio-tutorial:1.0
```
* Once the "docker run" code is done running, navigate to localhost:8787 in your browser
* Login using the RStudio username and password you specified earlier
* Push the image to your Docker Hub account:
```
docker login
```
```
docker push $docker_username/docker-rstudio-tutorial:1.0
```
* Stop the Docker container by listing the running containers and then using the container ID to stop it (delete the < > symbols):  
```
docker ps
```
```
docker stop <paste-container-ID>
```
* Try running your neighbor's container if you're in a workshop:
```
docker pull <insert-their-docker-username>/docker-rstudio-tutorial:1.0
```
```
docker run -d -e USER=$rstudio_username -e PASSWORD=$rstudio_password -p 8787:8787 <insert-their-docker-username>/docker-rstudio-tutorial:1.0
```
