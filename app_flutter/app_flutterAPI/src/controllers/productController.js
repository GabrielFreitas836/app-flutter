const products = require('../services/productServices.js');

class ProductController {

    async listAllProducts(req, res) {

        try {
            
            let result = await products.getAllProducts();

            if (result.validated)
            {
                res.status(200).json({success: true, values: result.values});
            }
            else 
            {
                res.status(404).json({success: false, message: result.message});
            }
        } catch (error) {
            res.status(500).json({success: false, message: "Erro interno do servidor!", error: error.message});
        }
    }

    async insertProduct(req, res) {

        let { descricao, valor_unitario, tipo_unidade, categoria_id } = req.body;

        try {
            
            let result = await products.addNewProduct(descricao, valor_unitario, tipo_unidade, categoria_id);

            if (result.validated && !result.isBadRequest)
            {
                res.status(201).json({success: true, message: result.message});
            }
            else if (!result.validated && !result.isBadRequest)
            {
                res.status(404).json({success: false, message: result.message});
            }
            else if (!result.validated && result.isBadRequest)
            {
                res.status(400).json({success: false, message: result.message});
            }
        } catch (error) {
            res.status(500).json({success: false, message: "Erro interno do servidor!", error: error.message});
        }
    }
}

module.exports = new ProductController();
