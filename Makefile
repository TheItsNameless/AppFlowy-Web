.PHONY: image

IMAGE_NAME = appflowy-web-app
IMAGE_TAG = latest

build:
    pnpm install
    pnpm run build

image: build
    cp .env deploy/
    rm -rf deploy/dist
    cp -r dist deploy/
    DOCKER_BUILDKIT=1 docker buildx create --use
    docker buildx build --platform linux/amd64,linux/arm64 -t $(IMAGE_NAME):$(IMAGE_TAG) deploy --push
