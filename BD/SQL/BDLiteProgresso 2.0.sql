CREATE TABLE Questionario (
	cod_p int,
	cod_q int,
	cod_a int,
    FOREIGN KEY (cod_p)
        REFERENCES Progresso (id)
);

CREATE TABLE Progresso (
	id BIGINT PRIMARY KEY,
	tempo_total INT, -- Tempo total para a realização do questionário.
	tempo_realizacao INT, -- Tempo gasto.
	data_time TIMESTAMP -- Data de realização do questionário.
);