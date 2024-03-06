### Port-Forwarding

In a production environment you would create ingress resources to get access to
the services. To simplify the process, we will skip this step in this tutorial
and use port-forwarding to allow connections to the pods.

```
./resources/port-forwarding.sh
```{{exec}}

After finishing these steps you should have all the required kubernetes services
running.
