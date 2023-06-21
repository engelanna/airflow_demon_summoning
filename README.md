# CarePay Data Engineer Code Challenge
##### Anna Engel's implementation
<hr>

**Architecture diagram**
![carepay_architecture](https://github.com/engelanna/carepay_engelanna/assets/13955209/f5bed081-633e-4d2b-8221-d07eaece26ad)

## The approach
- _We make the complex simple_ @ [What CarePay values](https://www.carepay.com/careers-at-carepay)
- data matters more than infra
  - the warehouse has been split into **schemas** à la _Data Vault_:
    - `staging` is just the landing area
      - the one-off smallish ingress doesn't even require partitioning
        - partitioning would be _pro_, but mind the crazy time horizon
    - `core` is indexed via:
      - PKs
      - B-tree indexes on `timestamp` columns (a favourite of the analysts I know)
    - `analytics` has just the schema
      - but withhold your judgement until you've seen it ([1](https://github.com/engelanna/carepay_engelanna/blob/main/scripts/postgres/007_create_analytics_schema_standard_dimensions.sql), [2](https://github.com/engelanna/carepay_engelanna/blob/main/scripts/postgres/008_create_analytics_schema_activity_tables.sql), [3](https://github.com/engelanna/carepay_engelanna/blob/main/scripts/postgres/009_create_analytics_schema_shared_dimensions.sql)), especially if you like Kimball's dimensional modelling.
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

## Inspect databases

Schemas can be seen right away. Data is available as soon as the terminal stops scrolling.
```bash
make dolphin  # peek into MySQL
make elephant  # peek into PostgreSQL
```

## Uninstall & cleanup
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

#### Tool choices
  - the Airflow scheduler (and nothing else from the Airflow ecosystem)
    - all I needed was a data shovel, not bells and whistles
  - `docker-compose:` for (hopefully) reproducilibility on the CarePay side
    - in my experience, cloud setups drop that probability to < 10%
      - spending hours to figure out a given AWS instance type is supported in `eu-west-1`, but not `eu-north-1`, isn't anybody's idea of fun
  - `postgres:`
    - ease of setup
    - transformable into a columnar database with the `cstore_fdw` extension
      - so let's hold off on those indexes in the `analytics` schema
    - `lift-and-shift`-able unto Redshift (Redshift is based off of `postgres`).

#### Structuring of the data in the single source of truth system. Why does this structure lead to easy and low latency queries?
  - it's a star schema (introduced by Ralph Kimball), i.e. it's denormalized = forgoing the three database normal forms
    - the star schema = a fact table in the middle, surrounded by dimension tables
    - denormalized = you're able to find duplicated data across tables
      - worth noting: more 'stars' are possible in a single warehouse: when you need more than a single grain 
      - star schemas usually uphold Boyce-Codd's "4th normal form" (unique identifiers to tell apart otherwise identical rows), but that doesn't mean they're normalized, as the forms must be kept 'from the ground up'
  - in such a schema, the database performs better than having complicated JOINs introduce overheads on the query processsor
      - which pains me, because I rooted for Bill Inmon (author of the normalized approach to data warehousing), but his approach lost out in practice (warehouse design would take several times longer than Kimball)
  - less room for error on incorrect column joins (they cause expensive queries)
  - another way of putting the above is "storage is cheaper than compute".

#### Scalability and maintainability. We understand that after one day your system will not be production ready. What would change to your design if you have to bring it to production.
  - change the Airflow executor to something other than `Sequential`, it pains me to look at the speed, this needs a Redis or a second PostgreSQL-like DB
  - introduce partitioning and upserts (currently just inserts, which are fine for a one-off load)
  - use columnar indexes in the analytics schema (+vectorization: faster data operations +same data type: better compression, so cheaper compute)
  - use Snowflake + dbt_cloud for [`dev vs prod vs pull_request`] schema separation, I actually tried go guess your setup based on the job description, the diagram is [here](https://github.com/engelanna/carepay_engelanna/assets/13955209/4cbdbe07-2b9a-468f-a183-b529fc42bcb5)
  - clean the data using dbt (I love its testing capabilities using pure SQL)instead of my smart hack (described below) => build it automatically using dbt cloud
  - [do you like DAGs?](https://pbs.twimg.com/media/Eo_sms-W8AI7gbL.jpg) People really like my Python; peek around.

#### Ensurance of data quality. How are you ensuring that the data at hand is ready to be consumed by others?
  - glad you asked:
    - your `treatments.csv` missed the `TYPE` column, which consequently shifted the data one column right. This was visible as `0000-00-00 00:00:00:00` columns in the database tables.
    - one should always change the data upstream (fewer points of change, repaired data just flows downstream nicely), then downstream (more points of change, an order of magnitude larger complexity), and...
      - ...since I had access to the upstream system (your Docker container), I just updated the column list in the `load_csv.sql` file over there. This automatically fixed the mess downstream.
  - I resolved against fixing `date_modified` sometimes being lower than `date_created` (something got updated before it got born) in 2 of the tables
  - in a similar way, I've foregone replacing NULL `date_created` with `date_modified`: I'd need more requirements gathering for that. 
<hr>
