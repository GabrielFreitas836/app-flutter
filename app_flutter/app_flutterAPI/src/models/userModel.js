const knex = require('../data/connection.js');

class User {

    async getOrcamentoByUserId(userId) {
        let orcamento = await knex('usuario').select(["orcamento"]).where({'idUsuario': userId}).first();
        return orcamento;
    }
}

module.exports = new User();
