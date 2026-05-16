const express = require('express');
const router = express.Router();

const userController = require('../controllers/userController.js');

router.get('/orcamento/:userId', userController.listOrcamentoByUserId);

module.exports = router;
