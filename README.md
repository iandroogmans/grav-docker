# grav-docker
Grav docker implementation

## Versioning
This repository follows the official versioning of grav, so to install grav 1.2.0 you can use **webideas/grav-docker-apache:1.2.0** or allways install the up to date version with **latest** tag.

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
