# Red Hat OpenShift Service Mesh in Action
This repository contains the content for a Homeroom-based workshop that
provides several exercises exploring Red Hat OpenShift Service Mesh (RHOSSM).

More information about Homeroom can be found [here](https://github.com/openshift-homeroom/lab-workshop-content).

## Contributing and Workflow
Contributions are most welcome. Please feel free to file issues.

When submitting pull requests, make sure to submit them against the `develop`
branch. Once merged, those changes will automatically be built into a new
image that lands on Quay.io: https://quay.io/repository/thoraxe/lab-ossm

## Code Repository Tagging
This repository is cloned as part of a provisioning process associated with
the Red Hat Product Demo System (RHPDS). As such, specific tags of this
repository will always be fetched such that RHPDS can lock to a point-in-time
of the repository. A normal versioning scheme that roughly aligns with the Service Mesh version should be used.

## Image Tagging
The container image on Quay.io will be built continually for both the
`master` and `develop` branches, resulting in image tags of `latest`,
`master`, and `develop`.

A manual tag for `production` should be created when an update to what RHPDS
deploys is desired. The tag for `production` should point at the image built
from whatever code repository tag is being deployed by RHPDS.
Example workflow:

* Pull request merged to `develop`
* Image built and tagged `develop` and `latest`
* Testing performed and, if successful:
* Pull request from `develop` to `master`
* Image built and tagged `master` and `latest`
* Tag `master` code repository with a version eg: 1.0.3
* Tag `master` image in Quay.io with `production` and `1.0.3`
* Ensure RHPDS production is cloning repository tag `1.0.3`

## Deploying to your own cluster
Deploying this experience to your own cluster is not particularly difficult.
You will need to understand the difference between the way the lab guide is
written and the names you give your own resources in your own cluster.

We are using the prefix `my-` for Project names. The lab guide will be using
your OpenShift username as the prefix. If you know your username is `john`,
then you should use the prefix `john-` when creating Projects. That being
said, you need cluster administrator access to install the operators.
However, *you **cannot** use the lab guide as `kubeadmin`*. The `kubeadmin`
user is an alias for `kube:admin`, and the colon causes the lab guide to
attempt to use a serviceaccount with a colon, which is invalid, and breaks
the lab guide.

If you don't already have real users in your cluster, you can use an
[htpasswd identity
provider](https://docs.openshift.com/container-platform/4.4/authentication/identity_providers/configuring-htpasswd-identity-provider.html)
to create users easily and quickly.

There are three main steps to getting the lab going in your cluster.

### Installing the Service Mesh operators and Control Plane

1. Install an OpenShift 4 environment. You will need cluster-administrator access.
1. Follow the documentation for [installing the service mesh operators](https://docs.openshift.com/container-platform/4.4/service_mesh/service_mesh_install/installing-ossm.html#installing-ossm)
1. Create a project called `my-smcp` where the Service Mesh control plane will be installed.
1. Follow the documentation for [installing the service mesh control plane](https://docs.openshift.com/container-platform/4.4/service_mesh/service_mesh_install/installing-ossm.html#ossm-control-plane-deploy-operatorhub_installing-ossm) and install it into your `my-smcp` project (not `istio-system`).
1. While you are waiting for the control plane to install, create a new project called `my-tutorial`.
1. Follow the documentation for [creating the member role](https://docs.openshift.com/container-platform/4.4/service_mesh/service_mesh_install/installing-ossm.html#ossm-member-roll-create-console_installing-ossm) being sure to use the project you created (`my-tutorial`) and to do so *inside* the `my-smcp` project.

Wait for the above steps to complete before continuing. You can track the
progress of the Service Mesh control plane installation by looking at the
control plane details (assuming defaults):

Installed Operators -> `my-smcp` -> Red Hat OpenShift Service Mesh -> Istio Service Mesh Control Plane -> `basic install`

In the Conditions area, you will see that _Installed_, _Reconciled_, and
_Ready_ are all _True_ once the installation is successful.

### Deploying the tutorial application
It will be easiest to do this from the command line. Note that the following
scriptlet assumes you have created a project called `my-tutorial`:

```
oc create -n my-tutorial -f https://gist.githubusercontent.com/thoraxe/a189ade0d2dd19c8c275179b48577117/raw/02c4ea130cb6b1ebd83c7fd7a4cb2824fac179b7/curl.yaml 
oc create -n my-tutorial -f https://gist.githubusercontent.com/thoraxe/a189ade0d2dd19c8c275179b48577117/raw/02c4ea130cb6b1ebd83c7fd7a4cb2824fac179b7/customer.yaml
oc create -n my-tutorial -f https://gist.githubusercontent.com/thoraxe/a189ade0d2dd19c8c275179b48577117/raw/02c4ea130cb6b1ebd83c7fd7a4cb2824fac179b7/gateway.yaml
oc create -n my-tutorial -f https://gist.githubusercontent.com/thoraxe/a189ade0d2dd19c8c275179b48577117/raw/02c4ea130cb6b1ebd83c7fd7a4cb2824fac179b7/preference.yaml
oc create -n my-tutorial -f https://gist.githubusercontent.com/thoraxe/a189ade0d2dd19c8c275179b48577117/raw/0f55e6623bdd0a32b31be92f5b0869a0d7abf648/recommendation.yaml
```

### Deploying the lab guide

1. Create a Project to hold the lab guide -- `lab-ossm`
1. You will need the cluster's default route subdomain to use with `new-app`. The following will put it into a `bash` variable:

        export SUBDOMAIN=$(oc get ingresses.config.openshift.io cluster -o jsonpath='{.spec.domain}')

1. Then, use the `new-app` subcommand of the `oc` CLI to deploy the lab guide:

        oc new-app -n lab-ossm https://raw.githubusercontent.com/openshift-homeroom/workshop-spawner/7.1.0/templates/hosted-workshop-production.json \
        --param CLUSTER_SUBDOMAIN="$SUBDOMAIN" \
        --param SPAWNER_NAMESPACE="lab-ossm" \
        --param WORKSHOP_NAME="lab-ossm" \
        --param WORKSHOP_IMAGE="quay.io/thoraxe/lab-ossm:production" \
        --param OC_VERSION="4.3"

Take special note of the route that is created. It will be something like `lab-ossm-lab-ossm.xxxxxx`. 

Access the lab guide and then make sure to login using the username and
password you use to access the OpenShift environment. Since you needed
cluster administrative access to install the Service Mesh operators, you're
probably fine.

### Caveats
None of the variables are appropriately set in this environment. You will
need to pay careful attention to all commands to make sure they look like
they will evaluate correctly. The various bash scripts use an environment
variable `JUPYTERHUB_USER` as a prefix to Project names (see the note above).
Make sure it is set correctly in the terminals.