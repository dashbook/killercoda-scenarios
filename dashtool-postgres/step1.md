## Cluster setup

The lakehouse we aim to construct in this tutorial comprises several components.
These include object storage for data, a database as a data source, and a visualization server.
Before we proceed with the tutorial, it's crucial to ensure that all components are up and running.

### Install Argo

Next, we need to install Argo workflows in the cluster. We will create a `argo`
namespace for all its resources.

```
kubectl create namespace argo
```{{exec}}

The next step will install argo workflows. Please specify which version should
be used.

```
kubectl apply -n argo -f https://github.com/argoproj/argo-workflows/releases/download/v3.5.2/install.yaml
```{{exec}}

Argo is typically deployed on a permanent cluster with proper SSL certificates.
Since our cluster is used only temporarily, we will not use any encryption. This will lead to warnings in the
browser later on but these don't need to concern us.

```bash
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

