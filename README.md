# Dockerized meld

## How to run

In your terminal:

```sh
docker run --rm -it -p 8080:8080 -v /compare/this:/a -v /to/this:/b pmjohann/meld
```

Then visit [http://localhost:8080](http://localhost:8080) in your browser!
