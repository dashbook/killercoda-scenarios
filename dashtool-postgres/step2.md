### Create Secrets

The various services within the cluster require credentials for access.
We will utilize Kubernetes secrets to securely store this sensitive information.
Please ensure the use of robust passwords in production environments.
The following command create the required secrets for the tutorial.

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
