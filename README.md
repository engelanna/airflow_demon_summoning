# Airflow demon summoning
##### Warp in an Airflow cluster + 2 databases (source, target) + dbt cleaning scripts
<hr>

**Architecture diagram**
![carepay_architecture](https://github.com/engelanna/airflow_demon_summoning/assets/13955209/f5bed081-633e-4d2b-8221-d07eaece26ad)

## Prerequisites
- [Docker Compose](https://docs.docker.com/compose/install/)
- unoccupied `localhost` ports:
  - `3306` for MySQL
  - `5432` for PostgreSQL
<hr>

## The approach
- the warehouse (= target DB) has been split into **schemas** à la _Data Vault_:
  - `staging` is just the landing area
    - no partitoning since the the ingress is a smallish one-off
  - `core` is indexed via:
    - PKs
    - B-tree indexes on `timestamp` columns (a favourite of the analysts I know)
  - `analytics` has just the schema
    - but withhold your judgement until you've seen it ([1](https://github.com/engelanna/airflow_demon_summoning/blob/main/scripts/postgres/007_create_analytics_schema_standard_dimensions.sql), [2](https://github.com/engelanna/airflow_demon_summoning/blob/main/scripts/postgres/008_create_analytics_schema_activity_tables.sql), [3](https://github.com/engelanna/airflow_demon_summoning/blob/main/scripts/postgres/009_create_analytics_schema_shared_dimensions.sql)), especially if you like Kimball's dimensional modelling.
<hr>


## Install & run
```bash
  git clone https://github.com/engelanna/airflow_demon_summoning.git
  cd airflow_demon_summoning

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

## Discussion

#### Tool choices
  - the Airflow scheduler (and nothing else from the Airflow ecosystem)
    - just a data shovel, no bells and whistles
  - `docker-compose:` for system reproducilibility
  - `postgres:`
    - ease of setup
    - transformable into a columnar database with the `cstore_fdw` extension
    - `lift-and-shift`-able unto Redshift (Redshift is based off of `postgres`).

#### Structuring of the data in the single source of truth system - why does this structure lead to easy and low latency queries?
  - it's a star schema (introduced by Ralph Kimball), i.e. it's denormalized = forgoing the three database normal forms
    - the star schema = a fact table in the middle, surrounded by dimension tables
    - denormalized = you're able to find duplicated data across tables
      - worth noting: more 'stars' are possible in a single warehouse: when you need more than a single grain 
      - star schemas usually uphold Boyce-Codd's "4th normal form" (unique identifiers to tell apart otherwise identical rows), but that doesn't mean they're normalized, as the forms must be kept 'from the ground up'
  - in such a schema, the database performs better than having complicated JOINs introduce overheads on the query processsor
      - which pains me, because I rooted for Bill Inmon (author of the normalized approach to data warehousing), but his approach lost out in practice (warehouse design would take several times longer than Kimball)
  - less room for error on incorrect column joins (they cause expensive queries)
  - another way of putting the above is "storage is cheaper than compute".

#### What to change in order to bring this into production
  - change the Airflow executor to something other than `Sequential`, it pains me to look at the speed, this needs a Redis or a second PostgreSQL-like DB
  - introduce partitioning and upserts (currently just inserts, which are fine for a one-off load)
  - use columnar indexes in the analytics schema (+vectorization: faster data operations +same data type: better compression, so cheaper compute)
  - use Snowflake + dbt_cloud for [`dev vs prod vs pull_request`] schema separation, I actually tried go guess your setup based on the job description, the diagram is [here](https://github.com/engelanna/airflow_demon_summoning/assets/13955209/4cbdbe07-2b9a-468f-a183-b529fc42bcb5)
  - clean the data using dbt (I love its testing capabilities using pure SQL)instead of my smart hack (described below) => build it automatically using dbt cloud
  - [do you like DAGs?](https://pbs.twimg.com/media/Eo_sms-W8AI7gbL.jpg) People really like my Python; peek around.

<hr>
