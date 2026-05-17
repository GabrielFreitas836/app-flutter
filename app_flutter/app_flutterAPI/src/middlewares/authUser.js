const token = require('../services/auth/token.js');

function authUser(req, res, next) {
    const authHeader = req.headers['authorization'];

    if (!authHeader) {
        return res.status(401).json({success: false, message: "Token não fornecido!"});
    }

    const authToken = authHeader.replace('Bearer ', '');

    try {
        const decoded = token.verifyToken(authToken);
        req.user = decoded;
        next();
    } catch (error) {
        return res.status(401).json({success: false, message: error.message});
    }
}

module.exports = authUser;