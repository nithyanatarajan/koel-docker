# koel-docker

This is a docker image for [koel](https://github.com/phanan/koel) app. The main idea is to reduce the installation steps and easily launch the application so that we can start enjoying music as soon as possible :)


### To run mysql in background

```
docker run 
--name=koel_mysql 
-e MYSQL_ROOT_PASSWORD=root 
-e MYSQL_DATABASE=koel_prod 
-d 
mysql:8
```

### To run the app
```
docker run 
-it 
-v $PWD/config:/config 
--link=koel_mysql 
-p 8000:8000 
local/koel
```
