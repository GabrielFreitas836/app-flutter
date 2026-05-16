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
}

module.exports = new ProductServices();
