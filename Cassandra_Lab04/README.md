
### Normalization (Relational Data Modeling)
- separation by id into another table (foreigh key)
- no redundant data
- single instance

### Denormalization (NoSQL Data Modeling) 
- performance trade-off
- repeating data, read performance at scale 
- using more disk space, faster
- no joins
- single read

### Cassandra data model pattern: denormalization
- cassandra, maintain performance at scale
- partition key, clutering columns
- payload by partitioning

### Cassandra principles
- Store together what you retrieve together
- Avoid big partitions: country, user_id (large row)
- Avoid unbounded partitions
  * bucketing: sensor_id, month_year, reported_at
  * bucketing by month and year
  * properly anticipate size
- Avoid hot : country, user_id (unbalancing clusters)
