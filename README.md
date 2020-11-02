# docker-wine

This repository contains a definition of a Docker image with `wine` 5.0 installed.

Its primary purpose is to be used to run 32-bit Windows applications.

The image is based on `i386/debian:buster-slim`, which is 32-bit Debian Buster (Debian 10).

While it's possible to build this image using 64-bit architecture and to run 32-bit apps in it, `wine` still will require 32-bit dependencies, which will just double the image size. Hence, for the sake of space usage, 32-bit architecture is used inside of the container.


## Public builds

This Docker image is available as `il2horusteam/wine` at [Docker Hub](https://hub.docker.com/r/il2horusteam/wine):

``` shell

docker pull il2horusteam/wine

```


## Build Args

The image has several arguments which can be changed during the build time:

| Arg Name      | Default Value | Description                      |
| ------------- | ------------- | -------------------------------- |
| `WINEVERSION` | `5.0`         | Version of `wine` to install     |
| `WINEUID`     | `999`         | `UID` to use for the user `wine` |
| `WINEGID`     | `999`         | `GID` to use for the user `wine` |


## Deliverables

The image provides:

* `wine` of version `5.0` installed in 32-bit runtime.
* `wine` group.
* `wine` user belonging to the `wine` group with home dir at `/home/wine`. No login shell.
* Configured 32-bit `wine` prefix at `/home/wine/.wine32`.
* ENV variables:

  | Var Name       | Used by `wine`? | Value                 | Description |
  | -------------- | --------------- | --------------------- | ----------- |
  | `WINEVERSION`  | no              | `5.0`                 | Version of installed `wine`; defaults to `$WINEVERSION` build arg |
  | `WINEHOME`     | no              | `"/home/wine"`        | Path to home directory of the `wine` user |
  | `WINEPREFIX`   | yes             | `"$WINEHOME/.wine32"` | Path to `wine` configs and installed Windows apps |
  | `WINEARCH`     | yes             | `"win32"`             | Used by `wine` tools |
