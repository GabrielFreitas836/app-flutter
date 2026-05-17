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

    async updateOrcamentoByUserId(userId, orcamento) {

        try {
            if (!Number.isInteger(parseInt(userId)))
            {
                return {validated: false, isBadRequest: true, message: "ID de usuário inválido!"};
            }
            else if (!Number.isFinite(parseFloat(orcamento)))
            {
                return {validated: false, isBadRequest: true, message: "Valor de orçamento inválido!"};
            }
            else 
            {
                let updated_orcamento = await user.updateOrcamentoByUserId(userId, orcamento);

                if (updated_orcamento == 0)
                {
                    return {validated: false, isBadRequest: false, message: "Falha ao atualizar o orçamento!"};
                }
                else 
                {
                    return {validated: true, isBadRequest: false, message: "Orçamento atualizado com sucesso!"};
                }
            }
        } catch (error) {
            return {validated: false, isBadRequest: false, message: error.message};
        }
    }

    async newUser(name, email, password) {

        try {
            if (name == null || email == null || password == null)
            {
                return {validated: false, isBadRequest: true, message: "Preencha os campos vazios!"};
            }
            else 
            {
                let newUser = await user.newUser(name, email, password);

                if (newUser.length == 0)
                {
                    return {validated: false, isBadRequest: false, message: "Falha ao cadastrar um novo usuário!"};
                }
                else 
                {
                    return {validated: true, isBadRequest: false, message: "Usuário cadastrado com sucesso!"};
                }
            }
        } catch (error) {
            return {validated: false, isBadRequest: false, message: error.message};
        }
    }

    async getUserByCredentials(email, password) {

        try {
            if (email == null || password == null)
            {
                return {validated: false, isBadRequest: true, message: "Preencha os campos vazios!"};
            }
            else 
            {
                let getUser = await user.getUserByCredentials(email, password);

                if (getUser !== undefined)
                {
                    return {validated: true, isBadRequest: false, message: "Usuário logado com sucesso!"};
                }
                else 
                {
                    return {validated: false, isBadRequest: false, message: "Usuário não encontrado!"};
                }
            }
        } catch (error) {
            return {validated: false, isBadRequest: false, message: error.message};
        }
    }
}

module.exports = new UserService();
