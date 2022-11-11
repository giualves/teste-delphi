# teste-delphi

Comandos para criar o banco de dados e inserir os registros necessários:

DROP SCHEMA `testedelphi`;
CREATE SCHEMA `testedelphi` ;
use testedelphi;

CREATE USER 'delphiuser'@'localhost' IDENTIFIED WITH mysql_native_password BY 'password';

GRANT ALL PRIVILEGES ON * . * TO 'delphiuser'@'localhost';

CREATE TABLE `estabelecimento` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `nome` varchar(255) DEFAULT NULL,
  `taxa_frete` decimal(19,2) NOT NULL,  
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `cliente` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL, 
  `limite_credito` decimal(19,2) NOT NULL,
  `cidade` varchar(100) DEFAULT NULL,
  `uf` varchar(2) DEFAULT NULL,  
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `pedido` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `total` decimal(19,2) NOT NULL,  
  `emissao` datetime,
  `cli_idf` bigint DEFAULT NULL,  
  PRIMARY KEY (`id`),
  KEY `FK_cliente_id` (`cli_idf`),
  CONSTRAINT `FK_cliente_id` FOREIGN KEY (`cli_idf`) REFERENCES `cliente` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `item` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  `preco` decimal(19,2) NOT NULL,  
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `pedido_item` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `quantidade` int DEFAULT NULL,
  `valorunit` decimal(19,2) NOT NULL, 
  `total` decimal(19,2) NOT NULL, 
  `ped_idf` bigint NOT NULL,
  `item_idf` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_pedido_id` (`ped_idf`),
  KEY `FK_item_id` (`item_idf`),
  CONSTRAINT `FK_pedido_id` FOREIGN KEY (`ped_idf`) REFERENCES `pedido` (`id`),
  CONSTRAINT `FK_item_id` FOREIGN KEY (`item_idf`) REFERENCES `item` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


INSERT INTO estabelecimento values (1, 'RESTAURANTE 1', 12);
INSERT INTO item values (1, 'COCA COLA 350ML', 6);
INSERT INTO item values (2, 'COCA COLA 600ML', 10);
INSERT INTO item values (3, 'X BURGER', 16);
INSERT INTO item values (4, 'X SALADA', 18);
INSERT INTO item values (6, 'X TUDO', 25);
INSERT INTO item values (7, 'PRODUTO TESTE 7', 20);
INSERT INTO item values (8, 'PRODUTO TESTE 8', 21);
INSERT INTO item values (9, 'PRODUTO TESTE 9', 22);
INSERT INTO item values (10, 'PRODUTO TESTE 10', 23);
INSERT INTO item values (11, 'PRODUTO TESTE 11', 24);
INSERT INTO item values (12, 'PRODUTO TESTE 12', 25);
INSERT INTO item values (13, 'PRODUTO TESTE 13', 26);
INSERT INTO item values (14, 'PRODUTO TESTE 14', 27);
INSERT INTO item values (15, 'PRODUTO TESTE 15', 28);
INSERT INTO item values (16, 'PRODUTO TESTE 16', 29);
INSERT INTO item values (17, 'PRODUTO TESTE 17', 30);
INSERT INTO item values (18, 'PRODUTO TESTE 18', 35);
INSERT INTO item values (19, 'PRODUTO TESTE 19', 40);
INSERT INTO item values (20, 'PRODUTO TESTE 20', 50);

INSERT INTO cliente values (1, 'JUCA BALA', 100, 'Florianópolis', 'SC');
INSERT INTO cliente values (2, 'ANTONIO BANDEIRAS NACIONAIS', 150, 'Florianópolis', 'SC');
INSERT INTO cliente values (3, 'GIULIANNO ALVES', 200,  'Florianópolis', 'SC');
INSERT INTO cliente values (4, 'CLIENTE TESTE 4', 200,  'Florianópolis', 'SC');
INSERT INTO cliente values (5, 'CLIENTE TESTE 5', 200,  'Florianópolis', 'SC');
INSERT INTO cliente values (6, 'CLIENTE TESTE 6', 200,  'Florianópolis', 'SC');
INSERT INTO cliente values (7, 'CLIENTE TESTE 7', 200,  'Florianópolis', 'SC');
INSERT INTO cliente values (8, 'CLIENTE TESTE 8', 200,  'Florianópolis', 'SC');
INSERT INTO cliente values (9, 'CLIENTE TESTE 9', 200,  'Florianópolis', 'SC');
INSERT INTO cliente values (10,'CLIENTE TESTE 10', 200,  'Florianópolis', 'SC');
INSERT INTO cliente values (11, 'CLIENTE TESTE 11', 200,  'Florianópolis', 'SC');
INSERT INTO cliente values (12, 'CLIENTE TESTE 12', 200,  'Florianópolis', 'SC');
INSERT INTO cliente values (13, 'CLIENTE TESTE 13', 200,  'Florianópolis', 'SC');
INSERT INTO cliente values (14, 'CLIENTE TESTE 14', 200,  'Florianópolis', 'SC');
INSERT INTO cliente values (15, 'CLIENTE TESTE 15', 200,  'Florianópolis', 'SC');
INSERT INTO cliente values (16, 'CLIENTE TESTE 16', 200,  'Florianópolis', 'SC');
INSERT INTO cliente values (17, 'CLIENTE TESTE 17', 200,  'Florianópolis', 'SC');
INSERT INTO cliente values (18, 'CLIENTE TESTE 18', 200,  'Florianópolis', 'SC');
INSERT INTO cliente values (19, 'CLIENTE TESTE 19', 200,  'Florianópolis', 'SC');
INSERT INTO cliente values (20, 'CLIENTE TESTE 20', 200,  'Florianópolis', 'SC');
