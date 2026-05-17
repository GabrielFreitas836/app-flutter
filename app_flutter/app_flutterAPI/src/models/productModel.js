const knex = require('../data/connection.js');

class Product {
    async getAllProducts() {
        let products = await knex('produto as p')
        .select('p.descricao as produto', 'p.valor_unitario', 'p.tipo_unidade', 'ca.descricao as categoria')
        .join('categoria as ca', 'p.categoria_idcategoria', '=', 'ca.idcategoria')
        .orderBy('p.idProduto');

        return products;
    }

    async newProduct(description, p_value, v_type, categoryId) {
        let product = await knex('produto').insert({
            descricao: description,
            valor_unitario: p_value,
            tipo_unidade: v_type,
            categoria_idcategoria: categoryId
        });

        return product;
    }

    async removeProduct(productId) {
        let product = await knex('produto')
        .where({'idProduto': productId})
        .delete();

        return product;
    }
}

module.exports = new Product();
