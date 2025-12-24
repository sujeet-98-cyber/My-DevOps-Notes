Got it! Here’s a version you can **directly run** in bash to create a `README.md` with proper code blocks (no backslash escaping needed):
## Step 1: Login to Master Node

````bash
- SSH into your master node.
- Ensure all other nodes (master and worker nodes) are reachable via SSH from the master node.
- If SSH access is not working, fix it manually before proceeding.

```bash
ssh <node-ip>
````

## Step 2: Pre-Setup

1. Create the pre_setup.sh script:

```bash
touch pre_setup.sh
```

2. Make it executable:

```bash
chmod +x pre_setup.sh
```

3. Run the script:

```bash
./pre_setup.sh
```

## Step 3: Master Setup

1. Create the master-setup.sh script:

```bash
touch master-setup.sh
```

2. Make it executable:

```bash
chmod +x master-setup.sh
```

3. Run the script:

```bash
./master-setup.sh
```

## Step 4: Master Initialization

1. Create the master-init.sh script:

```bash
touch master-init.sh
```

2. Before running the script, update the CONTROL_PLANE_ENDPOINT variable with your master node IP:

```bash
# Example inside master-init.sh
CONTROL_PLANE_ENDPOINT=<master-node-ip>
```

3. Make the script executable:

```bash
chmod +x master-init.sh
```

4. Run the script:

```bash
./master-init.sh
```

## Step 5: Worker Node Setup (Run from Master Node)

* The worker-setup.sh script should be executed on the worker node but triggered from the master node using SSH.

1. Create the worker-setup.sh script on the worker node:

```bash
touch worker-setup.sh
```

2. Make it executable:

```bash
chmod +x worker-setup.sh
```

3. Run the script from the master node:

```bash
ssh <worker-node-ip> 'bash -s' < worker-setup.sh
```

## Notes

* Ensure that all prerequisites (Docker, kubeadm, kubelet, kubectl) are installed on all nodes before running these scripts.
* Always verify SSH connectivity before proceeding with any setup step.
  EOF

````

✅ **Explanation:**  
- The single `cat << 'EOF' > README.md` block creates the file directly.  
- All commands appear inside proper markdown code blocks (```bash```) in the file.  
- You can copy-paste this **as-is** and run it in your terminal to generate the Markdown file.  

If you want, I can also **add headings for “Commands to Run” and “Scripts Creation”** to make it even cleaner for documentation purposes. Do you want me to do that?
````
