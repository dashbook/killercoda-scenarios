## Operational system

Now that we have everything setup, we can start with the actual tutorial. In
most cases, data systems are composed of a operational and an analytical part.
Operational systems read and write single entries while analytical
systems answer aggregate queries on multiple entries. 
In this tutorial the operational system consists of a Kafka server and a Postgres database.

### Kafka cluster

The goal of the operational system is to measure the order process of the business. For that, all order events are captured in the Kafka cluster.
To do that we have to define an "orders" topic in the Kafka cluster, which we can do by executing the following command:

```bash
kubectl exec -it deployments/kafka -- /opt/kafka/bin/kafka-topics.sh --create --bootstrap-server localhost:9092 --topic orders
```{{exec}}

Typically the order events are created on the backend servers everytime an user successfully submits an order. We will simulate this by inserting multiple events into Kafka by executing the following command.
As you can see, an event contains information about the quantity, the time, the customer and the product.

```bash
curl -X POST -H "Content-Type: application/vnd.kafka.json.v2+json" -H "Accept: application/vnd.kafka.v2+json" --data '{"records":[
{"key": 1001, "value":{"id": 10001, "order_date": "2016-01-16T00:00:00+00:00", "purchaser": 1001, "quantity": 1, "product_id": 102}},
{"key": 1002, "value":{"id": 10002, "order_date": "2016-01-17T00:00:00+00:00", "purchaser": 1002, "quantity": 2, "product_id": 105}},
{"key": 1002, "value":{"id": 10003, "order_date": "2016-02-19T00:00:00+00:00", "purchaser": 1002, "quantity": 2, "product_id": 106}},
{"key": 1003, "value":{"id": 10004, "order_date": "2016-02-21T00:00:00+00:00", "purchaser": 1003, "quantity": 1, "product_id": 107}}]}' "http://localhost:32082/topics/orders"
```{{exec}}

### Postgres database

Looking at the order event by itself, it is not easy to make any conclusions because the event doesn't contain any context about the product and the customer.
This is where other operational systems come into play that store this kind of information. In our case the Postgres database.
The following command let's us see what customer information is stored inside the database.

```bash
kubectl  exec -ti postgres-0 -- env PGPASSWORD=postgres psql -h postgres -U postgres postgres -c "SELECT * from inventory.customers;"
```{{exec}}

The customer table looks something like this:

|  id  | first_name | last_name |         email         
|------|------------|-----------|-----------------------
| 1001 | Sally      | Thomas    | sally.thomas@acme.com
| 1002 | George     | Bailey    | gbailey@foobar.com
| 1003 | Edward     | Walker    | ed@walker.com
| 1004 | Anne       | Kretchmar | annek@noanswer.org

Similarly we can get the product information by executing the following command:

```bash
kubectl  exec -ti postgres-0 -- env PGPASSWORD=postgres psql -h postgres -U postgres postgres -c "SELECT * from inventory.products;"
```{{exec}}

The products table looks something like this:

| id  |        name        |                       description                       | weight 
|-----|--------------------|---------------------------------------------------------|--------
| 101 | scooter            | Small 2-wheel scooter                                   |   3.14
| 102 | car battery        | 12V car battery                                         |    8.1
| 103 | 12-pack drill bits | 12-pack of drill bits with sizes ranging from #40 to #3 |    0.8
| 104 | hammer             | 12oz carpenter's hammer                                 |   0.75
| 105 | hammer             | 14oz carpenter's hammer                                 |  0.875
| 106 | hammer             | 16oz carpenter's hammer                                 |      1
| 107 | rocks              | box of assorted rocks                                   |    5.3
| 108 | jacket             | water resistent black wind breaker                      |    0.1
| 109 | spare tire         | 24 inch spare tire                                      |   22.2

