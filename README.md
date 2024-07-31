# s6-overlay

Add [s6-overlay](https://github.com/just-containers/s6-overlay) to your docker images with a single line.

## Usage

To use s6-overlay in your Dockerfile, you can follow this simple example:

```dockerfile
FROM debian

COPY --from=dsymbol/s6-overlay:3.2.0.0 /s6 /

ENTRYPOINT ["/init"]
```

## Supported Platforms

- linux/386
- linux/amd64
- linux/arm/v7
- linux/arm/v6
- linux/arm64
- linux/ppc64le
- linux/riscv64
- linux/s390x
