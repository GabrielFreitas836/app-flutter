const express = require('express');
const api = require('./src/api.js');
require('dotenv').config();

const PORT = process.env.DB_PORT || 3000;

api.listen(PORT, () => {
    console.log(`API rodando na porta ${PORT}`);
})
