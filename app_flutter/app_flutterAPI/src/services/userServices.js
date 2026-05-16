const user = require('../models/userModel.js');

class UserService {

    async getOrcamentoByUserId(userId) {

        try {
            if (!Number.isInteger(parseInt(userId)))
            {
                return {validated: false, message: "ID de usuário inválido!"}
            }
            else 
            {
                let orcamento = await user.getOrcamentoByUserId(userId);

                if (orcamento !== undefined)
                {
                    return {validated: true, values: orcamento};
                }
                else 
                {
                    return {validated: false, message: "Usuário não encontrado"};
                }
            }
        } catch (error) {
            return {validated: false, message: error.message};
        }
    }
}

module.exports = new UserService();
