# Aplicación Ruby on Rails con un base de datos Mongo

Esta aplicación será uno de los dos microservicios que vamos a tener.

## Dockerfile de la aplicación Rails 5.2.4 con Ruby 2.5.1

Para dockerizar esta aplicación rails vamos a realizarla con multistage, de tal manera que asi nuestra versión en producción será con el peso más pequeño que podemas realizar, la subiremos a Docker Hub y desde nuestros archivos Heml 3 la llamaremos

La aplicación rails vamos a dockerizarla junto una base datos Postgres, vamos a crear un contenedor a partir de una imagen ya creada (postgres:12.1)
Y vamos a crear un contenedor de RabbitMQ donde vamos a producir items en la cola 'product'. 

Cada vez que se guarde en base de datos, encolaremos en la queue 'product' de RabbitMQ un json del producto creado.

Queremos es esta manera simular el tener dos microservicios.

Utilizamos variables de entorno para los parametros de conexión sa la base de datos Postgres (archivo .env)

## Docker compose de la aplicación Rails 5.2.4 con Ruby 2.5.1, Postgres y RabbitMQ

En el docker compose vamos a crear los contenedores de mi aplicación Rails y una base de datos MongoDB, ademas de crear las conexiones entre ellos, vamos a crear los volumenes necesarios, y habilitar los puertos.

En el repositorio
https://github.com/fjfdepedro/docker-compose-images
Se encuentran los manifiestos de Docker compose para poder desplegar las dos aplicaciones Rails con las bases de datos MongoDB y Postgres, y RabbitMQ.

## Docker Hub

Se sube la imagen de nuestra aplicación Rails a Docher hub y a partir de esa imagen vamos crear los ficheros de Helm necesarios para deplegar el microservicio de nuestra aplicación a nuestro nodo local de kubernetes

https://hub.docker.com/repository/docker/fjfdepedro/rails_postgres

https://hub.docker.com/repository/docker/fjfdepedro/rails_mongo

## Helm 3
Se cean las plantillas para un namespace determinado con los deployments de la aplicación Rails y de la base de datos Postgres, de la aplicación Rails con MongoDB En el repositorio https://github.com/fjfdepedro/rails_chart_helm3
