#!/bin/bash

curl --include --request PATCH http://localhost:4741/boards/1 \
  --header "Content-Type: application/json" \
  --data '{"board":{"title":"My UPDATED BOARD","cells":"[{x_cord:0, y_cord:0, value:1},{x_cord:0,y_cord:1,value:2}]"}}'

echo
