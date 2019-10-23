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
The container image on Quay.io will be built continually for both the `master` and `develop` branches, resulting in image tags of `latest`, `master`, and `develop`.

A manual tag for `production` should be created when an update to what RHPDS deploys is desired. The tag for `production` should point at the image built from whatever code repository tag is being deployed by RHPDS.

Example workflow:

* Pull request merged to `develop`
* Image built and tagged `develop` and `latest`
* Testing performed and, if successful:
* Pull request from `develop` to `master`
* Image built and tagged `master` and `latest`
* Tag `master` code repository with a version eg: 1.0.3
* Tag `master` image in Quay.io with `production` and `1.0.3`
* Ensure RHPDS production is cloning repository tag `1.0.3`
