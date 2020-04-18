CREATE TABLE Questionario (
	id BIGINT PRIMARY KEY,
	cod_q int,
	cod_a int,
    FOREIGN KEY (cod_q)
        REFERENCES Questoes (cod),
    FOREIGN KEY (cod_a)
        REFERENCES Alternativa (cod)
);

CREATE TABLE Progresso (
	id BIGINT PRIMARY KEY,
	cod_q int,
    FOREIGN KEY (cod_q)
        REFERENCES Questionario (cod)
);