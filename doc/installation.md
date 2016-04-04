# Install Intercity Next on your production server

## Install Docker

You need to have Docker installed on your main server, you can do so by running
the following command:

`wget -nv -O - https://get.docker.com/ | sh`

## Install Intercity Next using Intercity Docker

In order to provide an easy way to install Intercity on your server, we provide
Intercity-Docker. This is an installation and update manager for Intercity.

1. Clone Intercity-Docker to `/var/intercity`: `$ git clone git@github.com:intercity/intercity-docker.git /var/intercity`
1. Go to the cloned folder: `cd /var/intercity`
1. Check out the latest release: `git checkout tags/v0.2.0`
1. Copy the sample container config: `cp samples/app.yml containers/`
1. Open the app.yml and change the required params: `vi containers/app.yml`
1. Save the file and run the bootstrap command: `./launcher bootstrap app`
1. Start Intercity: `./launcher start app`
1. Go to the IP/domain of your server in the browser and perform the first run
   setup
1. DONE!

If you have problems with the installation, please open an [issue on Github][gh-issues]

[gh-issues]: https://github.com/intercity/intercity-next/issues
