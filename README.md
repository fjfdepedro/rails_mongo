# Aplicación Ruby on Rails con un base de datos Mongo

Esta alicación será uno de los dos microservicios que vamos a tener.

## Dockerfile de la aplicación Rails 6.0.3 con Ruby 2.7.0

La diferencia entre dockerizar una aplicación rails para entorno de desarrollo o de producción se basa en las variables de entorno que declaremos para nuestra aplicación:

- RAILS_ENV, seteamos que el entorno es producción
- RAILS_SERVE_STATIC_FILES, al estar en el entorno de producción queremos que se puedan servir static files, assets.
- RAILS_LOG_TO_STDOUT, aqui le decimos que en vez de escribir en el log queremos que escriba en el stdout, salida estandar de Unix.

En el dockerfile vamos a meter como archivo entrypoints una validación por si el pid del server ya esta levantado.

La aplicación rails vamos a dockerizarla junto una base datos Postgres, vamos a crear un contenedor a partir de una imagen ya creada (postgres:12.1)

Y vamos a crear un contenedor de RabbitMQ donde vamos a consumir una cola 'product'. Y tendremos un 

La cola 'product' la va producir una aplicación rails 2.5.1 con base de datos MongoDB:

https://github.com/fjfdepedro/rails_mongo

Cada vez que se guarde en base de datos, encolaremos en la queue 'product' de RabbitMQ un json del producto creado.

Queremos es esta manera simular el tener dos microservicios.

Utilizamos variables de entorno para los parametros de conexión sa la base de datos Postgres (archivo .env)

## Docker compose de la aplicación Rails 6.0.3 con Ruby 2.7.0, Postgres y RabbitMQ

En el docker compose vamos a crear los contenedores de mi aplicación Rails y una base de datos Postgres, ademas de crear las conexiones entre ellos, vamos a crear los volumenes necesarios, y habilitar los puertos.

En el repositorio
https://github.com/fjfdepedro/docker-compose-images
Se encuentran los manifiestos de Docker compose para poder desplegar las dos aplicaciones Rails con las bases de datos MongoDB y Postgres, y RabbitMQ.

## Docker hub

Se sube la imagen de nuestra aplicación Rails a Docher hub y a partir de esa imagen vamos crear los ficheros de Helm necesarios para deplegar el microservicio de nuestra aplicación a nuestro nodo local de kubernetes

https://hub.docker.com/repository/docker/fjfdepedro/rails_postgres

https://hub.docker.com/repository/docker/fjfdepedro/rails_mongo



## Helm3
Creo las plantillas para un namespace determinado con los deployments de la aplicación Rails y de la base de datos Postgres, de la aplicación Rails con MongoDB
En el repositorio
