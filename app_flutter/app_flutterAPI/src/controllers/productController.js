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
    
}

module.exports = new ProductController();
