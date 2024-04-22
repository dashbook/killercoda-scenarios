## Refresh data

The great thing about using materialized views for the transformation is that they automatically keep themselves up-to-date. 
To test this functionality, we will insert additional entries into our operational database and check how the data in the lakehouse changes.
To insert the data to the postgres database, execute the following kubernetes job:

```bash
curl -X POST      -H "Content-Type: application/vnd.kafka.json.v2+json"      -H "Accept: application/vnd.kafka.v2+json"      --data '{"records":[
{"key": 1004, "value":{"id": 10005, "order_date": "2016-03-05", "purchaser": 1004, "quantity": 3, "product_id": 108}},
{"key": 1001, "value":{"id": 10006, "order_date": "2016-03-10", "purchaser": 1001, "quantity": 1, "product_id": 103}},
{"key": 1002, "value":{"id": 10007, "order_date": "2016-03-15", "purchaser": 1002, "quantity": 2, "product_id": 109}},
{"key": 1003, "value":{"id": 10008, "order_date": "2016-04-20", "purchaser": 1003, "quantity": 1, "product_id": 104}},
{"key": 1004, "value":{"id": 10009, "order_date": "2016-04-25", "purchaser": 1004, "quantity": 3, "product_id": 105}},
{"key": 1001, "value":{"id": 10010, "order_date": "2016-04-01", "purchaser": 1001, "quantity": 1, "product_id": 105}},
{"key": 1002, "value":{"id": 10011, "order_date": "2016-05-05", "purchaser": 1002, "quantity": 2, "product_id": 101}},
{"key": 1003, "value":{"id": 10012, "order_date": "2016-05-10", "purchaser": 1003, "quantity": 1, "product_id": 106}},
{"key": 1004, "value":{"id": 10013, "order_date": "2016-05-15", "purchaser": 1004, "quantity": 3, "product_id": 103}},
{"key": 1001, "value":{"id": 10014, "order_date": "2016-06-20", "purchaser": 1001, "quantity": 1, "product_id": 107}},
{"key": 1002, "value":{"id": 10015, "order_date": "2016-06-25", "purchaser": 1002, "quantity": 2, "product_id": 103}},
{"key": 1003, "value":{"id": 10016, "order_date": "2016-06-30", "purchaser": 1003, "quantity": 1, "product_id": 108}}]}'      "http://localhost:32082/topics/orders"
```{{exec}}

Now head to the [Argo Workflow Console]({{TRAFFIC_HOST1_32746}}) and execute the workflow again. Alternatively you could wait until the workflow automatically executes on the schedule.
Once it finished, go to [Superset console]({{TRAFFIC_HOST1_32088}}) and view the updated data.

