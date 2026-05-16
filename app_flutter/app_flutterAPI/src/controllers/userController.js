const user = require('../services/userServices.js');

class UserController {

    async listOrcamentoByUserId(req, res) {

        let { userId } = req.params;

        try {
            
            let result = await user.getOrcamentoByUserId(req.params.userId);

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

module.exports = new UserController();
