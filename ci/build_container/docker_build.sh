#!/bin/bash

[[ -z "${LINUX_DISTRO}" ]] && LINUX_DISTRO="ubuntu"

# We need //bazel/... and WORKSPACE for the build, but it's not in ci/build_container. Using Docker
# relative path workaround from https://github.com/docker/docker/issues/2745#issuecomment-253230025
# to get this to work.
tar cf - . -C ../../ bazel WORKSPACE \
  | docker build -f Dockerfile-${LINUX_DISTRO} -t lyft/envoy-build-${LINUX_DISTRO}:$CIRCLE_SHA1 -
