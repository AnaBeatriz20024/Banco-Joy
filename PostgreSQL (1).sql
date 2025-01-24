CREATE TABLE clientes (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    telefone VARCHAR(20)
);

CREATE TABLE produtos (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    preco DECIMAL(10,2) NOT NULL
);

CREATE TABLE pedidos (
    id SERIAL PRIMARY KEY,
    cliente_id INT NOT NULL,
    data_pedido DATE NOT NULL,
    total DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (cliente_id) REFERENCES clientes(id)
);


CREATE TABLE itens_pedido (
    id SERIAL PRIMARY KEY,
    pedido_id INT NOT NULL,
    produto_id INT NOT NULL,
    quantidade INT NOT NULL,
    preco_unitario DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (pedido_id) REFERENCES pedidos(id),
    FOREIGN KEY (produto_id) REFERENCES produtos(id)
);

INSERT INTO clientes (nome, email, telefone) VALUES
('Maria Silva', 'maria@email.com', '11999999999'),
('João Souza', 'joao@email.com', '11888888888');

INSERT INTO produtos (nome, preco) VALUES
('Camiseta Personalizada', 39.90),
('Caneca Personalizada', 24.50),
('Chaveiro Personalizado', 12.00);

INSERT INTO pedidos (cliente_id, data_pedido, total) VALUES
(1, '2025-01-20', 76.40),
(2, '2025-01-21', 49.00);

INSERT INTO itens_pedido (pedido_id, produto_id, quantidade, preco_unitario) VALUES
(1, 1, 1, 39.90),
(1, 3, 2, 12.00),
(2, 2, 2, 24.50);




SELECT 
    p.id AS pedido_id, 
    c.nome AS cliente, 
    p.data_pedido, 
    p.total
FROM pedidos p
JOIN clientes c ON p.cliente_id = c.id;


SELECT 
    ip.pedido_id, 
    pr.nome AS produto, 
    ip.quantidade, 
    ip.preco_unitario,
    (ip.quantidade * ip.preco_unitario) AS subtotal
FROM itens_pedido ip
JOIN produtos pr ON ip.produto_id = pr.id
WHERE ip.pedido_id = 1;


SELECT 
    c.nome AS cliente, 
    SUM(p.total) AS total_gasto
FROM pedidos p
JOIN clientes c ON p.cliente_id = c.id
GROUP BY c.nome;


SELECT 
    p.id AS pedido_id, 
    c.nome AS cliente, 
    pr.nome AS produto, 
    ip.quantidade, 
    ip.preco_unitario
FROM pedidos p
JOIN clientes c ON p.cliente_id = c.id
JOIN itens_pedido ip ON p.id = ip.pedido_id
JOIN produtos pr ON ip.produto_id = pr.id;

