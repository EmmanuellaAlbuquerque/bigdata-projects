-- ################################################################################
-- After Creating keyspaces

-- ################################################################################
-- 1.

CREATE TABLE login.users_by_username (
  userid uuid,
  username text,
  password text,
  email text,
  age int,

  -- partitioning, clustering, uniqueness
  PRIMARY KEY (userid);
);

use theme;

DESC tables;

SELECT * FROM example.chats_by_theme WHERE theme = 'Discussion' ORDER BY created_at DESC;

-- ################################################################################
-- 2.

-- Tupla (Tuple), Lista (List)

CREATE TABLE example.client (
  client_id uuid PRIMARY KEY,
  client_name text,
  address tuple<varchar, varchar, varchar>, -- país, estado, cidade
  balance list<float>
);

-- Conjunto (Set), Mapa (Map)

CREATE TABLE example.topic (
  topic_id uuid PRIMARY KEY,
  topic_name text,
  tags set<text>, -- unique values
  shares map<text, int>
);


-- CLIENT ENTITY
INSERT INTO example.client ( client_id, client_name, address, balance ) 
  VALUES (
    UUID(),
    'Ana',
    ('Brasil', 'Paraíba', 'João Pessoa'),
    [110.50, 500.70, 900.55]
);

INSERT INTO example.client ( client_id, client_name, address, balance ) 
  VALUES (
    UUID(),
    'Guilherme',
    ('Brasil', 'Paraíba', 'Cajazeiras'),
    [400, 200, 1000]
);

INSERT INTO example.client ( client_id, client_name, address, balance ) 
  VALUES (
    UUID(),
    'Marta',
    ('Brasil', 'Paraíba', 'Sousa'),
    [80.50, 600, 170]
);

INSERT INTO example.client ( client_id, client_name, address, balance ) 
  VALUES (
    UUID(),
    'Antônio',
    ('Brasil', 'Paraíba', 'Campina Grande'),
    [10.50, 900, 30]
);

INSERT INTO example.client ( client_id, client_name, address, balance ) 
  VALUES (
    UUID(),
    'Letícia',
    ('Brasil', 'Paraíba', 'Patos'),
    [209, 800.70, 10]
);

-- TOPIC ENTITY
INSERT INTO example.topic ( topic_id, topic_name, tags, shares )
  VALUES (
    UUID(),
    'dead man found in mansion',
    { 'tragedy', 'news' },
    { 'facebook': 70, 'instagram': 100 }
);

INSERT INTO example.topic ( topic_id, topic_name, tags, shares )
  VALUES (
    UUID(),
    'mendes live attracts millions',
    { 'music', 'live' },
    { 'facebook': 1000, 'instagram': 2000 }
);

INSERT INTO example.topic ( topic_id, topic_name, tags, shares )
  VALUES (
    UUID(),
    'fundraising for the lost cat',
    { 'money', 'help' },
    { 'facebook': 90, 'instagram': 10 }
);

INSERT INTO example.topic ( topic_id, topic_name, tags, shares )
  VALUES (
    UUID(),
    'new movie about multiverses draws attention',
    { 'cinema', 'movie' },
    { 'facebook': 1000, 'instagram': 5000 }
);

INSERT INTO example.topic ( topic_id, topic_name, tags, shares )
  VALUES (
    UUID(),
    'the queen lost her son and father',
    { 'news' },
    { 'facebook': 5, 'instagram': 20 }
);

SELECT * FROM example.client;

SELECT * FROM example.topic;

-- ################################################################################
-- 4.

-- WHERE e ORDER BY

SELECT * FROM example.client WHERE client_id = f88a4056-0589-4cea-85f5-32e2d29ccb4b;

SELECT * FROM example.chats_by_theme WHERE theme = 'Discussion' ORDER BY created_at DESC;

-- ALLOW FILTERING

SELECT * FROM example.chats_by_theme WHERE owner_from = 'BR' ALLOW FILTERING;

-- ################################################################################
-- 5.

-- Secondary Index

CREATE INDEX ON example.topic (tags);

SELECT * FROM example.topic WHERE tags CONTAINS 'news';
