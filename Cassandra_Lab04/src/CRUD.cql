-- ################################################################################
-- 3.

-- Table
CREATE TABLE example.chats_by_theme (
  chat_id uuid,
  theme text,
  created_at timestamp,
  owner_id uuid,
  description text,
  owner_from text,

  -- partitioning, ordering, 
  PRIMARY KEY ((theme), created_at)
) WITH CLUSTERING ORDER BY (created_at DESC);

-- Execute CRUD Operations

-- Create

INSERT INTO example.chats_by_theme (
  chat_id,
  theme,
  created_at,
  owner_id,
  description,
  owner_from
) VALUES (
  UUID(),
  'Discussion',
  toTimeStamp(NOW()),
  UUID(),
  'BLACK VS GREEN',
  'EUA'
);

INSERT INTO example.chats_by_theme (
  chat_id,
  theme,
  created_at,
  owner_id,
  description,
  owner_from
) VALUES (
  UUID(),
  'Blurt Out',
  toTimeStamp(NOW()),
  UUID(),
  'rosas são vermelhas violetas são azuis',
  'BR'
);

INSERT INTO example.chats_by_theme (
  chat_id,
  theme,
  created_at,
  owner_id,
  description,
  owner_from
) VALUES (
  UUID(),
  'Discussion',
  toTimeStamp(NOW()),
  UUID(),
  'ice cream or açaí',
  'EUA'
);

-- Read

-- only test (not run in production)
SELECT * FROM example.chats_by_theme;

SELECT * FROM example.chats_by_theme WHERE theme = 'Discussion';

-- Update

-- ################################################################################
-- Tuple is frozen (address)

SELECT * FROM example.client WHERE client_id = 5305df9b-4478-4192-a8c3-b78be8fbd702; 

-- substituição
UPDATE example.client SET address = ('Brasil', 'Paraíba', 'Pombal') WHERE client_id = 5305df9b-4478-4192-a8c3-b78be8fbd702;

-- ################################################################################
-- List (balance)

SELECT * FROM example.client WHERE client_id = 5305df9b-4478-4192-a8c3-b78be8fbd702;

-- substituição (Setting of list items by index requiring read before write is not allowed)
-- UPDATE example.client SET balance[2] = 377 WHERE client_id = 5305df9b-4478-4192-a8c3-b78be8fbd702;

-- adição
UPDATE example.client SET balance = balance + [200] WHERE client_id = 5305df9b-4478-4192-a8c3-b78be8fbd702;

-- remoção (Setting of list items by index requiring read before write is not allowed)
-- DELETE balance[0] FROM example.client WHERE client_id = 5305df9b-4478-4192-a8c3-b78be8fbd702;

-- ################################################################################
-- Set (tags)

SELECT * FROM example.topic WHERE topic_id = 6b334761-4778-4e4e-8662-bdcd3330e938;

-- adição
UPDATE example.topic SET tags = tags + {'lost'} WHERE topic_id = 6b334761-4778-4e4e-8662-bdcd3330e938;

-- remoção
UPDATE example.topic SET tags = tags - {'lost'} WHERE topic_id = 6b334761-4778-4e4e-8662-bdcd3330e938;

-- ################################################################################
-- Map (shares)

SELECT * FROM example.topic WHERE topic_id = 6b334761-4778-4e4e-8662-bdcd3330e938;

-- substituição
UPDATE example.topic SET shares = shares + {'facebook': 1000} WHERE topic_id = 6b334761-4778-4e4e-8662-bdcd3330e938;

UPDATE example.topic SET shares['facebook'] = 200 WHERE topic_id = 6b334761-4778-4e4e-8662-bdcd3330e938;

-- adição
UPDATE example.topic SET shares = shares + {'youtube': 30} WHERE topic_id = 6b334761-4778-4e4e-8662-bdcd3330e938;

-- remoção
UPDATE example.topic SET shares = shares - {'youtube'} WHERE topic_id = 6b334761-4778-4e4e-8662-bdcd3330e938;

-- ################################################################################

-- Delete

-- Client

SELECT * FROM example.client;

DELETE FROM example.client WHERE client_id = 4e9009a4-06b3-45c4-84e9-c4304cf01fd8;

-- Topic

SELECT * FROM example.topic;

DELETE FROM example.topic WHERE topic_id = dde345c3-ab0c-4c00-9905-4dfd55cc448e;
