#!/bin/bash
# Build, push, deploy, and run post-deploy tasks for myapp.

# Define the version to be deployed (e.g. a git hash or semver tag).
version="1.0.9"
registry="097815753467.dkr.ecr.us-east-1.amazonaws.com"
appname="ibm-hello-world"

# Build react app
yarn --cwd ibm-hello-world build

# Build and push the container image.

echo $registry
echo $appname
ls

docker build -t $registry/$appname:$version .
docker push $registry/$appname:$version
docker tag $registry/$appname:$version $registry/$appname:latest
docker push $registry/$appname:latest

# Update the myapp deployment in Kubernetes, in the namespace 'namespace'.
kubectl set image deployment/ibm-hello-world-deployment back-end=$registry/$appname:$version

# Check deployment rollout status every 10 seconds (max 10 minutes) until complete.
ATTEMPTS=0
ROLLOUT_STATUS_CMD="kubectl rollout status deployment/ibm-hello-world-deployment"
until $ROLLOUT_STATUS_CMD || [ $ATTEMPTS -eq 60 ]; do
  $ROLLOUT_STATUS_CMD
  ATTEMPTS=$((attempts + 1))
  sleep 10
done
