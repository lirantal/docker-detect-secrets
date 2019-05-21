# About

A docker image to enable invoking of Yelp's [detect-secrets](https://github.com/Yelp/detect-secrets) hook command without having to install the python package.

# Usage

## Detecting secrets in a project

Runs the `detect-secrets-hook` command for a given git project, with the following options:

- The current directory is assumed to be the .git root directory and so the volume mounts `pwd` to the container's `/usr/src/app` directory
- `src/index.js` and `src/component.js` are files for which will be tested for secrets

```bash
docker run -it --rm --name detect-secrets --volume `pwd`:/usr/src/app lirantal/detect-secrets "src/index.js" "src/component.js"
```

## Detecting secrets in a project that has a baseline

If a project has a previously created `.secrets-baseline` it can be passed as a command argument to the container:

```bash
docker run -it --rm --name detect-secrets --volume `pwd`:/usr/src/app lirantal/detect-secrets "--baseline .secrets-baseline" "src/index.js"
```

## Detecting secrets in a monorepo style project

For projects which exhibit a structure such as:

```
| app
  |_ .git/
  |_ client/
  |_ server/
       |_ .secrets-baseline
```

it is required to tweak the execution of `detect-secrets-hook` when it runs in the container image to simulate the exact scenario of it running inside the nested `server/` directory, while mounting the top level application directory:

```bash
docker run -it --rm --name detect-secrets --volume /path/to/root/project/dir:/usr/src/app --workdir "/usr/src/app/server" lirantal/detect-secrets "src/index.js"
```

# Developing

Building the image from the Dockerfile and then you may execute it locally:

```bash
docker build --build-arg BUILD_DATE=$(date -u +'%Y-%m-%dT%H:%M:%SZ') --tag detect-secrets lirantal/detect-secrets .
```

# Author

Liran Tal <liran@snyk.io>
