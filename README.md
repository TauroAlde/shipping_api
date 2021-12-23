# Shipping API

## Installation

* Ruby version
  - 2.7.5
* Rails version
  - 6.1.4.4

* DataBase
    - PostgreSql

Instalaltion database 
- Quickstart guide: https://www.digitalocean.com/community/tutorials/how-to-install-postgresql-on-ubuntu-20-04-quickstart-es

Configuration .env

    DATABASE_USERNAME=
    DATABASE_PASSWORD=

 Create User, Create Database, Grant privileges/access: https://medium.com/@mohammedhammoud/postgresql-create-user-create-database-grant-privileges-access-aabb2507c0aa

    DATABASE_DEVELOPMENT=
    DATABASE_TEST=
    DATABASE_PRODUCTION=

Life time for JWT in seconds

    TOKEN_LIFETIME=

Time leeway for jwt in seconds

    EXP_LEEWAY=

Json web token key

    * PRIVATE_SECRET_KEY=
 

Installs the gems

* bundler install
 
Create the database and migrate

    Rails db:create
    Rails db:migrate

Install redis
* downlaod redis
    - url: https://redis.io/download

Command for run redis
*  src/redis-server

Command for run server rails
*   rails server

Command for run sidekiq
* bundle exec sidekiq
