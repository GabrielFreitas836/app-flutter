const express = require('express');
const router = express.Router();

const authUser = require('../middlewares/authUser.js');

const userController = require('../controllers/userController.js');
const productController = require('../controllers/productController.js');

router.get('/orcamento/:userId', authUser, userController.listOrcamentoByUserId);
router.get('/products', authUser, productController.listAllProducts);

router.put('/orcamento/:userId', authUser, userController.RevampOrcamento);

router.post('/products/newProduct', authUser, productController.insertProduct);
router.post('/users/newUser', userController.singupUser);
router.post('/users/login', userController.loginUser);

router.delete('/products/:productId', authUser, productController.deleteProduct);

module.exports = router;
