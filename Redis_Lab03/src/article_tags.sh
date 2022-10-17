# Redis-CLI

REDIS_CON="redis-cli -h <endpoint> -p <port> -a <password> --no-auth-warning"
echo $REDIS_CON

# ------------------- Hash: Article -------------------

# article - name, description, filename, posting date.
$REDIS_CON hset article:1 name "The Singularities" description "A description of gravitational collapse and cosmology" filename singularities.pdf date 1970/01/27
$REDIS_CON hset article:2 name "Black Holes" description "The American Physical Society" filename society.pdf date 1971/05/15
$REDIS_CON hset article:3 name "Relativity" description "The Special and General Theory" filename relativity.pdf date 1916/01/01
$REDIS_CON hset article:4 name "Time, Space, and Gravitation" description "The Special and General Theory" filename theory.pdf date 1919/11/28
$REDIS_CON hset article:5 name "The Theory" description "The Theory of Everything" filename ed_r.pdf date 2014/09/13

$REDIS_CON KEYS '*'

$REDIS_CON hgetall article:1

$REDIS_CON hmget article:1 name


# --------------------- Set: Tags ---------------------

$REDIS_CON sadd tags science physics space

$REDIS_CON smembers tags

# Relacionando um artigo e suas tags
$REDIS_CON sadd article:1:tags science

$REDIS_CON sadd tags:science:article 1

$REDIS_CON sadd article:3:tags physics space

$REDIS_CON sadd tags:physics:article 3

$REDIS_CON sadd tags:space:article 3

# ------------- Listando todos os artigos -------------

for key in $($REDIS_CON scan 0 MATCH article:* count 1000 TYPE hash)
  do echo "=-=-=-=-==-=-=-=-= Article Key : $key =-=-=-=-==-=-=-=-=" 
     $REDIS_CON hgetall $key;
done

# --------- Listar um único artigo e suas tag ---------

$REDIS_CON hgetall article:3 && echo "tags:" && $REDIS_CON smembers article:3:tags


# ------- Listar os artigos dada uma ou mais tags -------

$REDIS_CON smembers tags:science:article

for key in $($REDIS_CON sunion tags:space:article tags:science:article)
  do echo "=-=-=-=-==-=-=-=-= Article ID : $key =-=-=-=-==-=-=-=-=" 
     $REDIS_CON hgetall article:$key;
done
