# Copyright 2021 Red Hat, Inc.
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

# This file is derived from the following:
# https://github.com/maistra/istio-must-gather/blob/maistra-2.1/Dockerfile

# This file has been modified to add a local copy of the version script into the
# image, to make developement easier.

FROM quay.io/openshift/origin-must-gather:4.6

# Save original gather script
RUN mv /usr/bin/gather /usr/bin/gather_original

# Use our gather script in place of the original one
COPY gather_3scale /usr/bin/gather
COPY version /usr/bin/version

ENTRYPOINT /usr/bin/gather
