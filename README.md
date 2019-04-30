# docker-stateful-hello

Simple stateful "hello-world" docker example, written for node.js.

Available on [docker hub](https://hub.docker.com/r/eengstrom/stateful-hello).

# run locally (no docker)

```bash
node server.js &
curl http://localhost:3000/
curl http://localhost:3000/?msg="Hola%20Mundo"
kill %1
```

# Build Docker image

```
docker build -t 'stateful-hello' .
```

# Run via Docker

```bash
mkdir data
docker run --name 'hello' -p 3000:3000 -d --rm stateful-hello
curl http://localhost:3000/?msg="Ciao%20mondo"
curl http://localhost:3000/?msg="Hallo%20Welt"
docker stop hello
```

# Run via Docker with "persistent storage"
```bash
mkdir -p data
echo 42 > data/stateful-hello.txt
docker run --name 'hello' -p 3000:3000 -d --rm -v $(pwd)/data:/app/data stateful-hello
curl http://localhost:3000/?msg="Bonjour%20monde"
docker stop hello
docker run --name 'hello' -p 3000:3000 -d --rm -v $(pwd)/data:/app/data stateful-hello
curl http://localhost:3000/?msg="Hej%20världen"
curl http://localhost:3000/?msg="Farvel%20onde%20verden"
docker stop hello
```
