#!/bin/bash

OC_VERSION="v3.9.0-alpha.3"
GIT_STRING="-78ddc10"

#subscription-manager register --username openshift-enterprise
#subscription-manager attach --pool 8a85f98b621f8a6b01621fac0f790155
#subscription-manager repos --disable="*"
#subscription-manager repos \
#    --enable="rhel-7-server-rpms" \
#    --enable="rhel-7-server-extras-rpms" \
#    --enable="rhel-7-server-ose-3.7-rpms" \
#    --enable="rhel-7-fast-datapath-rpms"
#yum -y install vim-enhanced docker wget git net-tools bind-utils iptables-services bridge-utils bash-completion kexec-tools sos psacct
#systemctl enable docker
#systemctl start docker
#cd
wget https://github.com/openshift/origin/releases/download/$OC_VERSION/openshift-origin-server-$OC_VERSION$GIT_STRING-linux-64bit.tar.gz
tar -xzvf openshift-origin-server-$OC_VERSION$GIT_STRING-linux-64bit.tar.gz
#mv openshift-origin-server-v3.9.0-alpha.3-78ddc10-linux-64bit/oc /usr/bin
#restorecon -rv /usr/bin

