#!/bin/bash

DBD_BIN_DIR="$(dirname "$0")"

source "${DBD_BIN_DIR}/setenv.sh"

cd "${DBD_BIN_DIR}/../elt/elt.postgres"

dbd run .