
create database sobras_inteligente_new;

use sobras_inteligente_new;

-- 1. Usuário
CREATE TABLE usuario (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nome_usuario VARCHAR(255) NOT NULL,
    email_usuario VARCHAR(255) NOT NULL UNIQUE,
    senha_hash VARCHAR(255) NOT NULL,
    dt_nascimento_usuario DATE NOT NULL,
    tipo_usuario ENUM('comum', 'admin') DEFAULT 'comum',
    ativo BOOLEAN DEFAULT TRUE,
    preferencias_usuario VARCHAR(255),
    restricoes_usuario VARCHAR(255)
);

DESCRIBE usuario;

-- 2. Sessão de login
CREATE TABLE sessao (
    id_sessao INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT,
    token VARCHAR(255) NOT NULL,
    inicio DATETIME DEFAULT CURRENT_TIMESTAMP,
    expiracao DATETIME,
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario)
);

DESCRIBE sessao;

-- 3. Categoria de Ingrediente
CREATE TABLE categoria_ingrediente (
    id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    nome_categoria VARCHAR(50)
);

DESCRIBE categoria_ingrediente;

-- 4. Ingrediente
CREATE TABLE ingrediente (
    id_ingrediente INT AUTO_INCREMENT PRIMARY KEY,
    nome_ingrediente VARCHAR(50) NOT NULL,
    unidade_medida_ingrediente VARCHAR(20),
    id_categoria INT,
    FOREIGN KEY (id_categoria) REFERENCES categoria_ingrediente(id_categoria)
);

DESCRIBE Ingrediente;

-- 5. Receita
CREATE TABLE receita (
    id_receita INT AUTO_INCREMENT PRIMARY KEY,
    nome_receita VARCHAR(200) NOT NULL,
    descricao_receita TEXT NOT NULL,
    tempo_prep_receita VARCHAR(10),
    dificuldade_receita VARCHAR(10),
    categoria_receita VARCHAR(50),
    imagem_receita VARCHAR(255),
    modo_preparo TEXT
);

DESCRIBE receita;

-- 6. Associação receita-ingrediente
CREATE TABLE receita_ingrediente (
    id_receita INT,
    id_ingrediente INT,
    quantidade_receita_ingrediente DECIMAL(10,2),
    PRIMARY KEY (id_receita, id_ingrediente),
    FOREIGN KEY (id_receita) REFERENCES receita(id_receita),
    FOREIGN KEY (id_ingrediente) REFERENCES ingrediente(id_ingrediente)
);

DESCRIBE receita_ingrediente;

-- 7. Favoritos
CREATE TABLE usuario_receita_favorito (
    id_usuario INT,
    id_receita INT,
    PRIMARY KEY (id_usuario, id_receita),
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario),
    FOREIGN KEY (id_receita) REFERENCES receita(id_receita)
);

DESCRIBE usuario_receita_favorito;

-- 8. Estoque de ingredientes do usuário
CREATE TABLE estoque_usuario (
    id_estoque INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT,
    id_ingrediente INT,
    quantidade DECIMAL(10,2),
    data_validade DATE,
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario),
    FOREIGN KEY (id_ingrediente) REFERENCES ingrediente(id_ingrediente)
);

DESCRIBE estoque_usuario;

-- 9. Avaliação
CREATE TABLE avaliacao_receita (
    id_avaliacao INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT,
    id_receita INT,
    nota INT CHECK (nota BETWEEN 1 AND 5),
    comentario TEXT,
    data_avaliacao DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario),
    FOREIGN KEY (id_receita) REFERENCES receita(id_receita)
);

DESCRIBE avaliacao_receita;
