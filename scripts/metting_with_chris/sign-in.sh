curl --include --request POST http://localhost:4741/sign-in \
  --header "Content-Type: application/json" \
  --data '{
    "credentials": {
      "email": "ShoopsObjectsSuck",
      "password": "test"
    }
  }'

echo
