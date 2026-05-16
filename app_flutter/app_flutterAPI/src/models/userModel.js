const knex = require('../data/connection.js');

class User {

    async getOrcamentoByUserId(userId) {
        let orcamento = await knex('usuario').select(["orcamento"]).where({'idUsuario': userId}).first();
        return orcamento;
    }

    async updateOrcamentoByUserId(userId, orcamento) {
        let updated_orcamento = await knex('usuario')
        .where({'idUsuario': userId})
        .update({'orcamento': orcamento});

        return updated_orcamento;
    }
}

module.exports = new User();
