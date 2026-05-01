#!/bin/bash

export AWS_ACCESS_KEY_ID=$(grep r2_access_key r2 | cut -d'"' -f2)
export AWS_SECRET_ACCESS_KEY=$(grep r2_secret_key r2 | cut -d'"' -f2)

terraform "$@"
