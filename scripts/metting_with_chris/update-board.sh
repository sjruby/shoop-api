#!/bin/bash

# curl --include --request POST https://protected-ridge-58465.herokuapp.com/boards \

curl --include --request PATCH http://localhost:4741/boards/129 \
  --header "Authorization: Token token=BAhJIiU3NGZhYWEyMTc4NGU1OWVlMzFjNTRhNzE4YzY1M2YzNAY6BkVG--f5ff9e56f311c2231a35237caaa89cd643d7834a" \
  --data '{
    "boards": {
      "title": "Updated Board",
      "cells": "test"
    }
  }'

echo


curl --include --request PATCH http://localhost:4741/boards/129 \
  --data '{
    "boards": {
      "title": "Updated Board",
      "cells": "test"
    }
  }'
