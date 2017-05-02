[![General Assembly Logo](https://camo.githubusercontent.com/1a91b05b8f4d44b5bbfb83abac2b0996d8e26c92/687474703a2f2f692e696d6775722e636f6d2f6b6538555354712e706e67)](https://generalassemb.ly/education/web-development-immersive)

# Shoop API

Make your art dance with SHOOP.

- Shoop App: https://sjruby.github.io/wdi-client-project-two/index.html
- Shoop Client Repo: https://github.com/sjruby/wdi-client-project-two

## About Shoop

Shoop allows users to generate random patters of two colors on a 28x28 grid.  Further it allows users to animate the board according Conways Game Of Life Rules.

## Data Model

The final ERD is below:
[Imgur](http://i.imgur.com/iJJHGzt.jpg?1)

## Dependinces:

-   [`rails-api`](https://github.com/rails-api/rails-api)
-   [`rails`](https://github.com/rails/rails)
-   [`active_model_serializers`](https://github.com/rails-api/active_model_serializers)
-   [`ruby`](https://www.ruby-lang.org/en/)
-   [`postgres`](http://www.postgresql.org)

## Local Setup

1.  Create a `.env` for sensitive settings (`touch .env`).
1.  Generate new `development` and `test` secrets (`bundle exec rake secret`).
1.  Store them in `.env` with keys `SECRET_KEY_BASE_<DEVELOPMENT|TEST>`
    respectively.
1.  In order to make requests to your deployed API, you will need to set
    `SECRET_KEY_BASE` in the environment of the production API (using `heroku
    config:set` or the Heroku dashboard).
1.  In order to make requests from your deployed client application, you will
    need to set `CLIENT_ORIGIN` in the environment of the production API (e.g.
    `heroku config:set CLIENT_ORIGIN https://<github-username>.github.io`).
1.  Setup your database with `bin/rake db:nuke_pave` or `bundle exec rake
    db:nuke_pave`.
1.  Run the API server with `bin/rails server` or `bundle exec rails server`.

## Structure

This template follows the standard project structure in Rails 4.

`curl` command scripts are stored in [`scripts`](scripts) with names that
correspond to API actions.

User authentication is built-in.

## Tasks

Developers should run these often!

-   `bin/rake routes` lists the endpoints available in your API.
-   `bin/rake test` runs automated tests.
-   `bin/rails console` opens a REPL that pre-loads the API.
-   `bin/rails db` opens your database client and loads the correct database.
-   `bin/rails server` starts the API.
-   `scripts/*.sh` run various `curl` commands to test the API. See below.

<!-- TODO -   `rake nag` checks your code style. -->
<!-- TODO -   `rake lint` checks your code for syntax errors. -->

## Authentication API

Below are the authentication actions and associated Sriptes

### Authentication

| Verb   | URI Pattern            | Controller#Action |
|--------|------------------------|-------------------|
| POST   | `/sign-up`             | `users#signup`    |
| POST   | `/sign-in`             | `users#signin`    |
| PATCH  | `/change-password/:id` | `users#changepw`  |
| DELETE | `/sign-out/:id`        | `users#signout`   |

#### POST /sign-up

Request:

```sh
curl http://localhost:4741/sign-up \
  --include \
  --request POST \
  --header "Content-Type: application/json" \
  --data '{
    "credentials": {
      "email": "'"${EMAIL}"'",
      "password": "'"${PASSWORD}"'",
      "password_confirmation": "'"${PASSWORD}"'"
    }
  }'
```

```sh
EMAIL=ava@bob.com PASSWORD=hannah scripts/sign-up.sh
```

Response:

```md
HTTP/1.1 201 Created
Content-Type: application/json; charset=utf-8

{
  "user": {
    "id": 1,
    "email": "ava@bob.com"
  }
}
```

#### POST /sign-in

Request:

```sh
curl http://localhost:4741/sign-in \
  --include \
  --request POST \
  --header "Content-Type: application/json" \
  --data '{
    "credentials": {
      "email": "'"${EMAIL}"'",
      "password": "'"${PASSWORD}"'"
    }
  }'
```

```sh
EMAIL=ava@bob.com PASSWORD=hannah scripts/sign-in.sh
```

Response:

```md
HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8

{
  "user": {
    "id": 1,
    "email": "ava@bob.com",
    "token": "BAhJIiVlZDIwZTMzMzQzODg5NTBmYjZlNjRlZDZlNzYxYzU2ZAY6BkVG--7e7f77f974edcf5e4887b56918f34cd9fe293b9f"
  }
}
```

#### PATCH /change-password/:id

Request:

```sh
curl --include --request PATCH "http://localhost:4741/change-password/$ID" \
  --header "Authorization: Token token=$TOKEN" \
  --header "Content-Type: application/json" \
  --data '{
    "passwords": {
      "old": "'"${OLDPW}"'",
      "new": "'"${NEWPW}"'"
    }
  }'
```

```sh
ID=1 OLDPW=hannah NEWPW=elle TOKEN=BAhJIiVlZDIwZTMzMzQzODg5NTBmYjZlNjRlZDZlNzYxYzU2ZAY6BkVG--7e7f77f974edcf5e4887b56918f34cd9fe293b9f scripts/change-password.sh
```

Response:

```md
HTTP/1.1 204 No Content
```

#### DELETE /sign-out/:id

Request:

```sh
curl http://localhost:4741/sign-out/$ID \
  --include \
  --request DELETE \
  --header "Authorization: Token token=$TOKEN"
```

```sh
ID=1 TOKEN=BAhJIiVlZDIwZTMzMzQzODg5NTBmYjZlNjRlZDZlNzYxYzU2ZAY6BkVG--7e7f77f974edcf5e4887b56918f34cd9fe293b9f scripts/sign-out.sh
```

Response:

```md
HTTP/1.1 204 No Content
```

### Users

| Verb | URI Pattern | Controller#Action |
|------|-------------|-------------------|
| GET  | `/users`    | `users#index`     |
| GET  | `/users/1`  | `users#show`      |

#### GET /users

Request:

```sh
curl http://localhost:4741/users \
  --include \
  --request GET \
  --header "Authorization: Token token=$TOKEN"
```

```sh
TOKEN=BAhJIiVlZDIwZTMzMzQzODg5NTBmYjZlNjRlZDZlNzYxYzU2ZAY6BkVG--7e7f77f974edcf5e4887b56918f34cd9fe293b9f scripts/users.sh
```

Response:

```md
HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8

{
  "users": [
    {
      "id": 2,
      "email": "bob@ava.com"
    },
    {
      "id": 1,
      "email": "ava@bob.com"
    }
  ]
}
```

#### GET /users/:id

Request:

```sh
curl --include --request GET http://localhost:4741/users/$ID \
  --header "Authorization: Token token=$TOKEN"
```

```sh
ID=2 TOKEN=BAhJIiVlZDIwZTMzMzQzODg5NTBmYjZlNjRlZDZlNzYxYzU2ZAY6BkVG--7e7f77f974edcf5e4887b56918f34cd9fe293b9f scripts/user.sh
```

Response:

```md
HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8

{
  "user": {
    "id": 2,
    "email": "bob@ava.com"
  }
}
```
## Shoop API

Below are the actions associated with CRUDING on the Boards resource

| Verb  | URI Pattern  | Controller#Action |
|-------|--------------|-------------------|
| GET   | `/boards`    | `boards#index`    |
| GET   | `/boards/1`  | `boards#show`     |
| POST  | `/boards`    | `boards#create`   |
| PATCH | `/boards/1`  | `boards#show`     |
| DELETE| `/boards/1`  | `boards#show`     |

#### GET /boards

Request:

```sh
curl --include --request GET https://protected-ridge-58465.herokuapp.com/boards \
  --header "Authorization: Token token=3481054d61508f98d6c40aeccfeacaa2" \
```
Response:

```md
HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8

{
  "boards": [
    {
      "id": 2,
      "title": "test"
      "cells":"[[{\"xCord\":0,\"yCord\":0,\"intialValue\":2},{\"xCord\":0,\"yCord\":1,\"intialValue\":1},{\"xCord\":0,\"yCord\":2,\"intialValue\":2}]]"
    },

      {
        "id": 2,
        "title": "NewBoard"
        "cells":"[[{\"xCord\":0,\"yCord\":0,\"intialValue\":2},{\"xCord\":0,\"yCord\":1,\"intialValue\":1},{\"xCord\":0,\"yCord\":2,\"intialValue\":2}]]"
      }
  ]
}
```


## Shoop API

Below are the actions associated with CRUDING on the Boards resource

| Verb  | URI Pattern  | Controller#Action |
|-------|--------------|-------------------|
| GET   | `/boards`    | `boards#index`    |
| GET   | `/boards/1`  | `boards#show`     |
| POST  | `/boards`    | `boards#create`   |
| PATCH | `/boards/1`  | `boards#show`     |
| DELETE| `/boards/1`  | `boards#show`     |

#### GET /boards

Request:

```sh
curl --include --request GET https://protected-ridge-58465.herokuapp.com/boards \
  --header "Authorization: Token token=3481054d61508f98d6c40aeccfeacaa2" \
```
Response:

```md
HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8

{
  "boards": [
    {
      "id": 2,
      "title": "test"
      "cells":"[[{\"xCord\":0,\"yCord\":0,\"intialValue\":2},{\"xCord\":0,\"yCord\":1,\"intialValue\":1},{\"xCord\":0,\"yCord\":2,\"intialValue\":2}]]"
    },

      {
        "id": 2,
        "title": "NewBoard"
        "cells":"[[{\"xCord\":0,\"yCord\":0,\"intialValue\":2},{\"xCord\":0,\"yCord\":1,\"intialValue\":1},{\"xCord\":0,\"yCord\":2,\"intialValue\":2}]]"
      }
  ]
}
```


#### GET /boards/:id
Request:

```sh
curl --include --request GET https://protected-ridge-58465.herokuapp.com/boards/2 \
  --header "Authorization: Token token=3481054d61508f98d6c40aeccfeacaa2" \
```

Response:

```md
HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8
{
"board": [
  {
    "id": 2,
    "title": "test"
    "cells":"[[{\"xCord\":0,\"yCord\":0,\"intialValue\":2},{\"xCord\":0,\"yCord\":1,\"intialValue\":1},{\"xCord\":0,\"yCord\":2,\"intialValue\":2}]]"
  }
  }
```

#### POST /boards
Request:

```sh
curl --include --request POST https://protected-ridge-58465.herokuapp.com/boards \
  --header "Authorization: Token token=3481054d61508f98d6c40aeccfeacaa2" \
 --data '{
      "board": {
        "title": "Ima board",
        "cells": ""[[{\"xCord\":0,\"yCord\":0,\"intialValue\":2},{\"xCord\":0,\"yCord\":1,\"intialValue\":1},{\"xCord\":0,\"yCord\":2,\"intialValue\":2}]]""
      }
    }'
```

Response:

```md
HTTP/1.1 201 Created
Content-Type: application/json; charset=utf-8


{
     "board": {
       "title": "Ima board",
       "cells": "[[{\"xCord\":0,\"yCord\":0,\"intialValue\":2},{\"xCord\":0,\"yCord\":1,\"intialValue\":1},{\"xCord\":0,\"yCord\":2,\"intialValue\":2}]]"
     }
   }

```
#### PATCH /boards/1

Request:

```sh
curl --include --request PATCH https://protected-ridge-58465.herokuapp.com/boards \
  --header "Authorization: Token token=3481054d61508f98d6c40aeccfeacaa2" \
 --data '{
      "board": {
        "title": "Ima UPDATED BOARD",
        "cells": ""[[{\"xCord\":0,\"yCord\":0,\"intialValue\":2},{\"xCord\":0,\"yCord\":1,\"intialValue\":1},{\"xCord\":0,\"yCord\":2,\"intialValue\":2}]]""
      }
    }'
```

Response:

```md
HTTP/1.1 204 No Content
```

#### DELETE /boards/1

Request:

```sh
curl --include --request DELETE https://protected-ridge-58465.herokuapp.com/boards/1 \
  --header "Authorization: Token token=3481054d61508f98d6c40aeccfeacaa2" \
```

Response:

```md
HTTP/1.1 204 No Content
```
