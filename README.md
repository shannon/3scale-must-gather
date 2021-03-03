3scale must-gather
=================

`must-gather` is a tool built on top of [OpenShift must-gather](https://github.com/openshift/must-gather)
that expands its capabilities to gather 3scale information.

### Usage
```sh
oc adm must-gather --image=quay.io/3scale/must-gather
```

The command above will create a local directory with a dump of the 3scale state.
Note that this command will only get data related to the 3scale part of the OpenShift cluster.

You will get a dump of:
- The 3scale Operator namespaces (and its children objects)
  - i.e. Output from command `oc adm inspect ns/<namespace>` for all namespaces that contain a APIManager resource
- The 3scale APICast Gateway Operator namespaces (and its children objects)
  - i.e. Output from command `oc adm inspect ns/<namespace>` for all namespaces that contain a APIcast resource
- All 3scale APIManager, APIManagerBackup, APIManagerRestore, and APIcast custom resources
  - i.e. Output from command `oc adm inspect --all-namespaces <resource>` for all 3scale resources above
- All of the information for the Openshift Nodes in the cluster 
  - i.e. `oc adm inspect node/<node-name>`
- The APIcast configurations fetched from both the Admin Portal and the APIcast gateway

In order to get data about other parts of the cluster (not specific to 3scale) you should
run `oc adm must-gather` (without passing a custom image). Run `oc adm must-gather -h` to see more options.

### Development
You can build the image locally using the Dockerfile included.

#### To test the image in a local openshift environment

- Build the image
  ```
  docker build -t 3scale-must-gather .
  ```
- Create the image stream
  ```
  oc create imagestream 3scale-must-gather
  ```
- Tag image with internal registry domain
  ```
  docker tag 3scale-must-gather <openshift-registry-domain>/<namespace>/3scale-must-gather
  ```
- Login to the openshift internal registry
  ```
  docker login -u `oc whoami` -p `oc whoami -t` <openshift-registry-domain>
  ```
  *If using crc or any local environment where `oc whoami` returns `kube:admin`, you will need to change the `-u` option to `kubeadmin`.*
- Push the image to the internal registry
  ```
  docker push <openshift-registry-domain>/<namespace>/3scale-must-gather
  ```
- Test the image
  ```
  oc adm must-gather --image-stream=<namespace>/3scale-must-gather
  ```

### Publishing

- Build and tag the image for quay.io
  ```
  docker build -t 3scale-must-gather .
  ```
- Tag image for quay.io
  ```
  docker tag 3scale-must-gather quay.io/3scale/must-gather:latest
  docker tag 3scale-must-gather quay.io/3scale/must-gather:<version>
  ```
  *Version should only include major.minor (i.e. 2.9)*
- Login to the quay.io registry
  ```
  docker login -u `<username` -p `<token>` quay.io
  ```
- Push the image to the quay.io registry
  ```
  docker push quay.io/3scale/must-gather:latest
  docker push quay.io/3scale/must-gather:<version>
  ```