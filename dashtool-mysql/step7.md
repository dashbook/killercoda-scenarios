## Refresh data

The great thing about using materialized views for the transformation is that they automatically keep themselves up-to-date. 
To test this functionality, we will insert additional entries into our operational database and check how the data in the lakehouse changes.
To insert the data to the mysql database, execute the following kubernetes job:

```shell
kubectl apply -f resources/jobs/ingest.yaml
```{{exec}}

The job will execute the following command in the source database.

```sql
INSERT INTO inventory.orders (id, order_date, purchaser, quantity, product_id) VALUES
(10005, '2016-03-05', 1004, 3, 108),
(10006, '2016-03-10', 1001, 1, 103),
(10007, '2016-03-15', 1002, 2, 109),
(10008, '2016-04-20', 1003, 1, 104),
(10009, '2016-04-25', 1004, 3, 105),
(10010, '2016-04-01', 1001, 1, 105),
(10011, '2016-05-05', 1002, 2, 101),
(10012, '2016-05-10', 1003, 1, 106),
(10013, '2016-05-15', 1004, 3, 103),
(10014, '2016-06-20', 1001, 1, 107),
(10015, '2016-06-25', 1002, 2, 103),
(10016, '2016-06-30', 1003, 1, 108);
```{{copy}}

Now head to the [Argo Workflow Console]({{TRAFFIC_HOST1_32746}}) and execute the workflow again. Alternatively you could wait until the workflow automatically executes on the schedule.
Once it finished, go to [Superset console]({{TRAFFIC_HOST1_32088}}) and view the updated data.

