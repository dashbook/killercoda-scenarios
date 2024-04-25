## Cluster setup

The lakehouse we aim to construct in this tutorial comprises several components.
These include object storage for data, a database as a data source, and a visualization server.
Before we proceed with the tutorial, we have to make sure that all components are up and running.

### Install Argo

As a first step, the following command will install Argo Workflows in the cluster, which we will need to schedule the jobs to update the data.

```bash
kubectl create namespace argo

kubectl apply -n argo -f https://github.com/argoproj/argo-workflows/releases/download/v3.5.4/install.yaml

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
kubectl patch service \
  argo-server \
  --namespace argo \
  --type='json' \
  -p='[{"op": "replace", "path": "/spec/type", "value": "NodePort"},
{"op": "add", "path": "/spec/ports/0/nodePort", "value": 32746 }
]'
```{{execute}}

### Create Secrets

The various services within the cluster require credentials for access.
We will utilize Kubernetes secrets to securely store this sensitive information.
Please ensure the use of robust passwords in production environments.
The following command creates the required secrets for the tutorial.


```bash
kubectl create secret generic postgres-secret --from-literal=password=postgres --from-literal=catalog-url=postgres://postgres:postgres@postgres:5432
export POSTGRES_PASSWORD=postgres

kubectl create secret generic arrow-flight-secret --from-literal=password=flight_password

kubectl create secret generic superset-secret --from-literal=admin-password=password

kubectl create secret generic aws-secret --from-literal=secret_access_key=wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY
export AWS_SECRET_ACCESS_KEY=wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY
```{{exec}}

### Start Services

Now, we can start the services by applying the provided configuration files.

```bash
kubectl apply -f resources/
```{{exec}}


### Check that all pods are running

To start the pods, the cluster will download the required containers. This might
take some time. Please use the following command to check if all pods are
running as expected.

```bash
kubectl get pods
```{{exec}}

### Port-Forwarding

In a production environment you would create ingress resources to get access to
the services. To simplify the process, we will skip this step in this tutorial
and use port-forwarding to allow connections to the pods.

```
./resources/port-forwarding.sh > /dev/null &
```{{exec}}

After finishing these steps you should have all the required kubernetes services
running.
