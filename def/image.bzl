# Copyright 2018 The Kubernetes Authors.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# tags appends default tags to name
#
# In particular, names is a {image_prefix: image_target} mapping, which gets
# expanded into three full image paths:
#   image_prefix:latest
#   image_prefix:latest-{BUILD_USER}
#   image_prefix:{DOCKER_TAG}
# (See hack/print-workspace-status.sh for how BUILD_USER and DOCKER_TAG are created.
#
# Concretely, tags(this=":that-image", foo="//bar") will return:
#   {
#     "this:latest": ":that-image",
#     "this:latest-fejta": ":that-image",
#     "this:20180203-deadbeef": ":that-image",
#     "foo:latest": "//bar",
#     "foo:latest-fejta": "//bar",
#     "foo:20180203-deadbeef", "//bar",
#   }
def tags(targets):
    outs = {}
    for img, target in targets.items():
        outs["%s:{DOCKER_TAG}" % img] = target
        outs["%s:latest-{BUILD_USER}" % img] = target
        outs["%s:latest" % img] = target
    return outs

def tags_arm64(targets):
    outs = {}
    for img, target in targets.items():
        outs["%s:{DOCKER_TAG}-arm64" % img] = target
        outs["%s:latest-{BUILD_USER}-arm64" % img] = target
        outs["%s:latest-arm64" % img] = target
        outs["%s:arm64" % img] = target
    return outs

def tags_ppc64le(targets):
    outs = {}
    for img, target in targets.items():
        outs["%s:{DOCKER_TAG}-ppc64le" % img] = target
        outs["%s:latest-{BUILD_USER}-ppc64le" % img] = target
        outs["%s:latest-ppc64le" % img] = target
        outs["%s:ppc64le" % img] = target
    return outs

def tags_s390x(targets):
    outs = {}
    for img, target in targets.items():
        outs["%s:{DOCKER_TAG}-s390x" % img] = target
        outs["%s:latest-{BUILD_USER}-s390x" % img] = target
        outs["%s:latest-s390x" % img] = target
        outs["%s:s390x" % img] = target
    return outs
