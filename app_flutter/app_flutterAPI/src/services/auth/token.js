const jwt = require('jsonwebtoken');

require('dotenv').config();

class Token {

    generateToken(userId) {

        if(userId !== undefined)
        {
            const token = jwt.sign({ idUsuario: userId }, process.env.SECRET, {expiresIn: '7d'});
            return token;
        }
        else 
        {
            throw new Error("ID de usuário inválido");
        }
    }

    verifyToken(token) {

        try {
            const decoded = jwt.verify(token, process.env.SECRET);
            return decoded;
            
        } catch (error) {
            throw new Error(`Token inválido!: ${error.message}`);
        }
    }
}

module.exports = new Token();
