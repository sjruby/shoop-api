#!/bin/bash

# curl --include --request POST https://protected-ridge-58465.herokuapp.com/boards \

curl --include --request POST http://localhost:4741/boards \
  --header "Authorization: Token token=BAhJIiU3NGZhYWEyMTc4NGU1OWVlMzFjNTRhNzE4YzY1M2YzNAY6BkVG--f5ff9e56f311c2231a35237caaa89cd643d7834a" \
  --data '{
    "board": {
      "title": "A Secong Curl Board",
      "cells": "test"
  }
  }'

echo
