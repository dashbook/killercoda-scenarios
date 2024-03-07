## Visualization

We finally transformed the data so that it can be used by downstream consumers. The data is typically used for business intelligence or machine learning. 
Let's connect our BI tool to the data and see what we calulated.
Head to the [Superset console]({{TRAFFIC_HOST1_8088}}). Use the credentails username: "admin" and password: "password" to login.
As a first step we have to add our Arrow Flight Server as a Database. 

1. To do that, click on "Settings" in the upper right corner and under "Data" click "Database Connections".
2. On the next screen click "+ Database" also in the uppper right corner. 
3. In the "Connect a Database" window, click the "SUPPORTED DATABASES" drop-down menu and select "Other".
4. Use "Flight SQL" as the "DISPLAY NAME".
5. Enter the "SQLALCHEMY_URI":

```
adbc_flight_sql://flight_username:flight_password@arrow-flight:31337?disableCertificateVerification=True&useEncryption=False
```{{copy}}

6. Click the "TEST CONNECTION" button to test if everything works as expected
7. Click the "CONNECT" button to save the database connection

Now that we a connection to the Arrow Flight Server, we can query the data in the lakehouse. So let's test it out.

1. Click the "SQL" drop down menu in the top left corner and select "SQL Lab"
2. Write a query that you want to execute:
```sql
SELECT * FROM gold.inventory.monthly_ordered_weight;
```{{copy}}
3. Click the "RUN" button

## Refresh data

The great thing about using materialized views for the transformation is that they automatically keep themselves up-to-date. 
To test this functionality, we will insert additional entries into our operational database and check how the data in the lakehouse changes.
To insert the data to the postgres database, connect to the database:

```shell
kubectl exec postgres-0 -- bash
```{{exec}}

```shell
psql -h localhost -U postgres
```{{exec}}

The following command generates some more test data:

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

Now head to the [Argo Workflow Console]({{TRAFFIC_HOST1_2746}}) and execute the workflow again. Alternatively you could wait until the workflow automatically executes on the schedule.
Once it finished, go to Superset and view the updated data.

