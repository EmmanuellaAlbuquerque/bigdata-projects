// Acess MongoDB shell version v4.4.17

// ~$ mongo

// ~$ use twitter

// Função de Mapeamento
function map() {

	var hashtag_array = this.text.split(/[\s\r\n]/).filter((word) => word.startsWith('#'));
	
	for (let hashtag of hashtag_array) {
		emit(hashtag, 1);
	}
	
}

// Função de Redução: soma todos os valores com a mesma key (Language)
function reduce(key, value) { return Array.sum(value); }

// Função MapReduce
let res = db.tweet.mapReduce(map, reduce, { out: { inline: 1 } });

// Função de Ordenação (Decrescente)
res.results.sort((a, b) => {
	return b.value - a.value;
});

// Função Filter: retorna as 10 primeiras linguagens  
let top10 = res.results.filter((item, index)=>{
  return index >= 0 && index < 10 ;
})
