const express = require('express');
const api = express();

const cors = require('cors');

const router = require('./routes/routes.js');

api.use(express.json());
api.use(express.urlencoded({extended: false}));
api.use(cors());

api.use('/', router);

module.exports = api;
