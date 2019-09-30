# docker-wrk2

Run [wrk2](https://github.com/giltene/wrk2) in a Docker container.

Examples:

```
docker rm --rm -t gildas/wrk2 -t5 -c20 -d30 -R2000 https://www.google.com
```
