# koel-docker

This project helps in creating a [docker image](https://hub.docker.com/r/nithyanatarajan/koel/) for [koel](https://github.com/phanan/koel) app. The main idea is to reduce the installation steps and easily launch the application so that we can start enjoying music as soon as possible :)


## Usage

We should provide **environment variables** to connect to database and to login to the app. We can also provide the path to media folder that contains all the songs to be played. 

###Environment variables

**DB_CONNECTION**

Database connection name, which corresponds to the database driver.
Possible values are:

* mysql (MySQL- default)
* pgsql (PostgreSQL)
* sqlsrv (Microsoft SQL Server)

> This project currently works only for mysql. Work in progress for others.

**DB_HOST**

Database hostname, ip or name of the machine where database runs

**DB_DATABASE**

Name of the database to be connected

**DB_USERNAME** and **DB_PASSWORD**

username/password to connect to a database

**ADMIN_EMAIL**, **ADMIN_NAME** and **ADMIN_PASSWORD**

Default account details to get started with koel app

###Path to media folder

You can link any folder containing songs by adding as a docker volume at /media

```
-v PATH_TO_MUSIC_ALBUMS:/media
```


## Examples

### Plain docker with mysql
**Running mysql using docker**

```
docker run --name=koel_mysql -e MYSQL_ROOT_PASSWORD=root -e MYSQL_DATABASE=koel_prod -d mysql:latest
```
Then you can pass the necessary environment variables and path to media folder to docker run command to launch the app using docker.

```
docker run -it \
--link=koel_mysql \
-e DB_CONNECTION=mysql \
-e DB_HOST=koel_mysql \
-e DB_DATABASE=koel_prod \
-e DB_USERNAME=root \
-e DB_PASSWORD=root \
-e ADMIN_EMAIL=someone@example.test \
-e ADMIN_NAME=admin \
-e ADMIN_PASSWORD=admin \
-v ~/Music:/media \
-p 8000:8000 \
nithyanatarajan/koel
```

You should be able to access the app at http://localhost:8000

**Alternate way to pass environment variables**

Instead of passing environment variables as arguments, you can add a settings.sh file in the format given in example/settings.sh.

For our example, the file may look like this.


```
export DB_CONNECTION=mysql
export DB_HOST=koel_mysql
export DB_DATABASE=koel_prod
export DB_USERNAME=root
export DB_PASSWORD=root
export ADMIN_EMAIL=someone@example.test
export ADMIN_NAME=admin
export ADMIN_PASSWORD=admin
```

You can add this file as a volume to docker run command.


```
-v $PWD/example:/config
```

For our example, the docker run command may look like this.

```
docker run -it \
--link=koel_postgres \
-v $PWD/example:/config
-v ~/Music:/media \
-p 8000:8000 \
nithyanatarajan/koel
```
