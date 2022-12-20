# DevOpsCorner Demo

Demo Repository for PoC (Proof-of-Concepts)

![all contributors](https://img.shields.io/github/contributors/devopscorner/demo)
![tags](https://img.shields.io/github/v/tag/devopscorner/demo?sort=semver)
[![demo pulls](https://img.shields.io/docker/pulls/devopscorner/demo.svg?label=demo%20pulls&logo=docker)](https://hub.docker.com/r/devopscorner/demo/)
![download all](https://img.shields.io/github/downloads/devopscorner/demo/total.svg)
![view](https://views.whatilearened.today/views/github/devopscorner/demo.svg)
![clone](https://img.shields.io/badge/dynamic/json?color=success&label=clone&query=count&url=https://raw.githubusercontent.com/devopscorner/demo/master/clone.json?raw=True&logo=github)
![issues](https://img.shields.io/github/issues/devopscorner/demo)
![pull requests](https://img.shields.io/github/issues-pr/devopscorner/demo)
![forks](https://img.shields.io/github/forks/devopscorner/demo)
![stars](https://img.shields.io/github/stars/devopscorner/demo)
[![license](https://img.shields.io/github/license/devopscorner/demo)](https://img.shields.io/github/license/devopscorner/demo)

---

## Development

### Prequests

- Install jq libraries

  ```
  apt-get install -y jq
  ```

- Install golang dependencies

  ```
  ## Change workspace path to `src` folder from root repository
  cd src
  go mod init
  go mod tidy
  ```

### Runnning

```
## Change workspace path to `src` folder from root repository
cd src
go run main.go
```

## API Test

- Get Books

```
GET    : /books
         curl --request GET \
            --url 'http://localhost:8080/books' \
            --header 'Content-Type: application/json' | jq
```

- Add Book 1

```
POST   : /books
         curl --request POST \
            --url 'http://localhost:8080/books' \
            --header 'Content-Type: application/json' \
            --data '{
                "title": "Mastering Go: Create Golang production applications using network libraries, concurrency, and advanced Go data structures",
                "author": "Mihalis Tsoukalos"
            }' | jq
```

- Add Book 2

```
POST   : /books
         curl --request POST \
            --url 'http://localhost:8080/books' \
            --header 'Content-Type: application/json' \
            --data '{
                "title": "Introducing Go: Build Reliable, Scalable Programs",
                "author": "Caleb Doxsey"
            }' | jq
```

- Add Book 3

```
POST   : /books
         curl --request POST \
            --url 'http://localhost:8080/books' \
            --header 'Content-Type: application/json' \
            --data '{
                "title": "Learning Functional Programming in Go: Change the way you approach your applications using functional programming in Go",
                "author": "Lex Sheehan"
            }' | jq
```

- Edit Book 3

```
PATCH   : /books/3
         curl --request PATCH \
            --url 'http://localhost:8080/books/3' \
            --header 'Content-Type: application/json' \
            --data '{
                "title": "Test Golang",
                "author": "ZeroC0D3Lab"
            }' | jq
```

- Delete Book 3

```
DELETE   : /books/3
         curl --request DELETE \
            --url 'http://localhost:8080/books/3' \
            --header 'Content-Type: application/json' | jq
```