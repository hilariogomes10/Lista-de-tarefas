
-- ========================
-- PASSO 1: CRIAÇÃO DAS TABELAS
-- ========================

-- CLIENTE
CREATE TABLE CLIENTE (
    CodigoCliente INT PRIMARY KEY,
    Nome VARCHAR(100),
    Sexo VARCHAR(10),
    DataNascimento DATE,
    NIF VARCHAR(20) UNIQUE,
    Morada VARCHAR(255),
    Email VARCHAR(100) UNIQUE,
    Nacionalidade VARCHAR(50),
    TipoDocumento VARCHAR(50),
    NumeroDocumento VARCHAR(50)
);

-- EMPRESA
CREATE TABLE EMPRESA (
    CodigoEmpresa INT PRIMARY KEY,
    Nome VARCHAR(100),
    Morada VARCHAR(255),
    Telefone VARCHAR(20),
    Fax VARCHAR(20),
    Email VARCHAR(100) UNIQUE,
    Responsavel VARCHAR(100),
    NIF VARCHAR(20) UNIQUE
);

-- AGENCIA
CREATE TABLE AGENCIA (
    CodigoAgencia INT PRIMARY KEY,
    Nome VARCHAR(100),
    Morada VARCHAR(255),
    Telefone VARCHAR(20),
    Email VARCHAR(100) UNIQUE,
    NIF VARCHAR(20) UNIQUE,
    CodigoEmpresa INT,
    FOREIGN KEY (CodigoEmpresa) REFERENCES EMPRESA(CodigoEmpresa)
);

-- CONTRATO
CREATE TABLE CONTRATO (
    CodigoContrato INT PRIMARY KEY,
    CodigoAgencia INT,
    DataInicio DATE,
    DataFim DATE,
    Descricao TEXT,
    FOREIGN KEY (CodigoAgencia) REFERENCES AGENCIA(CodigoAgencia)
);

-- QUARTO
CREATE TABLE QUARTO (
    NumeroQuarto INT PRIMARY KEY,
    TipoQuarto VARCHAR(50),
    Capacidade INT,
    Andar INT,
    Estado ENUM('Disponível', 'Ocupado', 'Indisponível'),
    Vista VARCHAR(100),
    Equipamentos TEXT
);

-- RESERVA
CREATE TABLE RESERVA (
    CodigoReserva INT PRIMARY KEY,
    CodigoCliente INT,
    CodigoContrato INT,
    DataInicio DATE,
    DataFim DATE,
    TipoEstadia VARCHAR(50),
    TipoQuarto VARCHAR(50),
    ResponsavelPagamento VARCHAR(100),
    FOREIGN KEY (CodigoCliente) REFERENCES CLIENTE(CodigoCliente),
    FOREIGN KEY (CodigoContrato) REFERENCES CONTRATO(CodigoContrato)
);

-- ALOJAMENTO
CREATE TABLE ALOJAMENTO (
    CodigoAlojamento INT PRIMARY KEY,
    CodigoReserva INT,
    NumeroQuarto INT,
    DataCheckIn DATETIME,
    DataCheckOut DATETIME,
    FOREIGN KEY (CodigoReserva) REFERENCES RESERVA(CodigoReserva),
    FOREIGN KEY (NumeroQuarto) REFERENCES QUARTO(NumeroQuarto)
);

-- FATURA
CREATE TABLE FATURA (
    CodigoFatura INT PRIMARY KEY,
    CodigoAlojamento INT,
    DataEmissao DATE,
    ValorTotal DECIMAL(10,2),
    Estado ENUM('Emitida', 'Paga', 'Cancelada'),
    CodigoCliente INT,
    FOREIGN KEY (CodigoAlojamento) REFERENCES ALOJAMENTO(CodigoAlojamento),
    FOREIGN KEY (CodigoCliente) REFERENCES CLIENTE(CodigoCliente)
);

-- DETALHE_FATURA
CREATE TABLE DETALHE_FATURA (
    CodigoDetalhe INT PRIMARY KEY,
    CodigoFatura INT,
    Servico VARCHAR(100),
    Quantidade INT,
    PrecoUnitario DECIMAL(10,2),
    Imposto DECIMAL(5,2),
    ValorTotal DECIMAL(10,2),
    FOREIGN KEY (CodigoFatura) REFERENCES FATURA(CodigoFatura)
);

-- SERVICO_ADICIONAL
CREATE TABLE SERVICO_ADICIONAL (
    CodigoServico INT PRIMARY KEY,
    Descricao VARCHAR(100),
    Preco DECIMAL(10,2)
);

-- CONSUMO
CREATE TABLE CONSUMO (
    CodigoConsumo INT PRIMARY KEY,
    CodigoAlojamento INT,
    CodigoServico INT,
    DataConsumo DATE,
    Quantidade INT,
    ValorTotal DECIMAL(10,2),
    FOREIGN KEY (CodigoAlojamento) REFERENCES ALOJAMENTO(CodigoAlojamento),
    FOREIGN KEY (CodigoServico) REFERENCES SERVICO_ADICIONAL(CodigoServico)
);

