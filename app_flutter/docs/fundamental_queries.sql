USE app_flutterdb;

-- Inserindo dados para tabela de 'categoria'
INSERT INTO categoria (descricao) VALUES
('açougue'),
('hortifruti'),
('limpeza'),
('higiene'),
('doces'),
('festa');

-- Inserindo dados para tabela de 'produto'
INSERT INTO produto (descricao, valor_unitario, tipo_unidade, categoria_idcategoria) VALUES
('picanha bovina', 30.00, 'KG', 1),
('banana prata', 15.00, 'KG', 2),
('detergente liquido', '8.50', 'UN', 3),
('shampoo anticaspa', 10.00, 'UN', 4),
('chocolate ao leite', 12.00, 'UN', 5),
('refrigerante coca-cola', 15.00, 'L', 6);

-- Inserindo um usuário para tabela de 'usuario'
INSERT INTO usuario (nome, email, senha, orcamento) VALUES
('teste', 'teste.teste@email.com', '123', 0);

-- Visualizando valores das tabelas do banco
SELECT * FROM categoria;
SELECT * FROM usuario;
SELECT * FROM produto;

-- Visualizando valores em conjunto das tabelas 'produto' e 'categoria'
SELECT p.descricao, p.valor_unitario, p.tipo_unidade, ca.descricao 
FROM produto p JOIN categoria ca 
ON p.categoria_idcategoria = ca.idcategoria
ORDER BY p.idproduto;