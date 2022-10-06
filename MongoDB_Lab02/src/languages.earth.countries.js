// Acess MongoDB shell version v4.4.17

// ~$ mongo

// ~$ use earth

// Função de Mapeamento
function map() { emit( this.Language, 1 ); }

// Função de Redução: soma todos os valores com a mesma key (Language)
function reduce(key, value) { return Array.sum(value); }

// Função MapReduce
let res = db.countries.mapReduce(map, reduce, { out: { inline: 1 } });

// Função de Ordenação (Decrescente)
res.results.sort((a, b) => {
	return b.value - a.value;
});

// Função Filter: retorna as 10 primeiras linguagens  
let top10 = res.results.filter((item, index)=>{
  return index >= 0 && index < 10 ;
})
