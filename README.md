version: "3"

services:
  github-runner-1:
    restart: always
    image: github-runner:2
    build:
      context: .
      dockerfile: Dockerfile
    environment:
      REPO_URL: https://github.com/xxx
      RUNNER_NAME: github-runner-1
      RUNNER_TOKEN: xxxxxxxxxxxxxxx
      RUNNER_WORKDIR: /tmp/runner/work
      ORG_RUNNER: 'false'
      LABELS: self-hosted-ubuntu
    volumes:
      - "/var/run/docker.sock:/var/run/docker.sock"
      - "/tmp/runner:/tmp/runner"
