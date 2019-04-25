#!/usr/bin/env bash

echo "== Setting up Intercity Next"

if [ ! -x "$(command -v curl)" ]; then
  echo "!! You need to have 'curl' installed to proceed."
  echo "   -> sudo apt-get install curl"
  exit 1
fi

# Install docker if necessray
if [ ! -x "$(command -v docker)" ]; then
  echo "-- Installing docker..."
  curl -fsSL get.docker.com -o get-docker.sh
  sh get-docker.sh
else
  echo "-- $(docker -v)"
fi

# Install docker-compose
if [ ! -x "$(command -v docker-compose)" ]; then
  echo "-- Installing docker-compose"
  curl -L https://github.com/docker/compose/releases/download/1.22.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
  chmod +x /usr/local/bin/docker-compose
else
  echo "-- $(docker-compose -v)"
fi

# Fetching docker-compose.yml
if [ ! -f "./docker-compose.yml"]; then
  echo "!! No docker-compose.yml yet, fetching from GitHub."
  curl -L https://github.com/intercity/intercity-next/docker-compose.yml -o ./docker-compose.yml
else
  echo "-- docker-compose.yml"
fi

# Validate and load intercity.env
if [ ! -f "./intercity.env" ]; then
  echo "!! No intercity.env found, generating one for you now."
  secret_key_base=`tr -dc 'a-f0-9' < /dev/urandom | head -c32`
  read -p 'Intercity Next FQDN (e.g. intercity.example.com): ' intercity_fqdn
  read -p 'Letsencrypt email address (e.g. user@example.com): ' letsencrypt_email

  echo INTERCITY_FQDN=$intercity_fqdn >> intercity.env
  echo LETSENCRYPT_EMAIL=$letsencrypt_email >> intercity.env
  echo SECRET_KEY_BASE=$secret_key_base >> intercity.env

  echo "-- Written configuration to intercity.env"
fi

echo "-- Loading configuration from intercity.env"
source intercity.env

echo "-- Deploying Intercity Next to https://$INTERCITY_FQDN"

# Boot up with docker compose
docker-compose up -d

echo "-- Waiting for Intercity Next to fully boot up. This may take a few minutes."

until $(curl --output /dev/null --silent --head --fail https://$INTERCITY_FQDN); do
    printf '.'
    sleep 5
done

echo
echo
echo "Intercity Next has been started and is ready for departure!"
echo 
echo "Your Intercity is waiting for you at https://$INTERCITY_FQDN"
echo
echo "You can stop Intercity Next with:     docker-compose stop"
echo "Logs can be viewed with:              docker-compose logs"
echo
