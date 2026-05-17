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

    async RevampOrcamento(req, res) {

        let { userId } = req.params;
        let { orcamento } = req.body;

        try {
            
            let result = await user.updateOrcamentoByUserId(req.params.userId, orcamento);

            if (result.validated && !result.isBadRequest)
            {
                res.status(200).json({success: true, message: result.message});
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

    async singupUser(req, res) {
        
        let { nome, email, senha } = req.body;

        try {
            
            let result = await user.newUser(nome, email, senha);

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

    async loginUser(req, res) {

        let { email, senha } = req.body;

        try {
            
            let result = await user.getUserByCredentials(email, senha);

            if (result.validated && !result.isBadRequest)
            {
                res.status(200).json({success: true, message: result.message, token: result.token});
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

module.exports = new UserController();
