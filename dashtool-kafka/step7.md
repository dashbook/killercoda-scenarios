## Refresh data

The great thing about using materialized views for the transformation is that they automatically keep themselves up-to-date. 
To test this functionality, we will insert additional entries into our operational system and check how the data in the lakehouse changes.
To insert the data into the Kafka server, execute the following kubernetes job:

```bash
kubectl exec -it deployments/kafka -- /opt/kafka/bin/kafka-console-producer.sh --topic orders --broker-list kafka:9092 < /tmp/kafka/messages2.txt
```{{exec}}

Now head to the [Argo Workflow Console]({{TRAFFIC_HOST1_32746}}) and execute the workflow again. Alternatively you could wait until the workflow automatically executes on the schedule.
Once it finished, go to [Superset console]({{TRAFFIC_HOST1_32088}}) and view the updated data.

