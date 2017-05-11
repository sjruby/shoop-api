#!/bin/bash

# curl --include --request POST https://protected-ridge-58465.herokuapp.com/boards \

curl --include --request POST http://localhost:4741/boards \
  --header "Content-Type: application/json" \
  --data '{"boards":[{"id":1,"title":"this is the board",


  "cells":"}]}'

echo
