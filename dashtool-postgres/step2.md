### Create Secrets

The lakehouse consists of a catalog, an object_store and a visualization server
which all require credentials to access them. We will use Kubernetes secrets to
store this confidential information. Please make sure to use secure passwords in
production environments.

1. Postgres

```
kubectl create secret generic postgres-secret --from-literal=password=postgres --from-literal=catalog-url=postgres://postgres:postgres@postgres:5432
```{{exec}}

```
export POSTGRES_PASSWORD=postgres
```{{exec}}

2. Arrow Flight

```
kubectl create secret generic arrow-flight-secret --from-literal=password=flight_password
```{{exec}}

3. Superset

```
kubectl create secret generic superset-secret --from-literal=admin-password=password
```{{exec}}

4. S3 (Localstack)

```
kubectl create secret generic aws-secret --from-literal=secret_access_key=wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY
```{{exec}}

```
export AWS_SECRET_ACCESS_KEY=wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY
```{{exec}}
