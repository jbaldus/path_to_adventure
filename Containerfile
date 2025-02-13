
# Based on the ubuntu-toolbox image, since it includes a normal set of 
# ubuntu tools. I haven't spent the time to figure out how to get everything
# to work with the bare ubuntu image
FROM quay.io/toolbx/ubuntu-toolbox:22.04
#FROM ubuntu:latest

# Make sure the needed software is installed
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
        sudo \
        man-db \
        nano \
        vim \
        tree && \
    rm -rd /var/lib/apt/lists/* && \ 
    apt-get clean;

# Now create a regular user to play the game with
RUN adduser --disabled-password --gecos '' user && \
    adduser user sudo && \
    echo 'user ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers.d/user

USER user

WORKDIR /app

COPY path_to_adventure/ .

# Need to modify ownership and permissons for the game to work
RUN sudo chown -R user:user /app;

CMD ["/bin/bash", "--init-file", ".init.sh", "-i"]


