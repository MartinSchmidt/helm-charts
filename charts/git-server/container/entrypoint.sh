#!/bin/bash

set -o errexit

main() {
  exec nginx
}

main "$@"
