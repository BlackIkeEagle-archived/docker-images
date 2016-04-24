docker.herecura.eu/alpine
=========================

This will be the base image of most of my future docker images.

usage
-----

This main image will have only one user: root. All the other default users are
deleted.

user-cleanup
------------

The image will contain a user cleanup script in `/container/user-cleanup.sh`.
This script removes all users and groups except for root

user-setup
----------

The images using this image as base can just add a `/container/user-config.sh`
so there is a possibility to create a needed user in the newly built image. Its
necessary to call the `/container/user-setup.sh` from your entrypoint script.

container
---------

Since the `container` folder will exist in this "base"-image, other images can
easily add their helper scripts in that directory to avoid clutter in the root
folder.
