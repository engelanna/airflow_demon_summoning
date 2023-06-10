# CarePay Data Engineer Code Challenge
##### Anna Engel's implementation


## The approach
- data matters more than infra
- simplify (CarePay values)
<hr>


## Prerequisites
- [Docker Compose](https://docs.docker.com/compose/install/)
- unoccupied `localhost` ports:
  - `3306` for MySQL
  - `5432` for PostgreSQL
<hr>


## Install & run
**Note:** Don't run the MySQL container delivered with the challenge - it has been included :woman_shrugging:
```bash
  git clone https://github.com/engelanna/carepay_engelanna.git
  cd carepay_engelanna

  wget https://tinyurl.com/wzxa3zh3 --output-document .env  # passwords
  make up
```
<hr>


## Uninstall
```bash
# deletes the containers, but not the postgres:15 & mysql:5.6 images
  make down 
```
or
```bash
  # deletes the containers AND postgres:15 & mysql:5.6 images
  # (including yours if you'd had them)
  make boom
```
<hr>

## Answers to CarePay questions
###

- [x]  
​The goal of this challenge is to extract data from a source system, a MySQL database, and move it to a single source of truth system. In the single source of truth system the data should be cleaned and should be structured in a way that would allow for easy and low-latency queries. What that centralised single source of truth system is is up to you. For example, it could be a cloud data warehouse such as Redshift or BigQuery, a Object Storage such as S3 with AWS Athena as a query layer, or it could be an on-premise NoSQL database. The decision is up to you.
​
When you submit the challenge we expect to see an ETL system that moves data out of the MySQL database, cleans and transforms the data and exposes the data in a single source of truth system. You can use a scripting language of your choice, preferable python. Also, we should be able to reproduce your solution. That means there should be some instructions on how to run your ETL system, ideally in the form of some scripts. Any infrastructure components should also be reproducible. We expect a bash script/docker-compose file/your framework of choice to be able to reproduce your setup. Furthermore, a simple markdown file should be added which describes the following:
​

- The tool choices. Why was tool x used in your system?
- Structuring of the data in the single source of truth system. Why does this structure lead to easy and low latency queries?
- Scalability and maintainability. We understand that after one day your system will not be production ready. What would change to your design if you have to bring it to production.
  ​
  You will be evaluated based on the following criteria:
  ​
- Architecture of the ETL system. Did your tool choices make sense for the problem at hand?
- Quality of the ETL code. Did you write easy to understand and maintainable code?
- Ensurance of data quality. How are you ensuring that the data at hand is ready to be consumed by others?
  ​
  For the challenge you are given a local MySQL database with some preloaded data based on data in the CarePay system. The following section explains how to run the MySQL database locally.
  ​

## Starting MySQL

​
Building and starting the MySQL database:
​

```bash
docker build -t data-challenge .
docker run -d -v "$PWD/data":/var/lib/data -p 3306:3306 data-challenge
```

​
This starts a local docker container running MySQL. The data in the csv files is automatically loaded into the MySQL database in the carepay schema. The MySQL database can be reached on port 3306 on localhost.
​
Connecting to the database:
​

```bash
mysql -u root -p -h 127.0.0.1 carepay
```

​
You will be prompted for a password, which conveniently is `password`.
​
To verify the database was successfully loaded, execute the following query:
​

```sql
SELECT * FROM INVOICE_ITEM LIMIT 10;
```

​
To exit the local MySQL CLI you can type `exit`.
​

## The Data

​
For the challenge the following data is available:
​

- Claims: Contain information on claims made for a treatment. Whenever a member of the CarePay platform receives treatment at a hospital (provider) a claim will be submitted. The status field indicates whether the claim was approved or rejected.
- Treatments: Contain treatment information, such as the date of treatment and the provider at which the treatment was executed.
- Invoice items: Contain information on the types of products and services where needed for a treatment, and the price and amount of each product. For example, whenever a doctor subscribes paracetamol tablets, that information will be captured in the invoice items.
- Invoice: Link invoice items to treatments.
  ​

## Bonus Challenge

If you have time left, we have a bonus challenge. To enable teams to analyze their business processes, we need to deliver nice visualizations to the teams. So use the system you build as a basis for creating a small dashboard. For example, you can build a Plotly dashboard or set up an integration with AWS QuickSight. Attach the related code and a screenshot of your dashboard with the challenge.
​
HAVE FUN!



.env file link: https://drive.google.com/file/d/1Tb8YevcJJIUhJhc0B4mezwQSI1jRCM-U/view?usp=drive_link

Note that each value in the activity_type
column has its own timestamp. This will be important for the fourth part.
3) You might be wondering why a table like Fact_order_activity is necessary if in section two
we already have Fact_deliverer_activity and Fact_customer_acivity. The concept is simply:
Storage is cheaper than compute! Duplicating data is better than doing JOINs and there is less
room for error if analysts and scientists incorrectly join columns that cause expensive queries.
4) As mentioned, Dim_orders is simply a “flattened out” version of Fact_order_activity. If you
look closely, you can see that timestamp is not in Fact_order_activity. The reason this is vital
is because a lot of times in businesses like these (food delivery, car sharing, etc), optimizing for
time is very essentially. A table is Dim_orders lets the data scientists write very simple Queries
for each order id (since there is only 1 row per ord

## Features
