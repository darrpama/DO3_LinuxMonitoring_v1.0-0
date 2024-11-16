#!/bin/bash
#
# There is function to print errors into the STDERR (&2)
#
# if ! do_something; then
#   err "Unable to do_something"
#   exit 1
# fi

err() {
  echo "[$(date +'%Y-%m-%dT%H:%M:%S%z')]: $*" >&2
}
