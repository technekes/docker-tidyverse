FROM rocker/geospatial:latest
LABEL author="Jack Ross <jack.ross@technekes.com>"

RUN apt-get update && \
  apt-get install -y apt-utils curl gnupg gnupg2 gnupg1 apt-transport-https ca-certificates && \
  curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - && \
  curl https://packages.microsoft.com/config/debian/9/prod.list > /etc/apt/sources.list.d/mssql-release.list && \
  sudo apt-get update && \
  ACCEPT_EULA=Y apt-get -y install msodbcsql17

RUN \
  install2.r --error \
    here \
    rvest \
    xml2 \
    selectr \
    noncensus \
    jsonlite \
    networkD3 \
    kableExtra \
    formattable \
    lubridate \
  && \
  R -e 'devtools::install_github("jennybc/googlesheets")' && \
  R -e 'devtools::install_github("cloudyr/aws.s3")' && \
  R -e 'devtools::install_github("yihui/xaringan")'

RUN export ADD=shiny && \
  bash /etc/cont-init.d/add
