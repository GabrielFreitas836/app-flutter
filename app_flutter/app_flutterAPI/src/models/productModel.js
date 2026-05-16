const knex = require('../data/connection.js');

class Product {
    async getAllProducts() {
        let products = await knex('produto as p')
        .select('p.descricao as produto', 'p.valor_unitario', 'p.tipo_unidade', 'ca.descricao as categoria')
        .join('categoria as ca', 'p.categoria_idcategoria', '=', 'ca.idcategoria')
        .orderBy('p.idProduto');

        return products;
    }
}

module.exports = new Product();
