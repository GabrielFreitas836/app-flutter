const express = require('express');
const router = express.Router();

const userController = require('../controllers/userController.js');
const productController = require('../controllers/productController.js');

router.get('/orcamento/:userId', userController.listOrcamentoByUserId);
router.get('/products', productController.listAllProducts);

router.put('/orcamento/:userId', userController.RevampOrcamento);

router.post('/products/newProduct', productController.insertProduct);
router.post('/users/newUser', userController.singupUser);
router.post('/users/login', userController.loginUser);

router.delete('/products/:productId', productController.deleteProduct);

module.exports = router;
