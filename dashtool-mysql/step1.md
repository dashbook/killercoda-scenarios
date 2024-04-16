## Cluster setup

The lakehouse we aim to construct in this tutorial comprises several components.
These include object storage for data, a database as a data source, and a visualization server.
Before we proceed with the tutorial, we have to make sure that all components are up and running.

### Install Argo

As a first step, the following command will install Argo Workflows in the cluster, which we will need to schedule the jobs to update the data.

```bash
kubectl create namespace argo

kubectl apply -n argo -f https://github.com/argoproj/argo-workflows/releases/download/v3.5.5/install.yaml

kubectl patch deployment \
  argo-server \
  --namespace argo \
  --type='json' \
  -p='[{"op": "replace", "path": "/spec/template/spec/containers/0/args", "value": [
  "server",
  "--auth-mode=server",
  "--secure=false"
]},
{"op": "replace", "path": "/spec/template/spec/containers/0/readinessProbe/httpGet/scheme", "value": "HTTP"}
]'
```{{execute}}