-- TELEFONEMA
CREATE TABLE TELEFONEMA (
    CodigoTelefonema INT PRIMARY KEY,
    NumeroQuarto INT,
    NumeroDiscado VARCHAR(20),
    DataHoraInicio DATETIME,
    DataHoraFim DATETIME,
    Impulsos INT,
    Custo DECIMAL(10,2),
    FOREIGN KEY (NumeroQuarto) REFERENCES QUARTO(NumeroQuarto)
);

-- HISTORICO_OCUPACAO
CREATE TABLE HISTORICO_OCUPACAO (
    CodigoHistorico INT PRIMARY KEY,
    CodigoCliente INT,
    NumeroQuarto INT,
    DataCheckIn DATE,
    DataCheckOut DATE,
    Preferencias TEXT,
    FOREIGN KEY (CodigoCliente) REFERENCES CLIENTE(CodigoCliente),
    FOREIGN KEY (NumeroQuarto) REFERENCES QUARTO(NumeroQuarto)
);

-- LIMPEZA
CREATE TABLE LIMPEZA (
    CodigoLimpeza INT PRIMARY KEY,
    NumeroQuarto INT,
    DataHora DATETIME,
    Estado ENUM('Limpo', 'Sujo', 'Em limpeza'),
    FOREIGN KEY (NumeroQuarto) REFERENCES QUARTO(NumeroQuarto)
);

-- O resto dos passos será incluído a seguir...



-- ========================
-- PASSO 2: INSERÇÃO DE DADOS DE EXEMPLO
-- ========================

-- CLIENTE
INSERT INTO CLIENTE VALUES
(1, 'Hilário Gomes', 'Masculino', '2005-07-01', '123456789', 'Luanda', 'hilario@mail.com', 'Angolana', 'BI', '0000001');

-- EMPRESA
INSERT INTO EMPRESA VALUES
(1, 'Viagens Tropicais', 'Rua da Marginal, Luanda', '222333444', '222333445', 'contato@viagenstropicais.com', 'Carlos Silva', '987654321');

-- AGENCIA
INSERT INTO AGENCIA VALUES
(1, 'Agência Azul', 'Rua do Hotel, Luanda', '922111222', 'azul@agencia.com', '112233445', 1);

-- CONTRATO
INSERT INTO CONTRATO VALUES
(1, 1, '2025-01-01', '2025-12-31', 'Contrato anual com comissões');

-- QUARTO
INSERT INTO QUARTO VALUES
(101, 'Suite', 2, 1, 'Disponível', 'Mar', 'TV, AC, MiniBar');

-- RESERVA
INSERT INTO RESERVA VALUES
(1, 1, 1, '2025-04-10', '2025-04-15', 'Turismo', 'Suite', 'Hilário Gomes');

-- ALOJAMENTO
INSERT INTO ALOJAMENTO VALUES
(1, 1, 101, '2025-04-10 14:00:00', NULL);

-- FATURA
INSERT INTO FATURA VALUES
(1, 1, '2025-04-10', 50000.00, 'Emitida', 1);

-- DETALHE_FATURA
INSERT INTO DETALHE_FATURA VALUES
(1, 1, 'Hospedagem', 5, 10000.00, 14.00, 50000.00);

-- SERVICO_ADICIONAL
INSERT INTO SERVICO_ADICIONAL VALUES
(1, 'Spa', 5000.00);

-- CONSUMO
INSERT INTO CONSUMO VALUES
(1, 1, 1, '2025-04-12', 1, 5000.00);

-- TELEFONEMA
INSERT INTO TELEFONEMA VALUES
(1, 101, '923456789', '2025-04-11 10:00:00', '2025-04-11 10:10:00', 10, 100.00);

-- HISTORICO_OCUPACAO
INSERT INTO HISTORICO_OCUPACAO VALUES
(1, 1, 101, '2025-04-10', '2025-04-15', 'Vista mar');

-- LIMPEZA
INSERT INTO LIMPEZA VALUES
(1, 101, '2025-04-10 08:00:00', 'Limpo');

-- ========================
-- PASSO 3: CONSULTAS E REGRAS
-- ========================

-- 1. Verificar reservas ativas
SELECT * FROM RESERVA
WHERE CURDATE() BETWEEN DataInicio AND DataFim;

-- 2. Consultar estado dos quartos
SELECT NumeroQuarto, Estado FROM QUARTO;

-- 3. Consultar faturas por cliente
SELECT f.CodigoFatura, f.DataEmissao, f.ValorTotal, f.Estado
FROM FATURA f
JOIN CLIENTE c ON f.CodigoCliente = c.CodigoCliente
WHERE c.Nome = 'Hilário Gomes';

-- 4. Verificar consumos de serviços adicionais
SELECT s.Descricao, c.Quantidade, c.ValorTotal
FROM CONSUMO c
JOIN SERVICO_ADICIONAL s ON c.CodigoServico = s.CodigoServico
WHERE c.CodigoAlojamento = 1;

-- 5. Mostrar histórico de ocupação de um cliente
SELECT * FROM HISTORICO_OCUPACAO
WHERE CodigoCliente = 1;

-- 6. Atualizar estado de fatura para paga após pagamento
UPDATE FATURA SET Estado = 'Paga' WHERE CodigoFatura = 1;

-- 7. Restrições de regra de negócio seriam aplicadas na lógica do sistema.
