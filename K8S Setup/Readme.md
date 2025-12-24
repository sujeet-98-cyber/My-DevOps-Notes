cat << 'EOF' > README.md
# Kubernetes Cluster Setup Guide

This document provides step-by-step instructions to set up a Kubernetes cluster using kubeadm, including master, worker, and join execution via SSH.

---

## Step 1: Login to Master Node

- SSH into your master node.
- Ensure all other nodes (master and worker nodes) are reachable via SSH from the master node.
- If SSH access is not working, fix it manually before proceeding.

Command:
  ssh <master-node-ip>

---

## Step 2: Pre-Setup

Commands to Run:

1. Create the pre_setup.sh script:
   touch pre_setup.sh

2. Make it executable:
   chmod +x pre_setup.sh

3. Run the script:
   ./pre_setup.sh

---

## Step 3: Master Setup

Commands to Run:

1. Create the master-setup.sh script:
   touch master-setup.sh

2. Make it executable:
   chmod +x master-setup.sh

3. Run the script:
   ./master-setup.sh

---

## Step 4: Master Initialization

Commands to Run:

1. Create the master-init.sh script:
   touch master-init.sh

2. Update the control plane endpoint inside the script:
   CONTROL_PLANE_ENDPOINT=<master-node-ip>

3. Make the script executable:
   chmod +x master-init.sh

4. Run the script:
   ./master-init.sh

5. After successful initialization, note down the kubeadm join command
   from the output or from /root/kubeadm-init.out.

---

## Step 5: Worker Node Setup (Triggered from Master via SSH)

Commands to Run:

1. Create the worker-setup.sh script on the worker node:
   touch worker-setup.sh

2. Make it executable:
   chmod +x worker-setup.sh

3. Run the worker setup script from the master node:
   ssh <worker-node-ip> 'bash -s' < worker-setup.sh

---

## Step 6: Join Worker Node to Cluster (From Master via SSH)

Commands to Run:

1. Execute the kubeadm join command on the worker node from the master:
   ssh <worker-node-ip> "sudo kubeadm join <master-node-ip>:6443 \
   --token <token> \
   --discovery-token-ca-cert-hash sha256:<hash>"

   Replace <token> and <hash> with values generated during kubeadm init.

2. Verify worker node status on the master node:
   kubectl get nodes

---

## Notes

- Ensure all prerequisites (containerd, kubeadm, kubelet, kubectl) are installed on all nodes.
- SSH connectivity between master and worker nodes is mandatory.
- Always run kubeadm init only once on the first master node.
- Worker nodes should join the cluster only after CNI is installed.

---

Kubernetes cluster setup completed successfully.
EOF
