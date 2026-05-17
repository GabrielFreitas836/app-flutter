const knex = require('../data/connection.js');

class User {

    async getOrcamentoByUserId(userId) {
        let orcamento = await knex('usuario').select(["orcamento"])
        .where({'idUsuario': userId}).first();

        return orcamento;
    }

    async updateOrcamentoByUserId(userId, orcamento) {
        let updated_orcamento = await knex('usuario')
        .where({'idUsuario': userId})
        .update({'orcamento': orcamento});

        return updated_orcamento;
    }

    async newUser(name, email, password) {
        let user = await knex('usuario').insert({
            nome: name,
            email: email,
            senha: password,
            orcamento: null
        });

        return user;
    }

    async getUserByCredentials(email, password) {
        let user = await knex('usuario').select(["idUsuario", "email", "senha"])
        .where({'email': email, 'senha': password}).first();

        return user;
    }
}

module.exports = new User();
