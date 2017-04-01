# grav-docker
Grav docker implementation

## Usage

1. Build the grav docker image: `docker build -t grav .`
2. Start the docker container `docker-compose up -d`
3. Access your grav site on http://localhost

## Extending for your projects

This repository is automatically build and hosted on docker hub [ **webideas/grav-docker-apache** ]
To extend you can use the following example code:

```
FROM webideas/grav-docker-apache:1.1.17

RUN bin/gpm install featherlight

COPY web/themes/my-theme /var/www/html/user/themes/my-theme

CMD ["apache2-foreground"]
```
