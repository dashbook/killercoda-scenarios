### Start Services

Now, we can start the individual services by applying the provided configuration
files.

1. Start Postgres

```
kubectl apply -f resources/postgres.yaml
```{{exec}}

2. Start Localstack S3

```
kubectl apply -f resources/localstack.yaml
```{{exec}}

3. Start Arrow Flight Server

```
kubectl apply -f resources/arrow-flight.yaml
```{{exec}}

4. Start Superset

```
kubectl apply -f resources/superset.yaml
```{{exec}}

5. Grant argo permissons

```
kubectl apply -f resources/role.yaml
```{{exec}}

### Check that all pods are running

To start the pods, the cluster will download the required containers. This might
take some time. Please use the following command to check if all pods are
running as expected.

```
kubectl get pods
```{{exec}}
