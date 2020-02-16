# docker-mlflow
Deploy mlflow using docker-compose

# Deploy
## 1. Login Google Cloud Platform
In this script, mlflow stores artifacts locally in the directory `home/`.  


## 2. Create .env file
In `docker-compose.yaml`, some parameters is loaded from `.env` file.  
Set following parameters in `.env`.  

- HOST: host name(If you don't use domain, any name is accepted. If use, speciy it)
- POSTGRES_USER: postgresql db user
- POSTGRES_PASSWORD: postgresql db user password
- POSTGRES_DB_NAME: The database to use, for example mlflow-db
- LETSENCRYPT_EMAIL: The e-mail address to use for Let's encrypt
- USERNAME: The username to identify the containers
- VOLUME: Where to persists files in the host

```
HOST=electra.skoltech.ru
POSTGRES_USER=mlflow
POSTGRES_PASSWORD=123M1F10W-P455W0rd456
POSTGRES_DB_NAME=mlflow-db
LETSENCRYPT_EMAIL=rodrigo.riveracastro@skoltech.ru
USERNAME=riverar
VOLUME=./
```

## 3. Set up NGINX Basic Authentication
Because mlflow doesn't provide authentication, use NGINX proxy for basic authentication system.  

```sh
$ sudo echo "{USER_NAME}:$(openssl passwd -apr1 {PASSWORD})" >> ${HOST}
```

`${HOST}` is host name you set in chapter 2.  

## 4. Build and deploy
Build mlflow Dockerfile, and then deploy applications.  

```sh
$ docker-compose build
$ docker-compose up -d
```

# Client
To use Basic authentication, mlflow use following parameters passing HTTP authentication.  
Set following environment parameters in local,  same as [3. Set up NGINX Basic Authentication](#3-Set-up-NGINX-Basic-Authentication)

- MLFLOW_TRACKING_USERNAME
- MLFLOW_TRACKING_PASSWORD

See also https://www.mlflow.org/docs/latest/tracking.html#logging-to-a-tracking-server