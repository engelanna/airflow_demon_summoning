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
