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
