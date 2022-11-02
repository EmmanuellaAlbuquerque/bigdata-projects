
1.
**Entrada** (.cypher)

**Saída**

![myImage](assets/create_node.png)

```js
// node properties
<id>: 0
released: 1999
tagline: Welcome to the Real World
title: The Matrix
```

## 2. Músicos e Músicas gravadas (n-n)

### Criando arestas (Relacionamentos)

```sql
-- Criando nós dos músicos

CREATE(dylan:Musico{nome:'Bob Dylan', data_de_nascimento: '1941-05-24'})

CREATE(hendrix:Musico{nome:'Jimi Hendrix'})

CREATE(hendrix:Musico{nome:'Jimi Hendrix'})
```

```sql
-- Criando nós das músicas

CREATE(al_along:Musica{nome:'All Along The Watchtower'})
```

```sql
-- Criando aresta (relacionamento)

MATCH (hendrix:Musico{nome:'Jimi Hendrix'}),(al_along:Musica{nome:'All Along The Watchtower'})

-- r: relacionamento e ->: direção
CREATE (hendrix)-[r:gravou]->(al_along)
```

**Saída**

```sql
MATCH (m)
RETURN m
```

![myImage](assets/relationship.png)

```sql
MATCH (bob:Musico {nome: 'Bob Dylan'}), (al_along:Musica {nome: 'All Along The Watchtower'})
CREATE (bob)-[r:gravou]->(al_along)
CREATE (bob)-[s:compos]->(al_along)
```

**Saída**

```sql
MATCH (m)
RETURN m
```

![myImage](assets/relationship2.png)

### Utilizando filtros

```sql
MATCH(m:Musico {nome: 'Bob Dylan'})
RETURN m
```
**Saída**

```sql
MATCH (m)
RETURN m
```

![myImage](assets/filter.png)


```js
// node properties
<id>: 0
data_de_nascimento: 1941-05-24
nome: Bob Dylan
```

### Testando retornos

- nós com arestas incidentes (que chegam)
```sql
MATCH (n1)<-[]-()
RETURN n1
```

![myImage](assets/incident.png)

- nós com arestas não incidentes (que saem)
```sql
MATCH (n1)-[]->()
RETURN n1
```

![myImage](assets/not_incident.png)

- todos os relacionamentos
```sql
MATCH (n1:Musico)-[r]->(n2:Musica)
RETURN n1, type(r), n2
```

![myImage](assets/all_relationship.png)

```json
// Table Result Example

// n1
{
  "identity": 0,
  "labels": [
    "Musico"
  ],
  "properties": {
"nome": "Bob Dylan",
"data_de_nascimento": "1941-05-24"
  }
}

// type(r)
"compos"

// n2
{
  "identity": 2,
  "labels": [
    "Musica"
  ],
  "properties": {
"nome": "All Along The Watchtower"
  }
}

...
```

- todos os relacionamentos com filtro
```sql
MATCH (n1:Musico)-[r:compos]->(n2:Musica)
RETURN n1, type(r), n2
```

![myImage](assets/relationship_with_filter.png)

### Atualizando os elementos criados

- Modificando ou adicionando um atributo
```sql
MATCH (hendrix:Musico {nome: 'Jimi Hendrix'})
SET hendrix.data_de_nascimento = '1942-11-27'
```

- Excluindo um atributo
```js
<id>: 1
nome: Jimi Hendrix
```

- Excluindo um nó
```sql
--  primeiramente se remove todos os relacionamentos
MATCH (hendrix:Musico {nome: 'Jimi Hendrix'})-[r]-()
DELETE r
```

```sql
-- depois remove o nó
MATCH (hendrix:Musico {nome: 'Jimi Hendrix'})
DELETE hendrix
```

- Excluindo todo o banco
```sql
-- deleta todos os relacionamento e nós

MATCH (n)
OPTIONAL MATCH (n)-[rel]-()
DELETE rel, n
```

```json
"(no changes, no records)"
```

### Inserção sem duplicidade
```sql
MERGE (n1:Musico {nome: 'Bob Dylan'})
MERGE (n2:Musico {nome: 'Bob Dylan'})
```

### Importando arquivo CSV

```sql
LOAD CSV WITH HEADERS
FROM "https://raw.githubusercontent.com/neo4j-documentation/developer-resources/gh-pages/data/northwind/employees.csv"
AS linha
MERGE (empregado:Employee {nome: linha.FirstName + " " + linha.LastName})
MERGE (cidade:City {nome: linha.City})
MERGE (empregado)-[:`trabalha em`]->(cidade)
```

**Saída**

```sql
MATCH (m)
RETURN m
```

![myImage](assets/employees.png)

#### Retornando empregados que trabalham em Londres

```sql
MATCH (empregado:Employee)-[r:`trabalha em`]->(cidade:City)
WHERE cidade.nome = 'London'
RETURN empregado
```

**Saída**

```sql
MATCH (m)
RETURN m
```

![myImage](assets/london_employees.png)
