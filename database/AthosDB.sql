CREATE TABLE GrupoEmpresa
(
    grupoEmpresa_id     BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    grupoEmpresa_nome   VARCHAR(250) NOT NULL
);

CREATE TABLE Usuarios
(
    usuario_id          BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nome_usuario        VARCHAR(250) NOT NULL,
    grupoEmpresa_id     BIGINT NOT NULL,
    usuario_papel       VARCHAR(100) NOT NULL,

    CONSTRAINT fk_usuarios_grupoEmpresa FOREIGN KEY (grupoEmpresa_id)
        REFERENCES GrupoEmpresa(grupoEmpresa_id)
);

CREATE TABLE Chamado
(
    chamado_id          BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    codigo_publico      BIGINT NOT NULL,
    usuario_id          BIGINT NOT NULL,
    grupoEmpresa_id     BIGINT NOT NULL,
    produto             VARCHAR(100) NOT NULL,
    categoria           VARCHAR(100) NOT NULL,
    status              VARCHAR(50) NOT NULL,
    prioridade          VARCHAR(50) NOT NULL,
    sla_prazo           VARCHAR(100) NOT NULL,
    criado_em           DATE NOT NULL,
    fechado_em          DATE NOT NULL,

    CONSTRAINT fk_chamado_grupoEmpresa FOREIGN KEY (grupoEmpresa_id)
        REFERENCES GrupoEmpresa(grupoEmpresa_id),
    CONSTRAINT fk_chamado_usuarios FOREIGN KEY (usuario_id)
        REFERENCES Usuarios(usuario_id)
);

CREATE TABLE Interacao
(
    interacao_id        BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    chamado_id          BIGINT NOT NULL,
    autor               VARCHAR(250) NOT NULL,
    tipo                VARCHAR(50) NOT NULL,
    mensagem            VARCHAR(200) NOT NULL,
    anexos              TEXT,
    criado_em           DATE NOT NULL,

    CONSTRAINT fk_interacao_chamado FOREIGN KEY (chamado_id)
        REFERENCES Chamado(chamado_id)
);

CREATE TABLE SLA_Categoria
(
    sla_id              BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    produto             VARCHAR(100) NOT NULL,
    categoria           VARCHAR(100) NOT NULL,
    prioridade          VARCHAR(50) NOT NULL,
    tempo_resposta      TIME NOT NULL,
    tempo_resolucao     TIME NOT NULL
);

CREATE TABLE Log_Auditoria
(
    log_id              BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    chamado_id          BIGINT NOT NULL,
    usuario_id          BIGINT NOT NULL,
    acao                VARCHAR(200) NOT NULL,
    campo_alterado      VARCHAR(100) NOT NULL,
    valor_anterior      DOUBLE PRECISION NOT NULL,
    valor_novo          DOUBLE PRECISION NOT NULL,
    log_data            DATE NOT NULL,

    CONSTRAINT fk_log_chamado FOREIGN KEY (chamado_id)
        REFERENCES Chamado(chamado_id),
    CONSTRAINT fk_log_usuario FOREIGN KEY (usuario_id)
        REFERENCES Usuarios(usuario_id)
);