const products = require('../models/productModel.js');

class ProductServices {

    async getAllProducts() {

        try {
            let productList = await products.getAllProducts();

            if (productList.length !== 0)
            {
                return {validated: true, values: productList};
            }
            else 
            {
                return {validated: false, message: "Nenhum produto encontrado!"};
            }
        } catch (error) {
            return {validated: false, message: error.message};
        }
    }

    async addNewProduct(description, p_value, v_type, categoryId) {

        try {
            if (description == null || p_value == null || v_type == null || categoryId == null)
            {
                return {validated: false, isBadRequest: true, message: "Preencha os campos vazios!"};
            }
            else if (!Number.isFinite(parseFloat(p_value) || !Number.isInteger(parseInt(categoryId))))
            {
                return {validated: false, isBadRequest: true, message: "Há, pelo menos, 1 atributo númerico inválido!"};
            }
            else {
                let newProduct = await products.newProduct(description, p_value, v_type, categoryId);

                if (newProduct.length === 0)
                {
                    return {validated: false, isBadRequest: false, message: "Falha em adicionar novo produto!"};
                }
                else 
                {
                    return {validated: true, isBadRequest: false, message: "Produto adicionado com sucesso!"};
                }
            }
        } catch (error) {
            return {validated: false, isBadRequest: false, message: error.message};
        }
    }
}

module.exports = new ProductServices();
