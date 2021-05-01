## Environment variables

All the environment variables will be hosted in just one place. To do so, some changes were nedded in order to detect the environments in all the places(docker-compose, docker, code).

![alt text](readme_static/environment_variables.png)

<br>

## Media files

We use the storages package to handle the media files

![alt text](readme_static/media_files.png)

## HTTPS

This implementation support HTTPS by Traefik. The following diagram explain how this work.

![alt text](readme_static/https.png)

Where basically we created two **entrypoints** that are listening in the port 80 and 443. Also when traefic recieve the request from 443, it will ask to the **resolver** that handle the certificate with [letsencrypt](https://letsencrypt.org/es/) and check if the domain has https. Finally if everything goes fine, it will redirect the request to the proper server that is linked to the router(in this case, gunicorn).

<br>

## Zero Downtime

To keep the server up and running. We used the color(green/blue) system. Were basicaly we run a new server with the new code(blue), then we start routing the requests to that server, and finally, we turn of the old server that was running(green)

To do :)