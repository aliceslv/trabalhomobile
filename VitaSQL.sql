-- TABELA: usuario

CREATE TABLE usuario (
    id         SERIAL PRIMARY KEY,
    email      VARCHAR(255) NOT NULL UNIQUE,
    senha      VARCHAR(255) NOT NULL,
    criado_em  TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- TABELA: perfil

CREATE TABLE perfil (
    id          SERIAL PRIMARY KEY,
    id_usuario  INT NOT NULL UNIQUE,
    nome        VARCHAR(100) NOT NULL,
    data_nasc   DATE,
    sexo        CHAR(1),          
    peso        DECIMAL(5, 2),    
    altura      DECIMAL(5, 2),   
    idr         DECIMAL(7, 2),    
    CONSTRAINT fk_perfil_usuario
        FOREIGN KEY (id_usuario) REFERENCES usuario (id)
        ON DELETE CASCADE
);

-- TABELA: meta

CREATE TABLE meta (
    id          SERIAL PRIMARY KEY,
    id_usuario  INT NOT NULL,
    tipo        VARCHAR(50) NOT NULL,   
    peso_meta   DECIMAL(5, 2),          
    criado_em   TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_meta_usuario
        FOREIGN KEY (id_usuario) REFERENCES usuario (id)
        ON DELETE CASCADE
);

-- TABELA: nivel_exercicio

CREATE TABLE nivel_exercicio (
    id          SERIAL PRIMARY KEY,
    id_usuario  INT NOT NULL,
    frequencia  VARCHAR(50) NOT NULL,  
    CONSTRAINT fk_nivel_exercicio_usuario
        FOREIGN KEY (id_usuario) REFERENCES usuario (id)
        ON DELETE CASCADE
);

-- TABELA: configuracao

CREATE TABLE configuracao (
    id                  SERIAL PRIMARY KEY,
    id_usuario          INT NOT NULL UNIQUE,
    notificacao_ativa   BOOLEAN NOT NULL DEFAULT TRUE,
    senha               VARCHAR(255),
    nova_senha          VARCHAR(255), 
    CONSTRAINT fk_configuracao_usuario
        FOREIGN KEY (id_usuario) REFERENCES usuario (id)
        ON DELETE CASCADE
);

-- TABELA: lembrete

CREATE TABLE lembrete (
    id          SERIAL PRIMARY KEY,
    id_usuario  INT NOT NULL,
    titulo      VARCHAR(150) NOT NULL,
    ativo       BOOLEAN NOT NULL DEFAULT TRUE,
    tipo        VARCHAR(50), 
    horario     TIME NOT NULL,
    CONSTRAINT fk_lembrete_usuario
        FOREIGN KEY (id_usuario) REFERENCES usuario (id)
        ON DELETE CASCADE
);

-- TABELA: alimento

CREATE TABLE alimento (
    id                   SERIAL PRIMARY KEY,
    nome_alimento        VARCHAR(150) NOT NULL,
    calorias_cemgramas   DECIMAL(7, 2) NOT NULL, 
    proteinas            DECIMAL(6, 2),
    carboidratos         DECIMAL(6, 2), 
    gorduras             DECIMAL(6, 2) 
);

-- TABELA: refeicao

CREATE TABLE refeicao (
    id               SERIAL PRIMARY KEY,
    id_usuario       INT NOT NULL,
    data             DATE NOT NULL,
    calorias_total   DECIMAL(8, 2), 
    tipo             VARCHAR(50) NOT NULL, 
    CONSTRAINT fk_refeicao_usuario
        FOREIGN KEY (id_usuario) REFERENCES usuario (id)
        ON DELETE CASCADE
);

-- TABELA: refeicao_alimento  (tabela de junção N:N)

CREATE TABLE refeicao_alimento (
    id_refeicao  INT NOT NULL,
    id_alimento  INT NOT NULL,
    peso_comida  DECIMAL(7, 2) NOT NULL,
    PRIMARY KEY (id_refeicao, id_alimento),
    CONSTRAINT fk_ra_refeicao
        FOREIGN KEY (id_refeicao) REFERENCES refeicao (id)
        ON DELETE CASCADE,
    CONSTRAINT fk_ra_alimento
        FOREIGN KEY (id_alimento) REFERENCES alimento (id)
        ON DELETE RESTRICT
);

-- ÍNDICES

CREATE INDEX idx_refeicao_usuario_data   ON refeicao (id_usuario, data);
CREATE INDEX idx_lembrete_usuario        ON lembrete (id_usuario);
CREATE INDEX idx_meta_usuario            ON meta (id_usuario);
CREATE INDEX idx_nivel_exercicio_usuario ON nivel_exercicio (id_usuario);

