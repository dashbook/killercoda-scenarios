## Visualization

After executing the workflow, the data from the database should have been replicated to the lakehouse.
To check if everything worked as expected, head to the [Superset console]({{TRAFFIC_HOST1_32088}}). Use the credentails username: "admin" and password: "password" to login.
As a first step we have to add our Arrow Flight Server as a Database. 

1. To do that, click on "Settings" in the upper right corner and under "Data" click "Database Connections".
2. On the next screen click "+ Database" also in the uppper right corner. 
3. In the "Connect a Database" window, click the "SUPPORTED DATABASES" drop-down menu and select "Other".
4. Use "Flight SQL" as the "DISPLAY NAME".
5. Enter the "SQLALCHEMY_URI":

```
adbc_flight_sql://flight_username:flight_password@arrow-flight:31337?disableCertificateVerification=True&useEncryption=True
```{{copy}}

6. Click the "TEST CONNECTION" button to test if everything works as expected
7. Click the "CONNECT" button to save the database connection

Now that we have a connection to the Arrow Flight Server, we can query the data in the lakehouse. So let's test it out.

1. Click the "SQL" drop down menu in the top left corner and select "SQL Lab"
2. Write a query that you want to execute:
```sql
SELECT * FROM bronze.inventory.orders;
```{{copy}}
3. Click the "RUN" button
