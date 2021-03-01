3scale must-gather
=================

`must-gather` is a tool built on top of [OpenShift must-gather](https://github.com/openshift/must-gather)
that expands its capabilities to gather 3scale information.

### Usage
```sh
oc adm must-gather --image=quay.io/spoole/3scale-must-gather
```

The command above will create a local directory with a dump of the 3scale state.
Note that this command will only get data related to the 3scale part of the OpenShift cluster.

You will get a dump of:
- The 3scale Operator namespaces (and its children objects)
- The 3scale APICast Gateway Operator namespaces (and its children objects)
- The APIcast configurations fetched from both the Admin Portal and the APIcast gateway
- All of the information for the Openshift Nodes in the cluster (i.e. oc adm inspect node <node-name>)

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
  docker tag 3scale-must-gather <opeshift-registry-domain>/<namespace>/3scale-must-gather
  ```
- Login to the openshift internal registry
  ```
  docker login -u `oc whoami` -p `oc whoami -t` <opeshift-registry-domain>
  ```
  *If using crc or any local environment where `oc whoami` returns `kube:admin`, you will need to change the `-u` option to `kubeadmin`.*
- Push the image to the internal registry
  ```
  docker push <opeshift-registry-domain>/<namespace>/3scale-must-gather
  ```
- Test the image
  ```
  oc adm must-gather --image-stream=<namespace>/3scale-must-gather
  ```