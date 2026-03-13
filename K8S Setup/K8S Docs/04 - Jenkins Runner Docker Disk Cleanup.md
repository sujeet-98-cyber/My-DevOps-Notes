# Jenkins Runner Docker Disk Cleanup and Image Restore Procedure

## Step 1: Check current Docker disk usage
```bash
docker system df
```
## Step 2: Remove unused Docker data (cleanup)
```bash
docker system prune -af
```
## Step 3: Verify Docker disk usage after cleanup
```
docker system df
```
## Step 4: Pull required Node.js Alpine images from private registry
```
docker pull 10.48.228.71/library/nodejsapi/node-20-alpine:node-20-alpine
docker pull 10.48.228.71/library/nodejsapi/node-18-alpine:node-18-alpine
```
## Step 5: Tag images to standard names used in Jenkins pipelines
```
docker tag 10.48.228.71/library/nodejsapi/node-20-alpine:node-20-alpine node:20-alpine
docker tag 10.48.228.71/library/nodejsapi/node-18-alpine:node-18-alpine node:18-alpine
```
