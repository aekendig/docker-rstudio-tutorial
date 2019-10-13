FROM rocker/tidyverse:3.6.1

RUN R --no-restore --no-save -e 'devtools::install_version("nlme", version="3.1-137")' -e 'devtools::install_version("ggplot2", version="3.1.1")'
