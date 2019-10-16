-- http://www.dpriver.com/pp/sqlformat.htm
CREATE TABLE Questoes (
    cod BIGINT PRIMARY KEY,
    enunciado TEXT,
    dificuldade TEXT CHECK (dificuldade IN ('Fácil' , 'Médio', 'Difícil')),
    referencia TEXT
);

CREATE TABLE Alternativa (
    cod BIGINT PRIMARY KEY,
    cod_q BIGINT REFERENCES Questoes (cod)
    ON DELETE CASCADE ON UPDATE CASCADE,
    classificacao BOOLEAN DEFAULT FALSE,
    resposta TEXT,
    justificativa TEXT
);

CREATE TABLE Area_Conhecimento (
    cod_area INTEGER PRIMARY KEY AUTOINCREMENT,
    nome_area TEXT NOT NULL UNIQUE
);

CREATE TABLE Disciplina (
    cod_disciplina INTEGER PRIMARY KEY AUTOINCREMENT,
    nome_disciplina TEXT,
    cod_area INT,
    FOREIGN KEY (cod_area)
        REFERENCES area_conhecimento (cod_area)
        ON DELETE CASCADE ON UPDATE CASCADE
);
  
CREATE TABLE Conteudo (
    cod_conteudo INTEGER PRIMARY KEY AUTOINCREMENT,
    nome_conteudo TEXT,
    descricao_conteudo TEXT
);

CREATE TABLE Disciplina_Conteudo (
    serie INT,
    cod_disciplina INT,
    cod_conteudo INT,
    FOREIGN KEY (cod_disciplina)
        REFERENCES disciplina (cod_disciplina),
    FOREIGN KEY (cod_conteudo)
        REFERENCES conteudo (cod_conteudo)
);

CREATE TABLE Conteudo_Questao (
    cod_conteudo INT,
    cod_questao BIGINT,
    FOREIGN KEY (cod_conteudo)
        REFERENCES conteudo (cod_conteudo),
    FOREIGN KEY (cod_questao)
        REFERENCES Questoes (cod)
);

-- ---------------------------------------------------------------------------------------------------
-- Preenchendo das Áreas do Conhecimento                                                           --
-- ---------------------------------------------------------------------------------------------------
-- UPDATE sqlite_sequence SET seq = 0 WHERE name = 'Area_Conhecimento';
INSERT INTO Area_Conhecimento  (nome_area)  VALUES ('Ciências Humanas e suas Tecnologias');
INSERT INTO Area_Conhecimento  (nome_area)  VALUES ('Ciências da Natureza e suas Tecnologias');
INSERT INTO Area_Conhecimento  (nome_area)  VALUES ('Linguagens, Códigos e suas Tecnologias');
INSERT INTO Area_Conhecimento  (nome_area)  VALUES ('Matemática e suas Tecnologias');
SELECT * FROM Area_Conhecimento;

-- ---------------------------------------------------------------------------------------------------
-- Preenchendo das Disciplinas                                                                     --
-- ---------------------------------------------------------------------------------------------------

-- UPDATE sqlite_sequence SET seq = 0 WHERE name = 'Disciplina';
INSERT INTO Disciplina (cod_area, nome_disciplina) VALUES (1, 'História');
INSERT INTO Disciplina (cod_area, nome_disciplina) VALUES (1, 'Geografia');
INSERT INTO Disciplina (cod_area, nome_disciplina) VALUES (1, 'Filosofia');
INSERT INTO Disciplina (cod_area, nome_disciplina) VALUES (1, 'Sociologia');

INSERT INTO Disciplina (cod_area, nome_disciplina) VALUES (2, 'Química');
INSERT INTO Disciplina (cod_area, nome_disciplina) VALUES (2, 'Física');
INSERT INTO Disciplina (cod_area, nome_disciplina) VALUES (2, 'Biologia');

INSERT INTO Disciplina (cod_area, nome_disciplina) VALUES (3, 'Língua Portuguesa');
INSERT INTO Disciplina (cod_area, nome_disciplina) VALUES (3, 'Literatura');
INSERT INTO Disciplina (cod_area, nome_disciplina) VALUES (3, 'Língua Estrangeira (Inglês ou Espanhol)');
INSERT INTO Disciplina (cod_area, nome_disciplina) VALUES (3, 'Artes');
INSERT INTO Disciplina (cod_area, nome_disciplina) VALUES (3, 'Educação Física e Tecnologias da Informação e Comunicação');

INSERT INTO Disciplina (cod_area, nome_disciplina) VALUES (4, 'Matemática');

SELECT * FROM Disciplina WHERE cod_area = (SELECT cod_area FROM Area_Conhecimento WHERE nome_area = 'Ciências Humanas e suas Tecnologias');
-- ---------------------------------------------------------------------------------------------------
-- Preenchendo dos Conteúdos                                                                       --
-- ---------------------------------------------------------------------------------------------------
-- UPDATE sqlite_sequence SET seq = 0 WHERE name = 'Conteudo';
-- História
INSERT INTO Conteudo (nome_conteudo, descricao_conteudo) VALUES ('Monarquia no Brasil - I',  'Com exercícios para você estudar e revisar os seus conhecimentos de datas e acontecimentos do período monárquico no Brasil.');
INSERT INTO Conteudo (nome_conteudo, descricao_conteudo) VALUES ('História do Brasil - IV',  'Com exercícios para você estudar e revisar os seus conhecimentos com perguntas desde o Brasil pré-colonial até a fundação da república.');

-- Geografia
INSERT INTO Conteudo (nome_conteudo, descricao_conteudo) VALUES ('Geografia Mundial - IX',  'Com exercícios para você estudar e revisar os seus conhecimentos sobre história da filosofia e filosofia básica, desde os primórdios da filosofia até a atualidade.');
INSERT INTO Conteudo (nome_conteudo, descricao_conteudo) VALUES ('Planeta Terra - I',  'Com exercícios para você estudar e revisar os seus conhecimentos sobre o que é biosfera, atmosfera, hidrosfera e litosfera? Conhece os movimentos de rotação e translação?.');

-- Filosofia
INSERT INTO Conteudo (nome_conteudo, descricao_conteudo) VALUES ('História da Filosofia - I',  'Com exercícios para você estudar e revisar os seus conhecimentos sobre e história da filosofia e filosofia básica, desde os primórdios da filosofia até a atualidade.');
INSERT INTO Conteudo (nome_conteudo, descricao_conteudo) VALUES ('Filosofia - I',  'Com exercícios para você estudar e revisar os seus conhecimentos sobre os filósofos, as obras, as teorias e outros assuntos sobre filosofia.');

-- Sociologia
INSERT INTO Conteudo (nome_conteudo, descricao_conteudo) VALUES ('Sociologia - I',  'Com exercícios para você estudar e revisar os seus conhecimentos sobre a sociologia, a cidadania e sobre os sociólogos.');
INSERT INTO Conteudo (nome_conteudo, descricao_conteudo) VALUES ('Sociologia - II',  'Com exercícios para você estudar e revisar os seus conhecimentos sobre Sociologia, um das matérias que está cada vez mais presente nos grandes vestibulares.');

-- Química
INSERT INTO Conteudo (nome_conteudo, descricao_conteudo) VALUES ('Tabela Periódica - VI',  'Com exercícios para você estudar e revisar os seus conhecimentos sobre tabela periódica e os seus elementos.');
INSERT INTO Conteudo (nome_conteudo, descricao_conteudo) VALUES ('Átomos - III',  'Com exercícios para você estudar e revisar os seus conhecimentos sobre S átomos para aqueles que estão estudando para o ENEM.');

-- Física
INSERT INTO Conteudo (nome_conteudo, descricao_conteudo) VALUES ('Termometria e Calorimetria',  'Com exercícios para você estudar e revisar os seus conhecimentos básicos de escalas termométricas e calorimetria.');
INSERT INTO Conteudo (nome_conteudo, descricao_conteudo) VALUES ('Física Básica - II',  'Com exercícios para você estudar e revisar os seus conhecimentos básicos de introdução à óptica e à termologia.');

-- Biologia
INSERT INTO Conteudo (nome_conteudo, descricao_conteudo) VALUES ('Reino Fungi - II',  'Com exercícios para você estudar e revisar os seus conhecimentos sobre o Reino Fungi.');
INSERT INTO Conteudo (nome_conteudo, descricao_conteudo) VALUES ('Biomedicina - III',  'Com exercícios para você estudar e revisar os seus conhecimentos sobre o corpo humano, seu funcionamento e suas doenças.');

-- Português
INSERT INTO Conteudo (nome_conteudo, descricao_conteudo) VALUES ('Português - VII',  'Com exercícios para você estudar e revisar os seus conhecimentos sobre sobre hiato, sujeito, crase, palavras oxítonas, paroxítonas e proparoxítonas, sinônimos, antônimos e parônimos..');
INSERT INTO Conteudo (nome_conteudo, descricao_conteudo) VALUES ('Vocabulário - III',  'Com exercícios para você estudar e revisar os seus conhecimentos sobre o significado de palavras como "analgia", "quilombo" e outros.');

-- Literatura
INSERT INTO Conteudo (nome_conteudo, descricao_conteudo) VALUES ('Pré-Modernismo - I',  'Com exercícios para você estudar e revisar os seus conhecimentos sobre o pré modernismo na literatura brasileira.');
INSERT INTO Conteudo (nome_conteudo, descricao_conteudo) VALUES ('Escolas Literárias - I',  'Com exercícios para você estudar e revisar os seus conhecimentos sobre os autores e as características de escola literárias como Parnasianismo, Romantismo e Trovadorismo.');

-- Inglês
INSERT INTO Conteudo (nome_conteudo, descricao_conteudo) VALUES ('Falsos Cognatos',  'Com exercícios para você estudar e revisar os seus conhecimentos sobre quais são alguns dos falsos cognatos em inglês (false friends).');
INSERT INTO Conteudo (nome_conteudo, descricao_conteudo) VALUES ('Avalie seu Inglês',  'Com exercícios para você estudar e revisar os seus conhecimentos sobre língua inglesa.');

-- Arte
INSERT INTO Conteudo (nome_conteudo, descricao_conteudo) VALUES ('Pablo Picasso - II',  'Com exercícios para você estudar e revisar os seus conhecimentos sobre um dos mais famosos artistas de todos os tempo: Pablo Picasso.');
INSERT INTO Conteudo (nome_conteudo, descricao_conteudo) VALUES ('Romeu e Julieta - II',  'Com exercícios para você estudar e revisar os seus conhecimentos sobreo clássico Romeu e Julieta.');

-- Educação Física e Comunicação
INSERT INTO Conteudo (nome_conteudo, descricao_conteudo) VALUES ('Os Vingadores 2: A Era de Ultron',  'Com exercícios para você estudar e revisar os seus conhecimentos sobre sobre o filme "Os Vingadores 2: A Era de Ultron".');
INSERT INTO Conteudo (nome_conteudo, descricao_conteudo) VALUES ('Batman vs Superman: A Origem da Justiça',  'Com exercícios para você estudar e revisar os seus conhecimentos sobre Batman vs Superman: A Origem da Justiça.');

-- Matemática
INSERT INTO Conteudo (nome_conteudo, descricao_conteudo) VALUES ('Matemática Básica - IX',  'Com exercícios para você estudar e revisar os seus conhecimentos sobre sobre conteúdo do 6° ano (potenciação, expressões e problemas matemáticos).');
INSERT INTO Conteudo (nome_conteudo, descricao_conteudo) VALUES ('Matemática Básica - VII',  'Com exercícios para você estudar e revisar os seus conhecimentos sobre radiciação, potenciação, porcentagem, frações e outros mais.');

SELECT * FROM Conteudo;
-- ---------------------------------------------------------------------------------------------------
-- Preenchendo das Associações Disciplinas Conteúdos                                               --
-- ---------------------------------------------------------------------------------------------------
INSERT INTO Disciplina_Conteudo (serie, cod_conteudo, cod_disciplina) VALUES (1, 1, 1);
INSERT INTO Disciplina_Conteudo (serie, cod_conteudo, cod_disciplina) VALUES (1, 2, 1);

INSERT INTO Disciplina_Conteudo (serie, cod_conteudo, cod_disciplina) VALUES (1, 3, 2);
INSERT INTO Disciplina_Conteudo (serie, cod_conteudo, cod_disciplina) VALUES (2, 4, 2);

INSERT INTO Disciplina_Conteudo (serie, cod_conteudo, cod_disciplina) VALUES (1, 5, 3);
INSERT INTO Disciplina_Conteudo (serie, cod_conteudo, cod_disciplina) VALUES (3, 6, 3);

INSERT INTO Disciplina_Conteudo (serie, cod_conteudo, cod_disciplina) VALUES (1, 7, 4);
INSERT INTO Disciplina_Conteudo (serie, cod_conteudo, cod_disciplina) VALUES (2, 8, 4);

INSERT INTO Disciplina_Conteudo (serie, cod_conteudo, cod_disciplina) VALUES (2, 9, 5);
INSERT INTO Disciplina_Conteudo (serie, cod_conteudo, cod_disciplina) VALUES (2, 10, 5);

INSERT INTO Disciplina_Conteudo (serie, cod_conteudo, cod_disciplina) VALUES (1, 11, 6);
INSERT INTO Disciplina_Conteudo (serie, cod_conteudo, cod_disciplina) VALUES (2, 12, 6);

INSERT INTO Disciplina_Conteudo (serie, cod_conteudo, cod_disciplina) VALUES (1, 13, 7);
INSERT INTO Disciplina_Conteudo (serie, cod_conteudo, cod_disciplina) VALUES (2, 14, 7);

INSERT INTO Disciplina_Conteudo (serie, cod_conteudo, cod_disciplina) VALUES (1, 15, 8);
INSERT INTO Disciplina_Conteudo (serie, cod_conteudo, cod_disciplina) VALUES (1, 16, 8);

INSERT INTO Disciplina_Conteudo (serie, cod_conteudo, cod_disciplina) VALUES (2, 17, 9);
INSERT INTO Disciplina_Conteudo (serie, cod_conteudo, cod_disciplina) VALUES (2, 18, 9);

INSERT INTO Disciplina_Conteudo (serie, cod_conteudo, cod_disciplina) VALUES (3, 19, 10);
INSERT INTO Disciplina_Conteudo (serie, cod_conteudo, cod_disciplina) VALUES (3, 20, 10);

INSERT INTO Disciplina_Conteudo (serie, cod_conteudo, cod_disciplina) VALUES (3, 21, 11);
INSERT INTO Disciplina_Conteudo (serie, cod_conteudo, cod_disciplina) VALUES (3, 22, 11);

INSERT INTO Disciplina_Conteudo (serie, cod_conteudo, cod_disciplina) VALUES (1, 23, 12);
INSERT INTO Disciplina_Conteudo (serie, cod_conteudo, cod_disciplina) VALUES (1, 24, 12);

INSERT INTO Disciplina_Conteudo (serie, cod_conteudo, cod_disciplina) VALUES (1, 25, 13);
INSERT INTO Disciplina_Conteudo (serie, cod_conteudo, cod_disciplina) VALUES (1, 26, 13);

SELECT * FROM Disciplina_Conteudo;

SELECT nome_conteudo 
FROM   Conteudo c, 
       Disciplina_Conteudo dc 
WHERE  dc.cod_disciplina = (SELECT cod_disciplina 
                            FROM   Disciplina 
                            WHERE  nome_disciplina = 'História') 
       AND c.cod_conteudo = dc.cod_conteudo;
       
-- ---------------------------------------------------------------------------------------------------
-- Preenchendo as Questões                                                                         --
-- ---------------------------------------------------------------------------------------------------
-- LOAD DATA local INFILE 'D:\\z2016.csv' INTO TABLE Questoes fields terminated by ';';

INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (1,"Qual foi o ano que iniciou a monarquia no Brasil?","Fácil","https://rachacuca.com.br/quiz/solve/182343/monarquia-no-brasil-i/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (2,"Quando ocorreu o golpe da maioridade?","Fácil","https://rachacuca.com.br/quiz/solve/182343/monarquia-no-brasil-i/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (3,"Quando institui-se o regime da Regência?","Médio","https://rachacuca.com.br/quiz/182343/monarquia-no-brasil-i/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (4,"Quando ocorreu a independência do Brasil?","Fácil","https://rachacuca.com.br/quiz/182343/monarquia-no-brasil-i/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (5,"Quanto tempo durou a monarquia no Brasil?","Difícil","https://rachacuca.com.br/quiz/182343/monarquia-no-brasil-i/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (6,"Quando ocorreu um movimento militar que resultou na proclamação da República?","Médio","https://rachacuca.com.br/quiz/182343/monarquia-no-brasil-i/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (7,"Como é a forma de governo adotada até hoje no Brasil?","Médio","https://rachacuca.com.br/quiz/182343/monarquia-no-brasil-i/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (8,"Qual foi o ano em que Dom Pedro II foi coroado imperador?","Fácil","https://rachacuca.com.br/quiz/182343/monarquia-no-brasil-i/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (9,"Qual era o nome da filha de Dom Pedro II?","Fácil","https://rachacuca.com.br/quiz/182343/monarquia-no-brasil-i/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (10,"Quando foi assinado a Lei Áurea, que aboliu a escravidão no país?","Médio","https://rachacuca.com.br/quiz/182343/monarquia-no-brasil-i/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (11,"Por quem foi chefiada a primeira expedição exploradora ?","Médio","https://rachacuca.com.br/quiz/solve/179322/historia-do-brasil-iv/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (12,"Qual foi a primeira vila fundada no Brasil colônia ?","Médio","https://rachacuca.com.br/quiz/179322/historia-do-brasil-iv/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (13,"Qual atividade atendia as necessidades do mercado interno?","Médio","Referência Vazia.");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (14,"Qual foi a primeira revolta ocorrida no Brasil ?","Fácil","https://rachacuca.com.br/quiz/solve/179322/historia-do-brasil-iv/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (15,"Qual foi o dia do fico?","Fácil","https://rachacuca.com.br/quiz/179322/historia-do-brasil-iv/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (16,"O tratado de 1810 entre Portugal e Inglaterra gerou:","Médio","https://rachacuca.com.br/quiz/179322/historia-do-brasil-iv/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (17,"Qual foi o presidente da república conhecido como Marechal de Ferro e Consolidador da República?","Médio","https://rachacuca.com.br/quiz/179322/historia-do-brasil-iv/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (18,"Quais são os únicos países da América do Sul que não fazem fronteira com o Brasil?","Fácil","https://rachacuca.com.br/quiz/178363/geografia-mundial-ix/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (19,"Qual o menor país do mundo?","Fácil","https://rachacuca.com.br/quiz/178363/geografia-mundial-ix/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (20,"Dos países abaixo, qual não pertence a Escandinávia?","Médio","https://rachacuca.com.br/quiz/178363/geografia-mundial-ix/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (21,"Qual a capital da Austrália?","Fácil","https://rachacuca.com.br/quiz/178363/geografia-mundial-ix/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (22,"No Brasil, passam duas linhas imaginárias. São elas:","Fácil","https://rachacuca.com.br/quiz/178363/geografia-mundial-ix/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (23,"São países comunistas:","Fácil","https://rachacuca.com.br/quiz/178363/geografia-mundial-ix/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (24,"Onde fica a nascente do Rio São Francisco?","Médio","https://rachacuca.com.br/quiz/178363/geografia-mundial-ix/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (25,"Roma, Amsterdã e Viena são, respectivamente, as capitais de quais países europeus?","Fácil","https://rachacuca.com.br/quiz/178363/geografia-mundial-ix/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (26,"Quantos movimentos o planeta Terra executa?","Médio","https://rachacuca.com.br/quiz/169421/planeta-terra-i/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (27,"Qual é a principal consequência do movimento de rotação?","Fácil","https://rachacuca.com.br/quiz/169421/planeta-terra-i/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (28,"Qual a principal consequência do movimento de translação","Fácil","https://rachacuca.com.br/quiz/169421/planeta-terra-i/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (29,"Qual a forma real da Terra?","Fácil","https://rachacuca.com.br/quiz/169421/planeta-terra-i/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (30,"Quanto tempo a Terra demora para executar o movimento de rotação?","Fácil","https://rachacuca.com.br/quiz/169421/planeta-terra-i/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (31,"Quanto tempo a Terra demora para executar o movimento de translação?","Fácil","https://rachacuca.com.br/quiz/169421/planeta-terra-i/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (32,"O que é litosfera?","Fácil","https://rachacuca.com.br/quiz/169421/planeta-terra-i/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (33,"O que é hidrosfera?","Fácil","https://rachacuca.com.br/quiz/169421/planeta-terra-i/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (34,"O que é atmosfera?","Fácil","https://rachacuca.com.br/quiz/169421/planeta-terra-i/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (35,"O que é biosfera?","Fácil","https://rachacuca.com.br/quiz/169421/planeta-terra-i/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (36,"Qual país é considerado o berço da filosofia ocidental?","Fácil","https://rachacuca.com.br/quiz/43050/historia-da-filosofia-i/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (37,"É considerado o primeiro filósofo ocidental:","Fácil","https://rachacuca.com.br/quiz/43050/historia-da-filosofia-i/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (38,"É o autor da célebre frase Só sei que nada sei:","Fácil","https://rachacuca.com.br/quiz/43050/historia-da-filosofia-i/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (39,"São considerados filósofos pré-socráticos:","Médio","https://rachacuca.com.br/quiz/43050/historia-da-filosofia-i/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (40,"São considerados os mais importantes filósofos gregos do período helênico:","Médio","https://rachacuca.com.br/quiz/43050/historia-da-filosofia-i/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (41,"É considerado o pai do método científico:","Médio","https://rachacuca.com.br/quiz/43050/historia-da-filosofia-i/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (42,"Qual dos filósofos é considerado como primeiro a vislumbrar o problema da historicidade?","Fácil","https://rachacuca.com.br/quiz/43050/historia-da-filosofia-i/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (43,"Deus está morto é a célebre frase do filósofo alemão:","Médio","https://rachacuca.com.br/quiz/43050/historia-da-filosofia-i/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (44,"É considerado o filósofo precursor da corrente filosófica conhecida como existencialismo:","Médio","https://rachacuca.com.br/quiz/43050/historia-da-filosofia-i/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (45,"É considerado o pai da psicanálise, teoria que postula que as motivações humanas possuem sua origem num aspecto da mente chamado de inconsciente, intimamente relacionado com experiências da infância:","Médio","https://rachacuca.com.br/quiz/43050/historia-da-filosofia-i/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (46,"Filósofo alemão que tratou sobre diversos assuntos, epistemologia, lógica, razão, moral, metafísica, ciência, cuja obra mais conhecida analisa os limites da própria razão:","Médio","https://rachacuca.com.br/quiz/43050/historia-da-filosofia-i/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (47,"Polêmico e controverso filósofo alemão que é considerado um dos mais críticos da razão ocidental, moral, ciência e cristianismo:","Fácil","https://rachacuca.com.br/quiz/43050/historia-da-filosofia-i/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (48,"Considerado os mais importantes críticos e percursores dos estudos sobre o fenômeno do capitalismo ocidental:","Médio","https://rachacuca.com.br/quiz/43050/historia-da-filosofia-i/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (49,"O filósofo da ciência cuja obra revolucionou os estudos sobre a a filosofia da ciência, com a introdução de um novo conceito chamado de paradigma científico:","Médio","https://rachacuca.com.br/quiz/43050/historia-da-filosofia-i/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (50,"São considerados os mais importantes expoentes do existencialismo do século XX:","Fácil","https://rachacuca.com.br/quiz/43050/historia-da-filosofia-i/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (51,"O que significa a palavra filosofia?","Fácil","https://rachacuca.com.br/quiz/54946/filosofia-i/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (52,"Qual o filósofo grego escreveu o livro A república?","Fácil","https://rachacuca.com.br/quiz/54946/filosofia-i/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (53,"Qual filósofo foi professor de Alexandre, o Grande?","Fácil","https://rachacuca.com.br/quiz/54946/filosofia-i/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (54,"Qual filósofo escreveu a obra Confissões?","Fácil","https://rachacuca.com.br/quiz/54946/filosofia-i/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (55,"Qual filósofo da Modernidade defendeu a tese do cogito ergo sum (penso, logo existo)?","Fácil","https://rachacuca.com.br/quiz/54946/filosofia-i/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (56,"Qual dos filósofos abaixo não pertence ao contratualismo moderno?","Médio","https://rachacuca.com.br/quiz/54946/filosofia-i/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (57,"Em que ano o filósofo Immanuel Kant publicou sua obra À paz perpétua?","Fácil","https://rachacuca.com.br/quiz/54946/filosofia-i/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (58,"Qual destes filósofos teorizou o direito cosmopolita?","Médio","https://rachacuca.com.br/quiz/54946/filosofia-i/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (59,"Qual destes filósofos é conhecido como um dos expoentes da Ética do Discurso?","Médio","https://rachacuca.com.br/quiz/54946/filosofia-i/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (60,"Qual filósofo abaixo é autor das obras Uma teoria da justiça e O direito dos povos","Médio","https://rachacuca.com.br/quiz/54946/filosofia-i/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (61,"Quem criou o termo Sociologia?","Fácil","https://rachacuca.com.br/quiz/44037/sociologia-i/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (62,"O que é Sociologia?","Fácil","https://rachacuca.com.br/quiz/44037/sociologia-i/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (63,"Sobre Emile Durkheim, marque a afirmativa falsa","Médio","https://rachacuca.com.br/quiz/solve/44037/sociologia-i/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (64,"O que Comte defendia sobre a Sociologia?","Médio","https://rachacuca.com.br/quiz/solve/44037/sociologia-i/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (65,"Como surgiu a idéia de Cidadania, presente na Sociologia ?","Médio","https://rachacuca.com.br/quiz/solve/44037/sociologia-i/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (66,"Qual desses conceitos da obra e da teoria socióloga é do sociológo Max Weber?","Fácil","https://rachacuca.com.br/quiz/solve/44037/sociologia-i/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (67,"O que é Ação racional, presente nas teses de Max Weber?","Fácil","https://rachacuca.com.br/quiz/solve/44037/sociologia-i/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (68,"A Sociologia pode ser orientada como uma Ciência da Ordem. O que significa esse termo?","Fácil","https://rachacuca.com.br/quiz/solve/44037/sociologia-i/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (69,"Marque a afirmativa verdadeira sobre o termo Sociologia da ciência:","Médio","https://rachacuca.com.br/quiz/solve/44037/sociologia-i/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (70,"A história da sociedade é a história da luta de classes, pois sempre haverá, em um determinado período histórico, classes com interesses antagônicos. Tais lutas são provocadas por fatores ao qual podemos nomear tese e antítese e, se a não for mais possível a manutenção do sistema, ocorre a síntese. O texto acima se aproxima mais do pensamento de qual sociólogo?","Médio","https://rachacuca.com.br/quiz/solve/83424/sociologia-ii/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (71,"Nesse tipo de solidariedade o fator que mantém a coerção social é, predominantemente, a consciência coletiva. Tal solidariedade é típica de sociedades pré-capitalistas. A qual solidariedade, em Durkheim, o texto se refere?","Médio","https://rachacuca.com.br/quiz/solve/83424/sociologia-ii/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (72,"A sociologia pode ser descrita como a ciência da crise. Por que tal afirmação é verdadeira?","Médio","https://rachacuca.com.br/quiz/solve/83424/sociologia-ii/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (73,"Para este autor a sociedade prevalece sobre o indivíduo, e a este somente resta encaixar-se nos padrões morais que são exteriores, coercitivos e gerais na sociedade. A qual autor o texto se refere?","Fácil","https://rachacuca.com.br/quiz/solve/83424/sociologia-ii/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (74,"Na sociedade capitalista moderna, o avanço tecnológico levou os modos de produção a uma abrupta mudança, nunca houve tantas máquinas trabalhando junto, ou melhor, no lugar do homem. Tal fato somente faz aumentar o lucro do capitalista. Com referência ao tipo de lucro citado no texto, pode-se dizer, segundo Marx, que se trata de uma caso de:","Médio","https://rachacuca.com.br/quiz/solve/83424/sociologia-ii/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (75,"Neste sistema econômico não há, teoricamente, desigualdade e o Estado possui os meios de produção, mas sua aplicação na prática não ocorreu como o esperado. O sistema citado e o seu estágio posterior são:","Médio","https://rachacuca.com.br/quiz/solve/83424/sociologia-ii/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (76,"Dentre os sociólogos abaixo, quais pertencem a escola de Frankfurt?","Difícil","https://rachacuca.com.br/quiz/solve/83424/sociologia-ii/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (77,"Após a crise de 1929 o Estado passou a intervir com maior vigor na economia para gerar empregos e melhorar a vida da população. A que política o texto se refere?","Fácil","https://rachacuca.com.br/quiz/solve/83424/sociologia-ii/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (78,"Segundo este autor o Estado não deve intervir na economia, pois a intervenção é feita por uma espécie de mão invisível. A qual autor o texto se refere?","Difícil","https://rachacuca.com.br/quiz/solve/83424/sociologia-ii/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (79,"Qual o número atômico do elemento químico Ósmio(Os)?","Médio","https://rachacuca.com.br/quiz/solve/180839/tabela-periodica-vi/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (80,"Qual o elemento químico é um metal e é solido à temperatura ambiente?","Fácil","https://rachacuca.com.br/quiz/solve/180839/tabela-periodica-vi/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (81,"Qual o simbolo do hássio?","Difícil","https://rachacuca.com.br/quiz/solve/180839/tabela-periodica-vi/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (82,"São metais halogênios:","Médio","https://rachacuca.com.br/quiz/solve/180839/tabela-periodica-vi/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (83,"Qual o número atômico do Alumínio?","Difícil","https://rachacuca.com.br/quiz/solve/180839/tabela-periodica-vi/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (84,"Os períodos e os grupos estão respectivamente organizados em:","Médio","https://rachacuca.com.br/quiz/solve/180839/tabela-periodica-vi/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (85,"O ouro faz parte de qual grupo?","Médio","https://rachacuca.com.br/quiz/solve/180839/tabela-periodica-vi/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (86,"Quem criou a tabela periódica que é usada até hoje?","Médio","https://rachacuca.com.br/quiz/solve/180369/atomos-iii/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (87,"Como é conhecido o modelo atômico de Thompson?","Médio","https://rachacuca.com.br/quiz/solve/180369/atomos-iii/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (88,"Em qual modelo atômico Niels Bohr se inspirou para criar o próprio modelo?E em que ano ele criou?","Médio","https://rachacuca.com.br/quiz/solve/180369/atomos-iii/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (89,"Que tipo de carga leva os elétrons?","Médio","https://rachacuca.com.br/quiz/solve/180369/atomos-iii/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (90,"Que tipo de carga levam os prótons?","Médio","https://rachacuca.com.br/quiz/solve/180369/atomos-iii/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (91,"O que compõem o núcleo de um átomo?","Médio","https://rachacuca.com.br/quiz/solve/180369/atomos-iii/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (92,"Quantos modelos atômicos foram inventados antes do de Rutherford?","Médio","https://rachacuca.com.br/quiz/solve/180369/atomos-iii/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (93,"Quem aperfeiçoou o modelo de Rutherford?","Fácil","https://rachacuca.com.br/quiz/solve/180369/atomos-iii/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (94,"Para esterilizar um termômetro clínico, devemos fervê-lo em água durante:","Médio","https://rachacuca.com.br/quiz/solve/177195/termometria-e-calometria/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (95,"Calor é:","Fácil","https://rachacuca.com.br/quiz/solve/177195/termometria-e-calometria/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (96,"O ponto de gelo é um estado térmico no qual:","Médio","https://rachacuca.com.br/quiz/solve/177195/termometria-e-calometria/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (97,"Um corpo de massa 50 gramas receber 300 calorias e sua temperatura sobe de 10° C até 30° C. Determine o calor específico da substâcia que constitui.","Médio","https://rachacuca.com.br/quiz/solve/177195/termometria-e-calometria/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (98,"Um bloco metálico de massa 400g é feito de um material cujo calor específico vale 0,2 cal/g°C e se encontra inicialmente a 20°C. Determine a quantidade de calor, em calorias, que o bloco deve receber para ter sua temperatura aumentada até 100°C.","Médio","https://rachacuca.com.br/quiz/solve/177195/termometria-e-calometria/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (99,"Transforme 0 Fahrenheit em Celsius.","Médio","https://rachacuca.com.br/quiz/solve/177195/termometria-e-calometria/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (100,"Transforme 37° Celsius em Fahrenheit.","Médio","https://rachacuca.com.br/quiz/solve/177195/termometria-e-calometria/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (101,"Transforme 650 Kelvin em Celsius.","Médio","https://rachacuca.com.br/quiz/solve/177195/termometria-e-calometria/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (102,"Transforme 2000° Fahrenheit em Kelvin.","Médio","https://rachacuca.com.br/quiz/177195/termometria-e-calometria/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (103,"Transforme -60° Celsius em Fahrenheit","Médio","https://rachacuca.com.br/quiz/177195/termometria-e-calometria/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (104,"Por quem foi introduzida, em 1798, a ideia de que o calor é energia?","Médio","https://rachacuca.com.br/quiz/solve/169077/fisica-basica-ii/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (105,"Quais as unidades de medidas utilizadas para medir calor?","Fácil","https://rachacuca.com.br/quiz/solve/169077/fisica-basica-ii/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (106,"Qual o nome do processo de transmissão de calor?","Fácil","https://rachacuca.com.br/quiz/solve/169077/fisica-basica-ii/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (107,"Como se chama a circulação continua que se da, quando a água recebe calor e a mais quente vai para cima e a mais fria para baixo ?","Difícil","https://rachacuca.com.br/quiz/solve/169077/fisica-basica-ii/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (108,"Um amolador de facas, ao operar um esmeril, é atingido por fagulhas incandescentes, mas não se queima. Isso acontece porque as fagulhas:","Médio","https://rachacuca.com.br/quiz/solve/169077/fisica-basica-ii/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (109,"Quais das transformações são referentes a um gás ideal que recebe calor e fornece trabalho?","Difícil","https://rachacuca.com.br/quiz/solve/169077/fisica-basica-ii/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (110,"Sobre a transformação de um gás perfeito, em que o estado final e inicial acusa a mesma energia, podemos afirmar que:","Fácil","https://rachacuca.com.br/quiz/solve/169077/fisica-basica-ii/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (111,"Uma massa gasosa ideal realiza uma expansão isotérmica. Nesse processo pode-se afirmar que:","Fácil","https://rachacuca.com.br/quiz/solve/169077/fisica-basica-ii/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (112,"Dois corpos sólidos receberam a mesma quantidade de calor e sofreram o mesmo aumento de temperatura. Podemos concluir que os corpos têm mesma(o):","Médio","https://rachacuca.com.br/quiz/solve/169077/fisica-basica-ii/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (113,"Calor é uma:","Médio","https://rachacuca.com.br/quiz/solve/169077/fisica-basica-ii/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (114,"Quando se tem variação de temperatura sem que haja variação do estado físico da matéria, o calor é:","Fácil","https://rachacuca.com.br/quiz/solve/169077/fisica-basica-ii/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (115,"Qual o nome se da à quantidade de calor que produz no corpo uma variação unitária de temperatura?","Fácil","https://rachacuca.com.br/quiz/solve/169077/fisica-basica-ii/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (116,"Onde costumam crescer os mofos e bolores?","Médio","https://rachacuca.com.br/quiz/181844/reino-fungi-ii/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (117,"O que são micoses?","Médio","https://rachacuca.com.br/quiz/solve/181844/reino-fungi-ii/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (118,"O que é Micologia?","Fácil","https://rachacuca.com.br/quiz/solve/181844/reino-fungi-ii/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (119,"Qual é o habitat (ambiente) dos fungos?","Médio","https://rachacuca.com.br/quiz/solve/181844/reino-fungi-ii/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (120,"De que é formado o micélio?","Fácil","Referência Vazia.");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (121,"Qual a principal substância que forma a parede celular dos fungos?","Fácil","https://rachacuca.com.br/quiz/solve/181844/reino-fungi-ii/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (122,"Qual é o agente que espalha os esporos no ambiente?","Médio","https://rachacuca.com.br/quiz/solve/181844/reino-fungi-ii/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (123,"Como são chamados os fungos decompositores?","Médio","https://rachacuca.com.br/quiz/solve/181844/reino-fungi-ii/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (124,"Quais são os seres que formam os líquens?","Fácil","https://rachacuca.com.br/quiz/solve/181844/reino-fungi-ii/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (125,"As leveduras são seres:","Médio","https://rachacuca.com.br/quiz/solve/181844/reino-fungi-ii/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (126,"O que forma um conjunto de células?","Fácil","https://rachacuca.com.br/quiz/solve/206648/biomedicina-iii/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (127,"Células nervosas responsáveis por captar odor são chamadas de :","Fácil","https://rachacuca.com.br/quiz/solve/206648/biomedicina-iii/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (128,"A coloração dos olhos se dá por qual estrutura ocular?","Fácil","https://rachacuca.com.br/quiz/solve/206648/biomedicina-iii/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (129,"Qual o nome da membrana que reveste os pulmões?","Difícil","https://rachacuca.com.br/quiz/solve/206648/biomedicina-iii/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (130,"Qual o nome da artéria que sai do ventrículo esquerdo?","Médio","https://rachacuca.com.br/quiz/solve/206648/biomedicina-iii/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (131,"Não é um orgão linfóide.","Difícil","Referência Vazia.");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (132,"Não pertence ao sistema digestório.","Médio","https://rachacuca.com.br/quiz/solve/206648/biomedicina-iii/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (133,"É produzido pela tireóide.","Médio","https://rachacuca.com.br/quiz/solve/206648/biomedicina-iii/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (134,"Verminose causada pela entrada de carcárias na pele.","Difícil","https://rachacuca.com.br/quiz/solve/206648/biomedicina-iii/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (135,"Quais das seguintes alternativas apresenta o sinônimo da palavra bonito?","Fácil","https://rachacuca.com.br/quiz/solve/181604/teste-de-portugues-vii/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (136,"Quais das seguintes alternativas apresenta o antônimo da palavra Agitado?","Fácil","https://rachacuca.com.br/quiz/solve/181604/teste-de-portugues-vii/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (137,"Quais das seguintes palavras são parônimos?","Fácil","https://rachacuca.com.br/quiz/solve/181604/teste-de-portugues-vii/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (138,"Qual o sujeito das orações a seguir: Todos os guerreiros, quando a eles dispõe a sina, conseguirão, mesmo que às vezes aos mais fracos não seja dado um bom sabre, vencer as guerras.","Difícil","https://rachacuca.com.br/quiz/solve/181604/teste-de-portugues-vii/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (139,"Em qual das frases abaixo a crase está INCORRETA?","Difícil","https://rachacuca.com.br/quiz/solve/181604/teste-de-portugues-vii/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (140,"Em qual das frases abaixo o uso da crase está CORRETO?","Fácil","https://rachacuca.com.br/quiz/solve/181604/teste-de-portugues-vii/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (141,"Quais das seguintes palavras é Oxítona?","Fácil","https://rachacuca.com.br/quiz/solve/181604/teste-de-portugues-vii/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (142,"Qual das seguintes palavras é proparoxítona?","Fácil","https://rachacuca.com.br/quiz/solve/181604/teste-de-portugues-vii/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (143,"Qual das seguintes palavras é paroxítonas?","Médio","https://rachacuca.com.br/quiz/solve/181604/teste-de-portugues-vii/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (144,"Em qual das palavras abaixo há um Hiato?","Fácil","https://rachacuca.com.br/quiz/solve/181604/teste-de-portugues-vii/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (145,"Que palavra descreve melhor o vocábulo CARPA?","Fácil","https://rachacuca.com.br/quiz/solve/180680/teste-de-vocabulario-iii/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (146,"Uma das respostas abaixo NÃO está correta?","Médio","https://rachacuca.com.br/quiz/solve/180680/teste-de-vocabulario-iii/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (147,"A palavra Quilombo significa:","Médio","https://rachacuca.com.br/quiz/solve/180680/teste-de-vocabulario-iii/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (148,"Indique o conjunto de palavras, onde há UMA que não é SINÔNIMO das outras do mesmo grupo","Difícil","https://rachacuca.com.br/quiz/solve/180680/teste-de-vocabulario-iii/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (149,"O Vocábulo OFTALGIA significa:","Fácil","https://rachacuca.com.br/quiz/solve/180680/teste-de-vocabulario-iii/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (150,"A palavra MIALGIA significa:","Médio","https://rachacuca.com.br/quiz/solve/180680/teste-de-vocabulario-iii/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (151,"A palavra CIGARRISTA é o mesmo que:","Fácil","https://rachacuca.com.br/quiz/solve/180680/teste-de-vocabulario-iii/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (152,"A palavra ANALGIA é melhor descrita por qual das alternativas?","Fácil","https://rachacuca.com.br/quiz/solve/180680/teste-de-vocabulario-iii/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (153,"Uma das opções abaixo está em desacordo com as demais.","Médio","https://rachacuca.com.br/quiz/solve/180680/teste-de-vocabulario-iii/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (154,"A palavra ARTEMÍSIA significa:","Médio","https://rachacuca.com.br/quiz/solve/180680/teste-de-vocabulario-iii/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (155,"Indique a alternativa INCORRETA sobre o Pré-Modernismo.","Médio","https://rachacuca.com.br/quiz/solve/179023/pre-modernismo-i/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (156,"A escola Pré-Modernista tem como principal característica a(o) :","Difícil","https://rachacuca.com.br/quiz/solve/179023/pre-modernismo-i/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (157,"Sobre a síntese pré-modernista responda:","Médio","https://rachacuca.com.br/quiz/solve/179023/pre-modernismo-i/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (158,"Assinale a alternativa que expressa a linguagem utilizada pelo escritor pré-modernista Lima Barreto.","Fácil","https://rachacuca.com.br/quiz/solve/179023/pre-modernismo-i/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (159,"Qual das alternativas abaixo expressa uma característica que ocorre nas cantigas de escárnio do Trovadorismo?","Fácil","https://rachacuca.com.br/quiz/solve/165155/escolas-literarias-i/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (160,"Nas poesias Humanistas, as métricas mais recorrentes apresentavam:","Médio","https://rachacuca.com.br/quiz/solve/165155/escolas-literarias-i/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (161,"Qual das seguintes características não corresponde ao Teatro de Gil Vicente?","Fácil","https://rachacuca.com.br/quiz/solve/165155/escolas-literarias-i/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (162,"Sobre o Classicismo é correto afirmar que:","Fácil","https://rachacuca.com.br/quiz/solve/165155/escolas-literarias-i/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (163,"Qual das seguintes manifestações literárias expressou a visão e o interesse do homem mercantilista europeu em busca de terras e riquezas no Brasil?","Médio","https://rachacuca.com.br/quiz/solve/165155/escolas-literarias-i/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (164,"Sobre o cultismo, presente ao Barroco, é possível afirmar que é marcado por um:","Difícil","https://rachacuca.com.br/quiz/solve/165155/escolas-literarias-i/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (165,"O Arcadismo (Neoclássico) foi marcado por retratar a simplicidade da vida no campo e elementos da natureza. Sobre ele é incorreto afirmar que:","Médio","https://rachacuca.com.br/quiz/solve/165155/escolas-literarias-i/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (166,"Uma característica principal do Romantismo é:","Médio","https://rachacuca.com.br/quiz/solve/165155/escolas-literarias-i/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (167,"Relevando as três gerações do Romantismo é possível afirmar que:","Fácil","https://rachacuca.com.br/quiz/solve/165155/escolas-literarias-i/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (168,"Qual a tradução para o Português da palavra comprehensive?","Médio","https://rachacuca.com.br/quiz/solve/181460/falsos-cognatos-em-ingles-ii/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (169,"Qual a tradução para o Português da palavra push","Fácil","https://rachacuca.com.br/quiz/solve/181460/falsos-cognatos-em-ingles-ii/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (170,"Qual a tradução para o Português da palavra fabric?","Fácil","https://rachacuca.com.br/quiz/181460/falsos-cognatos-em-ingles-ii/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (171,"Qual a tradução para o Português da palavra assume?","Fácil","https://rachacuca.com.br/quiz/solve/181460/falsos-cognatos-em-ingles-ii/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (172,"Qual a tradução para o Português da palavra legend?","Fácil","https://rachacuca.com.br/quiz/solve/181460/falsos-cognatos-em-ingles-ii/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (173,"Qual a tradução para o Português da palavra support?","Fácil","https://rachacuca.com.br/quiz/solve/181460/falsos-cognatos-em-ingles-ii/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (174,"Qual a tradução para o Português da palavra college?","Fácil","https://rachacuca.com.br/quiz/solve/181460/falsos-cognatos-em-ingles-ii/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (175,"Qual a tradução para o Português da palavra parents?","Médio","https://rachacuca.com.br/quiz/solve/181460/falsos-cognatos-em-ingles-ii/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (176,"Qual a tradução para o Português da palavra intend?","Fácil","https://rachacuca.com.br/quiz/solve/181460/falsos-cognatos-em-ingles-ii/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (177,"Complete: I have a girlfriend. ___ is really beautiful.","Médio","https://rachacuca.com.br/quiz/solve/179421/avalie-seu-ingles-ii/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (178,"Na frase: Today is friday. Robert and Sarah went to the restaurant yesterday, pergunta-se: em que dia Robert e Sarah foram ao restaurante?","Médio","https://rachacuca.com.br/quiz/solve/179421/avalie-seu-ingles-ii/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (179,"Complete: Hi. My names Robert. ___ your name?","Difícil","https://rachacuca.com.br/quiz/solve/179421/avalie-seu-ingles-ii/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (180,"Qual pronome no plural é usado para referir-se a objetos que estão longe?","Difícil","https://rachacuca.com.br/quiz/solve/179421/avalie-seu-ingles-ii/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (181,"Quando Queremos saber a profissão de alguém,qual pergunta devemos fazer?","Fácil","https://rachacuca.com.br/quiz/solve/179421/avalie-seu-ingles-ii/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (182,"A hora certa para 9 horas e 30 minutos é:","Fácil","https://rachacuca.com.br/quiz/solve/179421/avalie-seu-ingles-ii/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (183,"Qual a preposição correta para a frase: The game will be ____ March.","Médio","https://rachacuca.com.br/quiz/solve/179421/avalie-seu-ingles-ii/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (184,"Nice to meet you significa o quê em inglês?","Difícil","https://rachacuca.com.br/quiz/solve/179421/avalie-seu-ingles-ii/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (185,"Complete a frase com a palavra em inglês mais adequada para a frase Nós não temos que ir ao shopping: We ____ have to go to the mall.","Médio","https://rachacuca.com.br/quiz/solve/179421/avalie-seu-ingles-ii/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (186,"Qual palavra abaixo não é um verbo?","Médio","https://rachacuca.com.br/quiz/solve/179421/avalie-seu-ingles-ii/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (187,"Se uma pessoa quiser perguntar quanto é isso?, o que ela deverá dizer?","Médio","https://rachacuca.com.br/quiz/solve/179421/avalie-seu-ingles-ii/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (188,"O bebê Pablo foi considerado natimorto. O que fizeram para que ele conseguisse sobreviver?","Médio","https://rachacuca.com.br/quiz/solve/180254/pablo-picasso-ii/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (189,"Quem eram os pais de Pablo Picasso?","Médio","https://rachacuca.com.br/quiz/solve/180254/pablo-picasso-ii/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (190,"Como seus pais escolheram seu nome?","Fácil","https://rachacuca.com.br/quiz/solve/180254/pablo-picasso-ii/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (191,"Como era o jovem Picasso?","Fácil","https://rachacuca.com.br/quiz/solve/180254/pablo-picasso-ii/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (192,"Qual dessas informações corresponde a Pablo Picasso?","Médio","https://rachacuca.com.br/quiz/solve/180254/pablo-picasso-ii/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (193,"Pablo Picasso se mudou para Paris, na tentativa de aprender cada vez mais. Na bagagem, levava um autorretrato. Qual era o nome de seu autorretrato?","Médio","https://rachacuca.com.br/quiz/solve/180254/pablo-picasso-ii/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (194,"Quais artistas inspiraram Picasso?","Médio","https://rachacuca.com.br/quiz/solve/180254/pablo-picasso-ii/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (195,"As mulheres foram uma fonte de conhecimento para ele na França. Como ele era fisicamente?","Médio","https://rachacuca.com.br/quiz/solve/180254/pablo-picasso-ii/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (196,"Como foi sua fase azul?","Fácil","https://rachacuca.com.br/quiz/solve/180254/pablo-picasso-ii/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (197,"Como se chamava a primeira mulher de Picasso?","Fácil","https://rachacuca.com.br/quiz/solve/180254/pablo-picasso-ii/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (198,"Como Picasso conheceu sua primeira mulher?","Fácil","https://rachacuca.com.br/quiz/solve/180254/pablo-picasso-ii/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (199,"Que pintor famoso se tornou um de seus melhores amigos?","Fácil","https://rachacuca.com.br/quiz/solve/180254/pablo-picasso-ii/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (200,"Em que período a história de Romeu e Julieta foi escrita?","Médio","https://rachacuca.com.br/quiz/solve/175333/romeu-e-julieta-ii/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (201,"Qual a nacionalidade de William Shakespeare?","Fácil","https://rachacuca.com.br/quiz/solve/175333/romeu-e-julieta-ii/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (202,"Qual o nome da cidade que se passa a história?","Fácil","https://rachacuca.com.br/quiz/solve/175333/romeu-e-julieta-ii/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (203,"Por que Romeu precisou ir para Mântua?","Fácil","https://rachacuca.com.br/quiz/solve/175333/romeu-e-julieta-ii/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (204,"Em qual lugar Romeu e Julieta se conheceram?","Médio","https://rachacuca.com.br/quiz/solve/175333/romeu-e-julieta-ii/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (205,"Por que Romeu foi a festa na casa de seu inimigo?","Fácil","https://rachacuca.com.br/quiz/175333/romeu-e-julieta-ii/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (206,"No Universo Cinematográfico da Marvel, onde se encontra a joia da mente?","Fácil","https://rachacuca.com.br/quiz/134043/os-vingadores-2-a-era-de-ultron-ii/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (207,"Qual o pesadelo acordado que a feiticeira escarlate faz Tony Stark ter?","Fácil","https://rachacuca.com.br/quiz/134043/os-vingadores-2-a-era-de-ultron-ii/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (208,"Quem ajuda a Feiticeira escarlate quando ela fica falando que é tudo culpa dela?","Fácil","https://rachacuca.com.br/quiz/134043/os-vingadores-2-a-era-de-ultron-ii/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (209,"Onde fica a nova Base dos Vingadores?","Fácil","https://rachacuca.com.br/quiz/solve/134043/os-vingadores-2-a-era-de-ultron-ii/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (210,"Na primeira cena do filme, um casal foi morto. Quem são eles?","Fácil","https://rachacuca.com.br/quiz/solve/150841/batman-vs-superman-a-origem-da-justica/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (211,"Quais são os motivos da briga de Batman e Superman?","Fácil","https://rachacuca.com.br/quiz/solve/150841/batman-vs-superman-a-origem-da-justica/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (212,"Dos sonhos que Bruce teve, aparece dois heróis do Universo Cinematográfico da DC Comics. Quem são eles?","Fácil","https://rachacuca.com.br/quiz/solve/150841/batman-vs-superman-a-origem-da-justica/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (213,"Pensei em um número e multipliquei-o por 3. Somei 15 ao resultado e obtive 51. Em que número pensei?","Fácil","https://rachacuca.com.br/quiz/solve/177108/matematica-basica-ix/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (214,"Quanto é 15²?","Médio","Referência Vazia.");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (215,"Calcule o valor da expressão numérica abaixo: 15+{25-[2-(8-6)]+2}.","Médio","https://rachacuca.com.br/quiz/177108/matematica-basica-ix/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (216,"Pensei em um número, dividi esse número por 15, do resultado subtraí 10 e obtive 40. Em que número pensei?","Médio","https://rachacuca.com.br/quiz/177108/matematica-basica-ix/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (217,"Quanto é 9³?","Difícil","https://rachacuca.com.br/quiz/177108/matematica-basica-ix/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (218,"Quanto é 13²?","Fácil","https://rachacuca.com.br/quiz/177108/matematica-basica-ix/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (219,"Calcule a expressão numérica: 40-[5²+(2³-6)].","Médio","https://rachacuca.com.br/quiz/177108/matematica-basica-ix/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (220,"Quanto é 5³?","Difícil","https://rachacuca.com.br/quiz/177108/matematica-basica-ix/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (221,"Quanto é 8³?","Difícil","https://rachacuca.com.br/quiz/177108/matematica-basica-ix/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (222,"Quanto é 10³?","Médio","https://rachacuca.com.br/quiz/177108/matematica-basica-ix/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (223,"Qual é a raiz quadrada de 225?","Médio","https://rachacuca.com.br/quiz/solve/168147/matematica-basica-vii/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (224,"Quanto é 60 ao quadrado?","Médio","https://rachacuca.com.br/quiz/solve/168147/matematica-basica-vii/");
INSERT INTO Questoes (cod,enunciado,dificuldade,referencia) VALUES (225,"Mariana tem 18 anos. Sua irmã mais velha Melissa tem o triplo de sua idade. Quantos anos tem melissa?","Fácil","https://rachacuca.com.br/quiz/solve/168147/matematica-basica-vii/");
SELECT * FROM Questoes;
-- ---------------------------------------------------------------------------------------------------
-- Preenchendo das Associações Conteúdos Questões                                                 --
-- ---------------------------------------------------------------------------------------------------
-- Conteúdo Questão
-- Monarquia no Brasil - I
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (1, 1);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (1, 2);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (1, 3);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (1, 4);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (1, 5);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (1, 6);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (1, 7);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (1, 8);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (1, 9);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (1, 10);

-- História do Brasil - IV
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (2, 11);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (2, 12);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (2, 13);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (2, 14);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (2, 15);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (2, 16);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (2, 17);

-- Geografia Mundial - IX
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (3, 18);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (3, 19);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (3, 20);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (3, 21);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (3, 22);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (3, 23);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (3, 24);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (3, 25);

-- Planeta Terra - I
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (4, 26);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (4, 27);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (4, 28);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (4, 29);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (4, 30);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (4, 31);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (4, 32);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (4, 33);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (4, 34);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (4, 35);

-- História da Filosofia - I
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (5, 36);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (5, 37);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (5, 38);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (5, 39);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (5, 40);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (5, 41);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (5, 42);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (5, 43);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (5, 44);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (5, 45);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (5, 46);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (5, 47);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (5, 48);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (5, 49);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (5, 50);

-- Filosofia - I
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (6, 51);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (6, 52);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (6, 53);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (6, 54);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (6, 55);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (6, 56);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (6, 57);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (6, 58);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (6, 59);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (6, 60);

-- Sociologia - I
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (7, 61);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (7, 62);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (7, 63);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (7, 64);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (7, 65);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (7, 66);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (7, 67);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (7, 68);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (7, 69);

-- Sociologia - II
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (8, 70);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (8, 71);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (8, 72);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (8, 73);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (8, 74);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (8, 75);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (8, 76);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (8, 77);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (8, 78);

-- Tabela Periódica - VI
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (9, 79);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (9, 80);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (9, 81);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (9, 82);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (9, 83);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (9, 84);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (9, 85);

-- Átomos - III
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (10, 86);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (10, 87);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (10, 88);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (10, 89);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (10, 90);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (10, 91);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (10, 92);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (10, 93);

-- Termometria e Calorimetria
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (11, 94);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (11, 95);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (11, 96);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (11, 97);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (11, 98);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (11, 99);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (11, 100);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (11, 101);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (11, 102);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (11, 103);

-- Física Básica - II
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (12, 104);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (12, 105);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (12, 106);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (12, 107);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (12, 108);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (12, 109);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (12, 110);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (12, 111);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (12, 112);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (12, 113);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (12, 114);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (12, 115);

-- Reino Fungi - II
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (13, 116);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (13, 117);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (13, 118);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (13, 119);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (13, 120);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (13, 121);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (13, 122);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (13, 123);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (13, 124);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (13, 125);

-- Biomedicina - III
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (14, 126);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (14, 127);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (14, 128);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (14, 129);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (14, 130);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (14, 131);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (14, 132);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (14, 133);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (14, 134);

-- Português - VII
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (15, 135);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (15, 136);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (15, 137);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (15, 138);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (15, 139);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (15, 140);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (15, 141);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (15, 142);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (15, 143);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (15, 144);

-- Vocabulário - III
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (16, 145);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (16, 146);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (16, 147);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (16, 148);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (16, 149);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (16, 150);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (16, 151);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (16, 152);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (16, 153);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (16, 154);

-- Pré-Modernismo - I
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (17, 155);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (17, 156);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (17, 157);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (17, 158);

-- Escolas Literárias - I
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (18, 159);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (18, 160);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (18, 161);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (18, 162);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (18, 163);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (18, 164);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (18, 165);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (18, 166);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (18, 167);

-- Falsos Cognatos
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (19, 168);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (19, 169);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (19, 170);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (19, 171);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (19, 172);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (19, 173);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (19, 174);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (19, 175);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (19, 176);

-- Avalie seu Inglês
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (20, 177);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (20, 178);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (20, 179);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (20, 180);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (20, 181);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (20, 182);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (20, 183);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (20, 184);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (20, 185);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (20, 186);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (20, 187);

-- Pablo Picasso - II
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (21, 188);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (21, 189);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (21, 190);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (21, 191);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (21, 192);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (21, 193);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (21, 194);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (21, 195);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (21, 196);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (21, 197);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (21, 198);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (21, 199);

-- Romeu e Julieta - II
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (22, 200);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (22, 201);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (22, 202);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (22, 203);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (22, 204);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (22, 205);

-- Os Vingadores 2: A Era de Ultron
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (23, 206);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (23, 207);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (23, 208);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (23, 209);

-- Batman vs Superman: A Origem da Justiça
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (24, 210);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (24, 211);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (24, 212);

-- Matemática Básica - IX
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (25, 213);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (25, 214);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (25, 215);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (25, 216);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (25, 217);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (25, 218);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (25, 219);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (25, 220);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (25, 221);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (25, 222);

-- Matemática Básica - VII
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (26, 223);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (26, 224);
INSERT INTO Conteudo_Questao (cod_conteudo, cod_questao) VALUES (26, 225);
-- ---------------------------------------------------------------------------------------------------
-- Preenchendo as Alternativas                                                                     --
-- ---------------------------------------------------------------------------------------------------

INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (1,1,1,"1800","Um pouco mais.");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (2,1,1,"1821","Quase, por 1 ano de diferença.");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (3,1,1,"1889","Um pouco mais;");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (4,1,0,"1822","o inicio da monarquia inicio-se no ano de 1822 com o o imperador dom Pedro Primeiro.");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (5,1,1,"1829","Um pouco menos que isso.");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (6,2,1,"1841","Um pouco mais");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (7,2,0,"1840","Foi declara a maioridade de Dom Pedro I (mesmo com 14 anos), no ano de 1840.");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (8,2,1,"1845","Meia década a menos");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (9,2,1,"1847","Bem menos que isso");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (10,2,1,"1850","Uma década anterior");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (11,3,1,"1822","Errado, em 1822 acontecia a Independência do Brasil.");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (12,3,1,"1860","1860, acontecia outros eventos, como Fundações: Estrada de Ferro da Bahia ao São Francisco, Canal do Mangue, A Estação Calçada  de Salvador.");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (13,3,0,"1831","Período regencial é como ficou conhecido o decênio de 1831 a 1840 na História do Brasil.");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (14,3,1,"1900","1900, o regime da Regência já tinha sido criado, 1900 acontecia: Fundações: Biblioteca Municipal Faris Michaeli, Estação de Oficinas, Associação Atlética Ponte Preta, Club Athletico Paulistano, Macatuba é um município brasileiro do estado de São Paulo. ");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (15,3,1,"1782","O regime da Regência foi muito depois, em 1782, acontecia: Fortificações na Ilha da Trindade, Construção do Presídio de Casalvasco.");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (16,4,1,"7 de novembro","Dia do Radialista ");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (17,4,1,"7 de agosto"," dia Internacional do Maratonista");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (18,4,1,"7 de outubro","7 de outubro é dia de Nossa Senhora do Santo Rosário");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (19,4,0,"7 de setembro","Dia da Independência do Brasil");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (20,4,1,"7 de maio","Dia do Silêncio");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (21,5,1,"97 anos","Chama-se Brasil Império o período da história do Brasil que se iniciou com a Independência, em 7 de setembro de 1822, e terminou com a proclamação da República, em 15 de novembro de 1889. Durou, portanto, pouco mais de 67 anos.");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (22,5,1,"57 anos","Chama-se Brasil Império o período da história do Brasil que se iniciou com a Independência, em 7 de setembro de 1822, e terminou com a proclamação da República, em 15 de novembro de 1889. Durou, portanto, pouco mais de 67 anos.");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (23,5,1,"77 anos","Chama-se Brasil Império o período da história do Brasil que se iniciou com a Independência, em 7 de setembro de 1822, e terminou com a proclamação da República, em 15 de novembro de 1889. Durou, portanto, pouco mais de 67 anos.");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (24,5,1,"87 anos","Chama-se Brasil Império o período da história do Brasil que se iniciou com a Independência, em 7 de setembro de 1822, e terminou com a proclamação da República, em 15 de novembro de 1889. Durou, portanto, pouco mais de 67 anos.");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (25,5,0,"67 anos","Chama-se Brasil Império o período da história do Brasil que se iniciou com a Independência, em 7 de setembro de 1822, e terminou com a proclamação da República, em 15 de novembro de 1889. Durou, portanto, pouco mais de 67 anos.");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (26,6,0,"1889","Proclamação da República (1889)");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (27,6,1,"1789","1789 acontecia a A Inconfidência Mineira (1789).");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (28,6,1,"1989","1989 acontecia Eleição presidencial no Brasil");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (29,6,1,"1689","1689 acontecia a Declaração de Direitos elaborado pelo Parlamento de Inglaterra.");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (30,6,1,"1589","Forte de São Cristóvão");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (31,7,1,"monarquia","Monarquia é um sistema de governo em que o monarca (rei) governa um país como chefe de Estado.");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (32,7,1,"parlamento","Parlamentarismo é um sistema de governo em que o poder legislativo (parlamento) oferece a sustentação política (apoio direito ou indireto) para o poder executivo.");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (33,7,0,"republica","O período da História do Brasil, que conhecemos como Brasil República ou Brasil Republicano, teve início com a Proclamação da República (1889) e vai até os dias atuais.");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (34,7,1,"monarquia parlamentarista","Uma monarquia constitucional ou monarquia parlamentarista, que se opõe à monarquia tradicional e à monarquia absolutista, é um sistema político em monarquia que reconhece um rei eleito ou hereditário como chefe do Estado, mas em que há uma constituição (série de leis fundamentais) que limita os poderes do mesmo monarca.");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (35,8,1,"18 de julho de 1840","Declaração da Maioridade");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (36,8,1,"18 de julho de 1851","DECRETO Nº 798");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (37,8,1,"18 de julho de 1800"," Dia Internacional de Nelson Mandela");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (38,8,0,"18 de julho de 1841","Coroação do Imperador Dom Pedro II");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (39,8,1,"18 de julho de 1831","LEI DE 17 DE JULHO DE 1831");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (40,9,1,"Marieta","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (41,9,1,"Francisca","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (42,9,0,"Isabel","Isabel Cristina Leopoldina Augusta Micaela Gabriela Rafaela Gonzaga de Bourbon-Duas Sicílias e Bragança, apelidada de ""a Redentora"", foi a segunda filha, a primeira menina, do imperador Pedro II do Brasil e sua esposa a imperatriz Teresa Cristina das Duas Sicílias.");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (43,9,1,"Maria","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (44,10,1,"1887","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (45,10,1,"1886","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (46,10,1,"1883","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (47,10,0,"1888","Lei Áurea - Princesa Isabel sancionou a lei que pôs fim à escravidão. Em 13 de maio de 1888, a princesa Isabel assinou a lei Áurea que aboliu a escravidão no Brasil.");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (48,10,1,"1873","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (49,11,0,"Gaspar Lemos","Gaspar de Lemos foi um navegador português do século XVI. Comandou um dos navios da frota de Pedro Álvares Cabral, que descobriu o Brasil em 22 de abril de 1500. nExpedição ocorrida em 1501, por mando do rei de Portugual.");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (50,11,1,"Mem de Sá","Mem de Sá foi um dos mais importantes governadores gerais durante o período colonial, de forma que administrou a colônia no período de quinze anos ");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (51,11,1,"Pedro Alvares Cabral","Pedro Álvares Cabral foi um fidalgo, comandante militar, navegador e explorador português, creditado como o descobridor do Brasil. Realizou a primeira exploração significativa da costa nordeste da América do Sul, reivindicando-a para Portugal.");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (52,11,1,"Tomé de Souza","Tomé de Souza, governo-geral, nascimento e morte de Tomé de Souza, História do Brasil Colonial.");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (53,12,1,"São José","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (54,12,1,"Vila de São Luiz","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (55,12,0,"São Vicente","Martim Afonso continuando sua política colonizadora, fundou, em 1532, a primeira vila do Brasil, São Vicente.");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (56,12,1,"Anhanguera","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (57,13,1,"Comércio","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (58,13,1,"Tráfico negreiro","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (59,13,1,"Cacau","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (60,13,0,"Pecuária","O Brasil colônia era exclusivamente explorado para dar lucro a metrópole, portanto era a pecuária que atendia as necessidade dos colonos");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (61,14,1,"Revolta dos Alfaiates","Conjuração Baiana, também denominada como Revolta dos Alfaiates e recentemente também chamada de Revolta dos Búzios, foi um movimento de caráter emancipacionista, ocorrido no final do século XVIII, na então Capitania da Bahia, na colônia brasileira");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (62,14,0,"Insurreição Pernambucana","Primeira movimento nativista, no qual a população expulsou os Holandeses");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (63,14,1,"Revolta de Vila Rica"," Revolta de Vila Rica, este movimento nativista ocorreu no ano de 1720, na região das Minas Gerais, durante o período do Ciclo do Ouro. ");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (64,14,1,"Guerra dos Emboabas","A Guerra dos Emboabas foi um confronto travado de 1707 a 1709 pelo direito de exploração das recém-descobertas jazidas de ouro na região do atual estado de Minas Gerais, no Brasil. ");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (65,15,1,"9 de abril 1822","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (66,15,1,"9 de setembro 1822","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (67,15,0,"9 de janeiro de 1822","Pedro I, significado da data. O Dia do Fico ocorreu em 9 de janeiro de 1822. Esta data ficou conhecida por este nome, pois D. Pedro I, então príncipe regente do Brasil, não acatou ordens das Cortes Portuguesas para que deixasse imediatamente o Brasil, retornando para Portugal.");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (68,15,1,"9 de dezembro 1822","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (69,16,0,"Abertura dos Portos para as nações amigas","O Tratado de Comércio e Navegação foi um acordo assinado entre Portugal e a Grã Bretanha em 19 de fevereiro de 1810, com a finalidade de ""conservar e estreitar"" as relações de aliança entre as duas monarquias.");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (70,16,1,"Abolição da escravatura o Brasil","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (71,16,1,"Fuga de Napoleão","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (72,16,1,"Fundação do Banco do Brasil","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (73,17,1,"Deodoro da Fonseca","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (74,17,0,"Floriano Peixoto","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (75,17,1,"Rodrigues Alves","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (76,17,1,"João Batista Figueiredo","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (77,18,1,"Chile e Bolívia","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (78,18,1,"Guiana e Bolívia","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (79,18,0,"Equador e Chile","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (80,18,1,"Guiana e Suriname","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (81,18,1,"Suriname e Equador","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (82,19,1,"Andorra","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (83,19,1,"Liechtenstein","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (84,19,1,"Turquemenistão","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (85,19,1,"Haiti","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (86,19,0,"Vaticano","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (87,20,1,"Suécia","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (88,20,1,"Finlândia","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (89,20,1,"Dinamarca","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (90,20,1,"Noruega","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (91,20,0,"Bélgica","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (92,21,0,"Camberra","Assim como acontece com Brasília, Canberra foi uma cidade planejada e foi escolhida para a localização da capital do país");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (93,21,1,"Sidney","Sydney é a capital do estado de Nova Gales do Sul");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (94,21,1,"Melbourne","Melbourne é a capital e a cidade mais populosa do estado de Vitória, além de ser a segunda área urbana mais populosa da Austrália, depois de Sydney. ");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (95,21,1,"Adelaide","Adelaide é a capital do estado da Austrália Meridional, na Austrália.");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (96,21,1,"Wellington","Wellington é a capital da Nova Zelândia e também da região de Wellington, localizada ao sul da North Island, da qual Wellington é a cidade principal.");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (97,22,1,"Equador e Câncer","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (98,22,0,"Equador e Capricórnio","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (99,22,1,"Capricórnio e Greenwich","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (100,22,1,"Greenwich e Equador","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (101,22,1,"Capricórnio e Câncer","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (102,23,0,"China e Cuba","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (103,23,1,"China e Japão","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (104,23,1,"Rússia e Egito","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (105,23,1,"Marrocos e Egito","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (106,23,1,"Cuba e Egito","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (107,24,1,"Bahia","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (108,24,1,"Sergipe","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (109,24,0,"Minas Gerais","Apesar de ser o principal rio do Nordeste, o Velho Chico nasce na Serra da Canastra, em Minas Gerais.");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (110,24,1,"Alagoas","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (111,24,1,"Pernambuco","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (112,25,1,"Itália, Bélgica e França","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (113,25,1,"Inglaterra, Holanda e França","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (114,25,1,"Itália, Noruega e Áustria","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (115,25,0,"Itália, Holanda e Áustria","Bruxelas, Paris, Londres, Oslo e Madrid são, respectivamente as capitais da Bélgica, França, Inglaterra, Noruega e Espanha, outros países citados.");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (116,25,1,"Espanha, Holanda e França","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (117,26,1,"11 movimentos","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (118,26,1,"12 movimentos","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (119,26,1,"13 movimentos","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (120,26,0,"14 movimentos","O planeta Terra executa 14 movimentos. Destes, dois são mais importantes: rotação e translação.");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (121,26,1,"15 movimentos","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (122,27,1,"A formação das 4 estações do ano","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (123,27,0,"A formação dos dias e das noites","A principal consequência do movimento de rotação é a formação dos dias e das noites, pois quando um lado do planeta Terra é dia, o outro lado é noite");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (124,27,1,"A formação das chuvas","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (125,27,1,"A formação dos fenômenos naturais","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (126,27,1,"Nenhuma das alternativas","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (127,28,0,"A formação das 4 estações do ano","A principal consequência do movimento de translação é a formação das 4 estações do ano, pois as estações do ano ocorrem por causa da inclinação da Terra em relação ao sol, e essa inclinação da Terra em relação ao sol é chamada de movimento de translação.");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (128,28,1,"A formação das chuvas","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (129,28,1,"A manutenção das temperaturas da Terra","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (130,28,1,"A formação do dia e da noite","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (131,28,1,"Nenhuma das alternativas","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (132,29,1,"redonda","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (133,29,0,"geoide","A Terra parece esférica, mais sua forma real é geoide porque a Terra é achatada nos polos.");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (134,29,1,"quadrada","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (135,29,1,"A Terra não tem forma","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (136,29,1,"Nenhuma das alternativas","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (137,30,1,"22 horas,43 minutos e 54 segundos","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (138,30,1,"23 horas,56 minutos e 40 segundos","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (139,30,0,"23 horas, 56 minutos e 4 segundos","A Terra demora 23 horas,56 segundos e 4 segundos para executar o movimento de rotação.");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (140,30,1,"24 horas,56 minutos e 4 segundos","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (141,30,1,"Nenhuma das alternativas","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (142,31,1,"24 horas,56 minutos e 4 minutos","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (143,31,1,"364 dias,5 horas e 45 segundos","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (144,31,1,"5 horas,48 minutos e 46 minutos","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (145,31,0,"365 dias,5 horas, 48 minutos e 46 segundos","A Terra demora 365 dias, 5 horas, 48 minutos e 46 segundos para executar o movimento de translação.");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (146,31,1,"365 dias, 1 hora e 46 segundos","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (147,32,0,"É o solo onde pisamos","Litosfera é o solo onde pisamos.");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (148,32,1,"É o conjunto de água de todo o planeta","Hidrosfera é o conjunto de água de todo o planeta.");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (149,32,1,"É a camada mais extensa da atmosfera","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (150,32,1,"É o conjunto de sistemas vivos do planeta","Biosfera é o conjunto de sistemas vivos do planeta.");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (151,32,1,"Nenhuma das alternativas","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (152,33,1,"É o solo onde pisamos","Litosfera é o solo onde pisamos.");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (153,33,0,"É o conjunto de água de todo o planeta","Hidrosfera é o conjunto de água de todo o planeta.");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (154,33,1,"É a camada mais extensa da atmosfera","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (155,33,1,"É o conjunto de sistemas vivos do planeta","Biosfera é o conjunto de sistemas vivos do planeta.");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (156,33,1,"Nenhuma das alternativas","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (157,34,1,"É o solo onde pisamos","Litosfera é o solo onde pisamos.");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (158,34,1,"É o conjunto de água de todo o planeta","Hidrosfera é o conjunto de água de todo o planeta.");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (159,34,0,"É a camada gasosa que envolve a Terra","Atmosfera é a camada gasosa que envolve a Terra");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (160,34,1,"É o conjunto de sistemas vivos do planeta","Biosfera é o conjunto de sistemas vivos do planeta.");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (161,34,1,"Nenhuma das alternativas","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (162,35,1,"É o solo onde pisamos","Litosfera é o solo onde pisamos.");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (163,35,1,"É o conjunto de água de todo o planeta","Hidrosfera é o conjunto de água de todo o planeta.");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (164,35,1,"É a camada gasosa que envolve a Terra","Atmosfera é a camada gasosa que envolve a Terra");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (165,35,0,"É o conjunto de sistemas vivos do planeta","Biosfera é o conjunto de sistemas vivos do planeta.");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (166,35,1,"Nenhuma das alternativas","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (167,36,1,"EUA","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (168,36,0,"Grécia","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (169,36,1,"Alemanha","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (170,36,1,"França","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (171,36,1,"Inglaterra","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (172,37,1,"Sócrates","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (173,37,1,"Platão","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (174,37,0,"Tales de Mileto","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (175,37,1,"Jesus Cristo","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (176,37,1,"Paulo Coelho","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (177,38,0,"Sócrates","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (178,38,1,"Aristóteles","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (179,38,1,"Epicuro","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (180,38,1,"Karl Marx","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (181,38,1,"Voltaire","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (182,39,1,"Sócrates, Tales de Mileto e Anaximandro","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (183,39,0,"Tales de Mileto, Anaximandro e Anaximenes","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (184,39,1,"Sócrates, Platão e Aristóteles","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (185,39,1,"Epicuro, Plotino e Cicero","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (186,39,1,"Diógenes, Alexandre - O Grande, e Hipátia","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (187,40,1,"Epicuro, Platão e Aristóteles","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (188,40,1,"Sócrates, Epicuro e Aristóteles","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (189,40,1,"Tales de Mileto, Epicuro e Heráclito","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (190,40,1,"Heráclito, Arquimedes e Protágoras","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (191,40,0,"Sócrates, Platão e Aristóteles","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (192,41,0,"Descartes","Embora a tríade Sócrates, Platão e Aristóteles sejam considerados os pais do pensamento científico, somente no século XV surgiu uma preocupação maior com o método.");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (193,41,1,"Aristóteles","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (194,41,1,"Kant","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (195,41,1,"Darwin","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (196,41,1,"Montainge","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (197,42,1,"Karl Marx","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (198,42,0,"Hegel","Antes da obra de Hegel, filósofos como Kant e Hume ainda consideravam o homem como um ser a-histórico.");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (199,42,1,"Nietzsche","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (200,42,1,"Sócrates","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (201,42,1,"Darwin","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (202,43,1,"Karl Marx","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (203,43,1,"Hegel","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (204,43,1,"Kant","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (205,43,1,"Witingestein","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (206,43,0,"Nietzsche","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (207,44,1,"Heidegger","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (208,44,1,"Sartre","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (209,44,1,"Hannah Arendt","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (210,44,0,"Kierkegaard","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (211,44,1,"David Hume","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (212,45,1,"Karl Jasper","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (213,45,0,"Sigmund Freud","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (214,45,1,"William Wundt","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (215,45,1,"Carl Gustav Jung","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (216,45,1,"Charcot","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (217,46,1,"Friedrich Nietzsche","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (218,46,1,"Hegel","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (219,46,1,"Heidegger","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (220,46,1,"Feurbach","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (221,46,0,"Inmanuel Kant","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (222,47,0,"Friedrich Nietzsche","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (223,47,1,"Friedrich Hegel","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (224,47,1,"Karl Marx","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (225,47,1,"Immanuel Kant","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (226,47,1,"Karl Popper","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (227,48,0,"Marx e Engels","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (228,48,1,"Hegel e Feurbach","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (229,48,1,"Rousseau e Voltaire","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (230,48,1,"John Lock e Thomas Hobbes","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (231,48,1,"Heidegger e Arendt","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (232,49,1,"Karl Popper","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (233,49,0,"Thomas Kunh","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (234,49,1,"Kant","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (235,49,1,"Freud","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (236,49,1,"Gaston Bachelard","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (237,50,0,"Heidegger e Sartre","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (238,50,1,"Sartre e Freud","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (239,50,1,"Thomas Kuhn e Karl Popper","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (240,50,1,"Richard Dawkins e Stephen Howkings","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (241,50,1,"Karl Jasper e José Saramago","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (242,51,1,"Amor à edudação","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (243,51,1,"Amizade à educação","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (244,51,1,"Amor à pesquisa","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (245,51,0,"Amizade à sabedoria","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (246,51,1,"Amizade à ciência","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (247,52,1,"Sócrates","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (248,52,1,"Galileu","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (249,52,1,"Agostinho","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (250,52,1,"Aristóteles","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (251,52,0,"Platão","Platão escreveu ""A República"" no século IV a.C");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (252,53,1,"Sócrates","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (253,53,0,"Aristóteles","Aristóteles foi o professor de Alexandre Magno à convite do pai, Felipe II da Macedônia.");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (254,53,1,"Platão","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (255,53,1,"Tomás de Aquino","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (256,53,1,"Pitágoras","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (257,54,1,"Platão","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (258,54,1,"Tomás de Aquino","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (259,54,0,"Santo Agostinho de Hipona","O santo africano, Agostinho de Hipona (354-430) escreveu as ""Confissões"" entre 397-398 d.C.");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (260,54,1,"Santo Ambrósio","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (261,54,1,"Cícero","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (262,55,0,"Descartes","Descartes defendeu a tese ""cogito ergo sum"" dando início dentro da filosofia moderna ao que se chama ""racionalismo"".");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (263,55,1,"Kant","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (264,55,1,"Hegel","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (265,55,1,"Marx","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (266,55,1,"Sêneca","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (267,56,1,"Hobbes","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (268,56,0,"Hegel","Hobbes, Locke, Rousseau e Kant pertencem ao contratualismo moderno, pois pressupõem a passagem do estado de natureza para o Estado civil mediante um contrato social. Hegel não pertence ao contratualismo, mas pelo contrário, é seu crítico.");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (269,56,1,"Locke","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (270,56,1,"Kant","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (271,56,1,"Rousseau","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (272,57,0,"1795","Immanuel Kant publicou ""À paz perpétua"" (Zum ewigen Frieden"" em 1795, na forma de um projeto contendo artigos preliminares, artigos definitivos, suplmentos e um apêndice. Essa obra ainda hoje serve de base para o estudo das Relações Internacionais.");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (273,57,1,"1801","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (274,57,1,"1789","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (275,57,1,"1804","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (276,57,1,"1785","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (277,58,1,"Hegel","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (278,58,1,"Nietzsche","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (279,58,1,"Adorno","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (280,58,0,"Kant","Immanuel Kant teorizou o ""direito cosmopolita"" na sua obra ""À paz perpétua"" em 1795.");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (281,58,1,"Leibniz","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (282,59,1,"Hegel","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (283,59,1,"Karl Marx","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (284,59,1,"Wittgenstein","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (285,59,1,"Agamben","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (286,59,0,"Habermas","Jürgen Habermas juntamente com Karl-Otto Apel são os expoentes da Ética do Discurso.");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (287,60,1,"Karl Marx","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (288,60,1,"Immanuel Kant","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (289,60,0,"John Rawls","O filósofo americano John Rawls publicou ""Uma teoria da justiça"" em 1971 e ""O direito dos povos"" em 1999.");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (290,60,1,"Michael Sandel","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (291,60,1,"Ronald Dworkin","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (292,61,0,"Auguste Comte","O termo ""Sociologia"" foi criado pelo sociólogo Auguste Comte.");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (293,61,1,"Emile Durkheim","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (294,61,1,"Max Weber","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (295,61,1,"Karl Marx","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (296,61,1,"Georg Simmel","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (297,62,1,"A Sociologia é a parte da filosofia da historia geral que estuda as ações do ser humano em meio a sociedade","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (298,62,1,"A Sociologia é o termo que sociólogos usam para definir as ações dos seres humanos perante a sociedade vivida por eles na época","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (299,62,0,"A sociologia é a parte das ciências humanas e estuda o comportamento humano em função do meio e os processos que interligam os indivíduos em associações, grupos e instituições.","Esse é o significado do termo ""Sociologia"".");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (300,63,1,"Para Durkheim, a Sociologia deve estudar os fatos sociais, os quais possuem 3 características: coesão social, exterioridade e poder de generalização","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (301,63,1,"Durkheim entendia que a sociedade é um organismo que funciona como um corpo, onde cada órgão tem sua função dos outros para sobreviver","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (302,63,0,"Durkheim concebe a sociedade divida em 2 classes: o ploretariado e dos capitalistas","Quem concebeu a sociedade dividida em 2 classes foi Karl Marx.");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (303,64,1,"Ele defendia a idéia que a sociedade deveria ser dividida em classes, só assim funcionaria corretamente","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (304,64,0,"Ele defendia a idéia de que para uma sociedade funcionar corretamente, precisa estar organizada e só assim alcançaria o grande progresso","Auguste Comte defendia a tese que se a Sociologia alcançar o progresso, ela teria que funcionar corretamente.");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (305,64,1,"Afirmava que o papel da Sociologia era observar e analisar os fenômenos que ocorrem na sociedade, buscando extrair esses fenômenos que ocorrem os ensinamentos e sistematizá-los para uma melhor compreensã","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (306,65,1,"Surgiu na Idade Antiga após a Grécia conquistar a Roma e passaram a mandar em tudo e criar leis e regras intoleráveis na época","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (307,65,1,"Surgiu na Idade Média, onde os feudos passaram a mandar em tudo, e os servos que habitavam os feudos não podiam participar de nada","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (308,65,1,"Surgiu na Idade Média, após a Roma conquistar todos os povos e estabilizar leis para o povo","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (309,65,0,"Surgiu na Idade Antiga, após a Roma conquistar a Grécia, se expandindo cada vez mais para o resto da Europa","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (310,65,1,"Surgiu na Idade Mderna com o fim do Absolutismo e estabilizando novas leis e regras aceitadas pelo povo","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (311,66,0,"Ação social","Ele defendia a tese de Ação social.");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (312,66,1,"Poder de Generalização","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (313,66,1,"Capitalismo","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (314,66,1,"Positivismo","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (315,66,1,"Metodologia do estudo","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (316,67,0,"A ação racional com relação a um objetivo é determinada por expectativas no comportamento tanto de objetos do mundo exterior como de outros homens e utiliza essas expectativas como condições ou meios para alcance de fins próprios racionalmente avaliados.","Esse é o conceito de ação racional.");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (317,67,1,"É aquela ditada pelo estado de consciência ou humor do sujeito, é definida por uma reação emocional do ator em determinadas circunstâncias e não em relação a um objetivo ou a um sistema de valor, por exemplo, a mãe quando bate em seu filho por se comportar.","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (318,67,1,"É aquela ditada pelos hábitos, costumes, crenças transformadas numa segunda natureza, para agir conforme a tradição o ator não precisa conceber um objeto, ou um valor nem ser impelido por uma emoção, obedece a reflexos adquiridos pela prática.","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (319,68,1,"A produção sociológica pode estar voltada para engendrar uma forma de conhecimento comprometida com emancipação humana.","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (320,68,1,"A força dos sociólogos perante ao povo para estabelecer leis e regras e acabar com divisões de classes e descobrir o verdadeiro sentido da palavra ""sociedade""","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (321,68,1,"Procurar saber o que os seres humanos pensam sobre isso e um método convencional de estabelecer o universo perante a sociedade","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (322,68,1,"A sociologia no mundo foi-se mostrando presente em várias datas importantes desde as grandes revoluções, desde lá cada vez mais foi de fundamental participação para a sociedade mundial e também brasileira.","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (323,68,0,"Seus resultados podem ser utilizados com vistas à melhoria dos mecanismos de dominação por parte do Estado ou de grupos minoritários, sejam eles empresas privadas ou centrais de inteligência, sendo orientada de acordo com o nível de relação sociedade.","Esse é o significado do termo ""Ciência e Ordem"".");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (324,69,1,"Foi instituída pelos sociólogos Auguste Comte e Georg Simmel","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (325,69,1,"Tem estreitas ligações com a filosofia moderna e antiga e com a ciência perante ao universo","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (326,69,1,"Procura saber o que os seres humanos pensam sobre isso e um método convencional de estabelecer o universo perante a sociedade","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (327,69,1,"Sobre a divisão do universo","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (328,69,0,"A sociologia da ciência é um ramo de estudo da sociologia dentro do campo da sociologia do conhecimento que estuda a influência de fatores externos no desenvolvimento da ciência","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (329,70,1,"Pierre Bordieu","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (330,70,1,"Max Weber","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (331,70,1,"Émile Durkheim","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (332,70,0,"Karl Marx","O sociólogo que estuda aprofundadamente a luta de classes é Karl Marx.");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (333,70,1,"Saint-Simon","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (334,71,1,"Solidariedade Tribal","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (335,71,1,"Solidariedade Coercitiva","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (336,71,1,"Solidariedade Orgânica","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (337,71,1,"Solidariedade de Direito Repressivo","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (338,71,0,"Solidariedade Mecânica","Segundo Émile Durkheim, a solidariedade mecânica é anterior à orgânica, sendo aquela típica das sociedades pré-capitalistas, enquanto esta é exclusiva de sociedades capitalistas.");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (339,72,1,"A sociologia é a ciência da crise porque seu surgimento se dá em meio a uma terrível crise do sistema feudal europeu, sistema vigente até então.","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (340,72,1,"A sociologia pode ser assim descrita porque ela surgiu em meio a uma crise econômica que desestruturou a economia mundial: a crise de 29.","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (341,72,0,"A sociologia pode ser descrita como ""ciência da crise"" porque esta ciência surgiu em meio as várias transformações que ocorriam na Europa no final do século XVIII. Transformações tais como a Revolução Francesa e Industrial.","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (342,72,1,"A sociologia pode ser analisada como a ciência da crise pois seu fundador, Comte, estava preocupado com a solução da crise provocada pela revolução de Avis.","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (343,72,1,"A sociologia pode ser assim descrita pois Comte, quando a criou, não preocupou-se com o teor teórico e sim prático da sociologia, deixando, assim, os sociólogos posteriores sem fundamentos teóricos, o que levou-os a uma crise intelectual.","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (344,73,0,"Émile Durkheim","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (345,73,1,"Jean Jacques Rousseau","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (346,73,1,"Max Weber","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (347,73,1,"Theodor Adorno","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (348,73,1,"Montesquieu","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (349,74,1,"Mais-valia absoluta","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (350,74,1,"Mais-valia tecnológica","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (351,74,0,"Mais-valia relativa","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (352,74,1,"Mais-valia equivalente","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (353,74,1,"Mais-valia dinâmica","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (354,75,1,"Capitalismo e Socialismo","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (355,75,1,"Feudalismo e Capitalismo","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (356,75,1,"Tirania e República","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (357,75,1,"Socialismo e Capitalismo","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (358,75,0,"Socialismo e Comunismo","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (359,76,0,"Adorno, Benjamin e Horkheimer","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (360,76,1,"Adorno, Rousseau e Montesquieu","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (361,76,1,"Benjamin, Adorno e Smith","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (362,76,1,"Smith, Ricardo e David","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (363,76,1,"Otto von Krüss, Ritzee e Werner","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (364,77,1,"Neoliberalismo","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (365,77,1,"Comunismo","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (366,77,1,"Capitalismo","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (367,77,0,"Estado de Bem Estar Social","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (368,77,1,"Estado de Igualdade Utópico","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (369,78,0,"Adam Smith","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (370,78,1,"Habermas","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (371,78,1,"J.J.Rousseau","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (372,78,1,"Marx","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (373,78,1,"Weber","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (374,79,1,"50","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (375,79,1,"79","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (376,79,0,"76","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (377,79,1,"40","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (378,80,0,"Mercúrio","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (379,80,1,"Argônio","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (380,80,1,"Bromo","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (381,80,1,"Hidrogênio","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (382,81,1,"H","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (383,81,0,"Hs","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (384,81,1,"Sb","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (385,81,1,"Kr","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (386,82,0,"Flúor, cloro, chumbo, iodo, astato.","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (387,82,1,"Flúor, cloro, bromo, iodo, astato.","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (388,82,1,"Flúor, cloro, cálcio, iodo, astato.","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (389,82,1,"Flúor, cloro, carbono, iodo, astato.","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (390,83,0,"13","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (391,83,1,"56","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (392,83,1,"15","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (393,83,1,"11","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (394,84,1,"Horizontal e vertical","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (395,84,0,"Vertical e Horizontal","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (396,84,1,"Linha reta","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (397,84,1,"Direita para a esquerda","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (398,85,1,"Metais alcalinos","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (399,85,1,"Família do boro","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (400,85,0,"Metais de transição","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (401,85,1,"Halogênios","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (402,86,0,"Dmitri Ivanovich","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (403,86,1,"Mendel","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (404,86,1,"Rutherford","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (405,86,1,"Einstein","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (406,86,1,"John Dalton","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (407,87,1,"Mesa de bilhar","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (408,87,1,"Segunda lei de Newton","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (409,87,0,"Pudim de passas","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (410,87,1,"Torta de sementes","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (411,87,1,"Sistema Planetário","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (412,88,1,"Se inspirou no modelo de Thompson,e criou em 1923.","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (413,88,1,"Se inspirou no modelo de Rutherford, e criou em 1922.","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (414,88,0,"Se inspirou no modelo de Rutherford, e criou em 1923.","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (415,88,1,"Se inspirou no modelo de Rutherford, e criou em 2017.","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (416,88,1,"Se inspirou no modelo de Newton, em 1992.","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (417,89,1,"Carga positiva.","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (418,89,0,"Carga negativa.","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (419,89,1,"Carga neutra.","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (420,89,1,"Carga espacial.","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (421,89,1,"Carga de plasma.","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (422,90,1,"Carga de mistura entre a positiva e a negativa.","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (423,90,1,"Carga cósmica.","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (424,90,1,"Carga neutra.","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (425,90,1,"Carga negativa.","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (426,90,0,"Carga positiva.","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (427,91,1,"Lactobacilos e Aedes Aegypti","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (428,91,1,"Elétrons e nêutrons","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (429,91,1,"Prótons e elétrons","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (430,91,1,"Nêutrons e lactobacilos","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (431,91,0,"Prótons e nêutrons","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (432,92,1,"1","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (433,92,0,"2","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (434,92,1,"3","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (435,92,1,"4","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (436,92,1,"5","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (437,93,0,"Niels Bohr","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (438,93,1,"Obama","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (439,93,1,"Dalton","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (440,93,1,"Thompson","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (441,93,1,"Nenhuma das anteriores","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (442,94,1,"Menos de 10 minutos.","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (443,94,1,"Entre 10 e 20 minutos.","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (444,94,1,"Mais de 20 minutos.","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (445,94,1,"Um tempo necessário para destruir os gemes que se fixam no bulbo do termômetro.","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (446,94,0,"Não devemos ferver um termômetro clínico.","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (447,95,1,"Uma função da temperatura do corpo.","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (448,95,1,"Energia Térmica contida em um corpo.","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (449,95,0,"Energia em trânsito entre dois corpos, motivada por uma diferença de temperatura.","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (450,95,1,"A variação de temperatura de um corpo.","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (451,95,1,"Uma grandeza sem definição.","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (452,96,1,"Qualquer material está no estado sódio.","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (453,96,1,"Nenhum corpo troca calor.","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (454,96,0,"Um termômetro marca 32°F.","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (455,96,1,"Qualquer termômetro indica o valor 0.","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (456,96,1,"Nenhuma das anteriores.","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (457,97,1,"4600 cal","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (458,97,1,"6400 cal","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (459,97,0,"66000 cal","Q=? M=400 c=80 delta T=0,2 Resolução: Q=400.80.0,2 Q=32000.0,2 Q=6400 cal");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (460,97,1,"5000 cal","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (461,97,1,"1000 cal","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (462,98,1,"4600 cal","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (463,98,0,"6400 cal","Q=? M=400 c=80 delta T=0,2 Resolução: Q=400.80.0,2 Q=32000.0,2 Q=6400 cal");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (464,98,1,"66000 cal","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (465,98,1,"5000 cal","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (466,98,1,"1000 cal","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (467,99,0,"C=-17,7","0-32/= C/5 -32/9=C/5 -160/9C C=-17,7");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (468,99,1,"C= 44,5","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (469,99,1,"C=20,6","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (470,99,1,"C=16,8","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (471,99,1,"C=31,1","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (472,100,1,"55,9","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (473,100,1,"99,4","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (474,100,1,"79,1","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (475,100,1,"45,6","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (476,100,0,"98,6","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (477,101,1,"448","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (478,101,1,"955","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (479,101,1,"971","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (480,101,1,"548","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (481,101,0,"377","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (482,102,0,"3658","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (483,102,1,"4435","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (484,102,1,"3632","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (485,102,1,"9471","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (486,102,1,"7894","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (487,103,1,"53","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (488,103,0,"-76","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (489,103,1,"995","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (490,103,1,"681","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (491,103,1,"546","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (492,104,1,"Isaac Newton","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (493,104,0,"Benjamin Thompson – Conde de Rumford","O principio de Lavoisier a Quantidade de calórico Deveria se Conservar em um Processo de transferencia de calor de um Corpo a Outro. Porem Thompson observou, Que a Água PODIA Ser aquecida indefinidamente de Maneira Que o calor Não Se conservava.");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (494,104,1,"Galileu Galilei","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (495,104,1,"John Herapath","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (496,105,1,"Kcal e Joule","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (497,105,1,"Celsius e Calorias","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (498,105,0,"Celsius e Joule","O Sistema Internacional adota a Unidade Kelvin, Por Exemplo, Como Padrão Para a grandeza temperatura. Essa Unidade E MUITO utilizada em Experimentos laboratoriais, mas, não dia a dia, a maioria dos e Países utiliza uma Unidade graus Celsius e Joule.");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (499,105,1,"Calorias e Joule","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (500,106,0,"Condução","Ao se aquecer, por exemplo, a extremidade A de uma barra metálica enquanto a outra extremidade, B, é mantida a uma temperatura menor, existe uma transmissão desse calor da extremidade A em direção à extremidade B.Esse fluxo de energia é chamada condução.");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (501,106,1,"Translação","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (502,106,1,"Combustão","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (503,106,1,"Convecção","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (504,107,1,"Esquentar","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (505,107,1,"Correntes de Aquecimento","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (506,107,0,"Correntes de Convecção","A convecção é a forma de transmissão do calor que ocorre principalmente nos fluidos (líquidos e gases). Diferentemente da condução onde o calor é transmitido de átomo a átomo sucessivamente, na convecção a propagação do calor.");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (507,107,1,"Corrente térmica","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (508,108,1,"Tem calor específico muito grande.","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (509,108,1,"Tem temperatura muito baixa.","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (510,108,0,"Tem capacidade térmica muito pequena.","A massa individual de cada fagulha é muito pequena. Logo, a perda de calor para o meio é muito mais rápida, além de o metal ter um alto coeficiente de transmissão térmica.");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (511,108,1,"Estão em mudança de estado.","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (512,109,1,"Adiabática e isobárica.","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (513,109,1,"Isométrica e isotérmica.","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (514,109,1,"Isotérmica e adiabática.","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (515,109,0,"Isobárica e isotérmica.","A transformação isobárica é uma transformação em que variam somente o volume e a temperatura de um gás.Na transformação isotérmica todo calor cedido pelo meio é transformado em trabalho de expansão do gás e, mesmo não havendo variação de temperatura.");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (516,110,1,"Transformação foi cíclica.","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (517,110,1,"A transformação isométrica","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (518,110,1,"Não houve troca de calor entre o gás e o ambiente","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (519,110,0,"São iguais as temperaturas dos estados inicial e final.","Gás perfeito é um modelo idealizado para o comportamento dos gases.");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (520,111,0,"O volume aumenta e a energia interna permanece constante.","Numa transformação isotérmica, a temperatura permanece constante, variando a pressão e o volume da massa gasosa. Então, o valor final da temperatura é igual ao valor inicial (T0 = T1).");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (521,111,1,"A pressão e o volume aumentam.","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (522,111,1,"O volume e a energia interna diminuem.","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (523,111,1,"A pressão aumenta e a energia interna diminui.","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (524,112,1,"Massa","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (525,112,1,"Densidade","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (526,112,1,"Capacidade térmica","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (527,112,0,"Calor específico","Os corpos e as substâncias na natureza reagem de maneiras diferentes quando recebem ou cedem determinadas quantidades de calor. Alguns esquentam mais rápido que os outros.");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (528,113,1,"Medida da energia interna de um corpo.","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (529,113,0,"Forma de energia transferida devido à diferença de temperatura.","Calor é um conceito do âmbito da Física que representa uma forma de energia, sendo a energia térmica em movimento entre partículas atômicas. A palavra calor também pode remeter para alguma coisa quente, ou seja, com temperatura elevada.");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (530,113,1,"Forma de energia atribuida aos corpos quentes.","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (531,113,1,"Forma de energia inexistente nos corpos frios.","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (532,114,1,"Transferível","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (533,114,1,"Dinâmico","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (534,114,1,"Latente","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (535,114,0,"Sensível","O calor fornecido a um corpo que gera apenas variação de temperatura é denominado de sensível; caso haja mudança de fase, o calor será chamado de latente.");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (536,115,0,"Capacidade térmica","A capacidade térmica é a grandeza que caracteriza a variação de temperatura sofrida por corpos. É uma característica do corpo, e não da substância.");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (537,115,1,"Capacidade de aquecimento","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (538,115,1,"Capacidade corpórea","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (539,115,1,"Capacidade Variada","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (540,116,0,"Nas paredes, nas roupas, nos sapatos, no pão, nas frutas e nas verduras.","Mofos e bolores crescem nas paredes, nas roupas, nos sapatos, no pão, nas frutas e nas verduras.");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (541,116,1,"Em piscinas, lagos e lagoas.","micose e foliculite");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (542,116,1,"Em todo tipo de árvore."," musgos, líquens e fungos");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (543,116,1,"Nas rochas.","Fungus Rock");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (544,117,1,"São doenças causadas pelo Mico-leão-dourado.","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (545,117,0,"São doenças causadas por fungos.","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (546,117,1,"São doenças causadas por comidas enlatadas.","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (547,117,1,"São doenças causadas por bactérias e protosoários.","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (548,118,1,"É a área da ciência que estuda os micos.","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (549,118,1,"É a área da ciência que estuda as algas.","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (550,118,1,"É a área da ciência que estuda protosoários.","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (551,118,0,"É a área da ciência que estuda os fungos.","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (552,119,1,"Lugares com muita iluminação.","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (553,119,1,"Lugares secos e com pouca matéria orgânica.","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (554,119,0,"Lugares úmidos e ricos em matéria orgânica.","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (555,119,1,"Lugares pouca matéria orgânica e muita luz.","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (556,120,0,"De entrelaçamentos de hifas.","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (557,120,1,"De gás oxigênio.","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (558,120,1,"De algas.","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (559,120,1,"De bactérias.","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (560,121,1,"A celulose.","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (561,121,0,"A quitina.","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (562,121,1,"A clorofila.","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (563,121,1,"A clorofila e a celulose.","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (564,122,1,"A chuva e o sol.","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (565,122,1,"O vento e o sol.","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (566,122,1,"O sol.","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (567,122,0,"O vento.","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (568,123,1,"De Fungo-decompositor-rhodophyta.","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (569,123,1,"De rhodophyta.","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (570,123,0,"De saprófito.","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (571,123,1,"De bactéria","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (572,124,0,"Fungos e algas.","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (573,124,1,"Apenas fungos.","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (574,124,1,"Apenas algas.","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (575,124,1,"Fungos e protosoários.","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (576,125,1,"Aeróbios.","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (577,125,0,"Anaeróbios.","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (578,125,1,"Aeróbios e anaeróbios.","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (579,125,1,"Nenhuma das alternativas anteriores.","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (580,126,1,"Orgão","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (581,126,0,"Tecido","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (582,126,1,"Sistema","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (583,126,1,"Organismo","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (584,126,1,"Cavidade","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (585,127,0,"Quimiorreceptores","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (586,127,1,"Mecanorreceptores","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (587,127,1,"Termorreceptores","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (588,127,1,"Fotorreceptores","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (589,127,1,"Fonorreceptores","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (590,128,1,"Globo ciliar","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (591,128,1,"Cristalino","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (592,128,0,"Íris","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (593,128,1,"Córnea","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (594,128,1,"Pupila","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (595,129,0,"Pleura","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (596,129,1,"Pericárdio","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (597,129,1,"Peritônio","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (598,129,1,"Diafragma","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (599,129,1,"Intercostal","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (600,130,0,"Aorta","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (601,130,1,"Pulmonar","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (602,130,1,"Semilunar","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (603,130,1,"Mitral","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (604,130,1,"Coronária","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (605,131,1,"Baço","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (606,131,1,"Linfonodo","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (607,131,1,"Medula óssea","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (608,131,0,"Estômago","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (609,131,1,"Timo","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (610,132,1,"Estômago","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (611,132,1,"Fígado","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (612,132,1,"Pâncreas","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (613,132,1,"Intestino","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (614,132,0,"Baço","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (615,133,1,"Adrenalina","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (616,133,1,"Cortisol","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (617,133,0,"T3 e T4","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (618,133,1,"Testosterona","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (619,133,1,"Epnefrina","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (620,134,1,"Tricuríase","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (621,134,0,"Eschistossomose","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (622,134,1,"Toxocaria","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (623,134,1,"Ancilostomíase","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (624,134,1,"Oxiuríase","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (625,135,1,"Feio","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (626,135,1,"Estranho","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (627,135,1,"Legal","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (628,135,1,"Horrível","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (629,135,0,"Lindo","sinônimos são palavras que possuem o mesmo significado. Portanto, Lindo é o mesmo que bonito. (Mesmo que na linguagem coloquial, Lindo seja maior do que bonito)");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (630,136,1,"Afobado","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (631,136,0,"Tranquilo","Antônimos são palavras que possuem um significado oposto da palavra. Quem fica agitado, não fica tranquilo.");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (632,136,1,"Empolgado","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (633,136,1,"Cansado","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (634,136,1,"Atordoado","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (635,137,1,"Manda e Manga","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (636,137,1,"Forma e forma","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (637,137,0,"Tráfego e tráfico","Parônimos são palavras parecidas na escrita e na pronúncia. Não são escritas da mesma forma e nem pronunciadas, porém confunde o ouvinte desatento. No caso, pode ser tráfego de carros e Tráfico de drogas, por exemplo.");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (638,137,1,"Rato e elefante","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (639,137,1,"Pássaro e Passaram","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (640,138,0,"1º Sujeito: Todos os guerreiros. 2º Sujeito: A sina. 3º Sujeito: Um bom sabre.","1ª frase: Todos os guerreiros conseguirão vencer as guerras. (Quem conseguirá vencer as guerras? -Todos os guerreiros) 2ª frase: Quando a eles dispõe a sina. (Quem dispõe? -A sina) 3ª frase: mesmo que ... bom sabre. (O que não será dado? -Um bom sabre)");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (641,138,1,"1º Sujeito: Todos os guerreiros 2º Sujeito: Dispõe a sina 3º Sujeito: Seja dado um bom sabre","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (642,138,1,"1º Sujeito: Todos os guerreiros 2º Sujeito: um bom sabre","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (643,138,1,"1º Sujeito: Todos os guerreiros 2º Sujeito: Aos mais fracos 3º Sujeito: Guerras","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (644,138,1,"1º Sujeito: Todos os guerreiros 2º Sujeito: Um bom sabre 3º Sujeito: As guerras","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (645,139,1,"Os documentos foram apresentados à juíza.","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (646,139,1,"Ele foi à França","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (647,139,1,"A loja estará aberta de 10h às 18h","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (648,139,0,"Pedro trabalhará de segunda à sexta-feira","Embora a crase seja sempre usada quando falamos de horário, em dias da semana, o uso é incorreto em qualquer situação.");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (649,139,1,"Podolski retornou à Alemanha","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (650,140,1,"Luana foi à São Paulo.","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (651,140,1,"Douglas retornou à Roma.","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (652,140,0,"Seu pai saiu às pressas.","Quando há locuções adverbiais femininas, é obrigatório o uso da crase (às presas, às vezes, à direita, à esquerda etc)");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (653,140,1,"Meu restaurante vende bife à cavalo.","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (654,140,1,"Nosso governo está lado à lado com o povo brasileiro.","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (655,141,1,"Cadeira","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (656,141,1,"Brasileira","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (657,141,0,"Carne","Oxítonas são palavras onde a sílaba tônica é a última da palavra. Sílaba tônica é a sílaba mais forte da palavra.");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (658,141,1,"Carnê","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (659,141,1,"Sempre","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (660,142,1,"pólen","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (661,142,1,"inconstitucionalissimamente","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (662,142,0,"quilômetro","proparoxítona é a palavra que a sílaba tônica aparece na antepenúltima posição.");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (663,142,1,"umbigo","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (664,142,1,"correta","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (665,143,1,"Dominó","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (666,143,1,"Óculos","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (667,143,1,"Impenetrável","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (668,143,1,"Cooperar","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (669,143,0,"Vida","paroxítonas são palavras onde a sílaba tônica aparece em penúltimo lugar.");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (670,144,1,"igual","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (671,144,0,"Saara","Hiato aparece quando há separação entre duas vogais. Portanto: Saara é Hiato. SA-A-RA. *Toda vogal idêntica apresenta hiato.");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (672,144,1,"pai","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (673,144,1,"céu","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (674,144,1,"relógio","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (675,145,1,"Tipo de iguaria tradicional do nordeste brasileiro","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (676,145,1,"Espécie de dialeto falado no médio oriente","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (677,145,1,"Antiga unidade monetária da Suiça","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (678,145,1,"Antiga dança tradicional do Afeganistão","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (679,145,0,"Espécie de peixe muito cultivado em piscicultura","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (680,146,1,"Fidalgo é o mesmo que Nobre","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (681,146,1,"Fedelho quer dizer criança de pouca idade","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (682,146,1,"Fiança é a mesma coisa que Garantia","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (683,146,1,"Cuscuz é um prato regional brasileiro feito com farinha de milho","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (684,146,0,"Soror é uma solução mineral ou orgânica usada nos hospitais","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (685,147,1,"É como são conhecidas as contusões que apresentam inchaços","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (686,147,1,"Pequeno morro ou monte de terra","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (687,147,1,"É o outro nome para as Lombadas usadas nas estradas ou ruas","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (688,147,1,"É quando alguma coisa aumenta de volume","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (689,147,0,"Esconderijo onde os escravos se refugiavam","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (690,148,1,"Alusivo, Referente, Relativo","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (691,148,1,"Amassar, Sovar, Mesclar","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (692,148,1,"Altura, Estatura, Cume","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (693,148,1,"Concordância, Aprovação, Anuência","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (694,148,0,"Amenizar, Abrandar, Fortalecer","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (695,149,1,"Dor na testa","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (696,149,1,"Dor nas costas","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (697,149,0,"Dor no olho","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (698,149,1,"Dor no ouvido","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (699,149,1,"Dor na pálpebra","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (700,150,1,"Espécie de gemido próprio de felinos","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (701,150,0,"Dor muscular","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (702,150,1,"Corda de instrumento musical feita de couro","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (703,150,1,"Dor nos ossos","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (704,150,1,"Dor nos Rins","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (705,151,1,"Fofoqueiro","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (706,151,1,"Especialista em Insetos","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (707,151,0,"Fumante","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (708,151,1,"Colecionador de Cigarras","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (709,151,1,"Vigarista","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (710,152,1,"Dor na planta do pé","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (711,152,1,"É o mesmo que Antalgia","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (712,152,0,"Sensibilidade à dor","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (713,152,1,"Dor no dorso da mão","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (714,152,1,"Insensibilidade à dor","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (715,153,0,"Rápido","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (716,153,1,"Prolixo","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (717,153,1,"Duradouro","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (718,153,1,"Longo","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (719,153,1,"Extenso","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (720,154,1,"Mulher que modela potes de cerâmica","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (721,154,1,"Vendedor de obras de arte","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (722,154,0,"Espécie de Planta ramosa e aromática","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (723,154,1,"O mesmo que Artesanato","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (724,154,1,"Pessoa que coleciona obras de arte","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (725,155,0,"Augusto dos Anjos e Simões Lopes foram os únicos escritores encontrados na era Pré-Modernista.","Euclides da Cunha, Graça Aranha, Monteiro lobato e Lima Barreto também foram escritores Pré-Modernistas.");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (726,155,1,"O Pré-Modernismo, não pode ser considerada uma escola literária pois sua obras não possuem características semelhantes.","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (727,155,1,"Ocorreu no período de diversas revoltas e violências.","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (728,155,1,"Euclides da Cunha, Graça Aranha e Lima Barreto são alguns dos principais autores Pré-Modernistas","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (729,155,1,"Suas principais influências estavam divididas entre dois grupos : Passadistas e Renovadores","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (730,156,1,"Regionalismo e Ufanismo","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (731,156,1,"Pobreza e Riqueza","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (732,156,1,"Nacionalismo e Linguagem coloquial","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (733,156,0,"Marginalidade e Pobreza","Ao contrário dos românticos os pré-modernistas expressavam o verdadeiro Brasil , o Brasil pobre e Marginalizado!");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (734,156,1,"Nacionalismo e Regionalismo","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (735,157,1,"Pregava a mentira e a valorização do Brasil","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (736,157,0,"Pregava a crítica e a denuncia","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (737,157,1,"Pregava a falta de interesse pelos problemas sociais","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (738,157,1,"Pregava o interesse pelos problemas pessoais","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (739,157,1,"Pregava o interesse pelos problemas mundias","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (740,158,0,"Coloquial","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (741,158,1,"Culta","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (742,158,1,"Pobre","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (743,158,1,"Irônica","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (744,158,1,"Nenhuma das Alternativas","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (745,159,0,"É irônica. Faz-se uma sátira indireta com teor mordaz.","A cantiga de escárnio é marcada por sátiras corrosivas, indiretas e de duplo sentido.");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (746,159,1,"É contemplada por paralelismos, possuindo um homem como eu-lírico.","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (747,159,1,"Sua voz é feminina e apresenta Vassalagem Amorosa em seu conteúdo.","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (748,159,1,"Apresenta uma crítica direta e carregada de palavrões.","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (749,159,1,"Trata sobre a temática da saudade.","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (750,160,1,"Sonetos Decassílabos.","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (751,160,1,"Versos Alexandrinos.","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (752,160,1,"Versos Trissílabos.","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (753,160,0,"Redondilhas Menores e Redondilhas Maiores.","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (754,160,1,"Versos Livres.","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (755,161,1,"Marcado pelas sátiras e peças de caráter moralizante.","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (756,161,1,"Um dos assuntos mais recorrentes foi a religião.","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (757,161,0,"Ausência de Maniqueísmo.","O maniqueísmo é explorado nas obras vicentinas. O personagem bom sempre representará o bem e o mau sempre expressará o mal. Inexistindo mobilidade ou alteração de caráter.");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (758,161,1,"Expressão de fantasias alegóricas dos vícios e virtudes de instituições sociais pelos personagens.","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (759,161,1,"Uma de suas principais peças foi o Auto da Barca do Inferno. Por ela, levantou uma densa crítica social.","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (760,162,0,"A arte confunde-se com a realidade, tenta imita-la deixando-a melhor, aproximando-se da “perfeição” (Platônica).","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (761,162,1,"Foi a primeira escola literária a se estabelecer no Brasil.","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (762,162,1,"Possui aspecto dionisíaco.","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (763,162,1,"Seus texto gozavam de requinte e temática complexa, desprezando a simplicidade.","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (764,162,1,"As obras deveriam ser ébrias e manter, em certa medida, deformidades.","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (765,163,1,"Classicismo","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (766,163,1,"Realismo","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (767,163,0,"Quinhentismo","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (768,163,1,"Colonial Literário","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (769,163,1,"Barroco","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (770,164,1,"Jogo de sons.","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (771,164,1,"Jogo de Ideias.","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (772,164,0,"Jogo de palavras.","O cultismo emprega uma linguagem normativa, culta, requintada. Faz, portanto Jogo de Palavras em poemas. Já o conceptismo, baseado em argumentos racionais, trabalha com o Jogo de Ideias em prosa.");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (773,164,1,"Jogo de simplicidade.","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (774,164,1,"Jogo de sinonímias.","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (775,165,1,"Autores, dessa escola literária, adotaram pseudônimos pastoris gregos ou latinos.","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (776,165,0,"Os autores habitavam zonas campestres e sugeriam que a população citadina fugisse de ambientes tumultuados tais quais as grandes cidades.","Os autores residiam em cidades, porém fingiam sentimentos hipotéticos ao campo por intermédio de pseudônimos (áurea mediocritas).");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (777,165,1,"Lócus Amoenus, proposto pelo movimento, tratava-se do refúgio dos centros urbanos tumultuados, permitindo a comunhão com a natureza.","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (778,165,1,"Presença da sugestão Fugere Urbem: fuga da cidade, na procura de evitar confusões urbanas, distanciando-se para áreas campestres.","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (779,165,1,"Os autores indicavam o Carpen Dien: aproveitar o dia, vivendo-o intensamente.","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (780,166,0,"Nacionalismo.","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (781,166,1,"Niilismo.","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (782,166,1,"Simplicidade.","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (783,166,1,"Equilíbrio.","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (784,166,1,"Altruísmo.","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (785,167,0,"A Primeira Geração expressava Sentimento Ufanista e prezava pela construção do herói nacional.","A Primeira Geração valorizou aspectos nacionais além de Buscar a constituição do herói nacional (índio) com base na figura concebida a partir de moldes medievais. A Segunda Geração, Ultrarromântica, PRETENDIA/(FEZ) a Idealização de um objeto ou da amada.");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (786,167,1,"A Segunda Geração, Ultrarromântica, preteria a Idealização de um objeto ou da pessoa amada.","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (787,167,1,"Álvares de Azevedo e Castro Alves foram os principais representantes da Segunda Geração.","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (788,167,1,"A Terceira Geração era favorável ao tráfico negreiro.","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (789,167,1,"Os autores da Terceira Geração recorriam às marcas clássicas de formalidade estética além de expressarem o nacionalismo exacerbado.","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (790,168,1,"Compreensivo","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (791,168,0,"Abrangente","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (792,168,1,"Decisivo","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (793,168,1,"Compreendido","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (794,168,1,"Compreensão","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (795,169,1,"Puxar","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (796,169,1,"Levantar","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (797,169,0,"Empurrar","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (798,169,1,"Puxador","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (799,169,1,"Saída","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (800,170,1,"Fábrica","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (801,170,0,"Tecido","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (802,170,1,"Fabricar","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (803,170,1,"Fazer","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (804,170,1,"Familía","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (805,171,0,"Presumir","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (806,171,1,"Assumir","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (807,171,1,"Procurar","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (808,171,1,"Aspirar","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (809,171,1,"Admirar","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (810,172,1,"Legenda","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (811,172,1,"Lendário","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (812,172,1,"Livraria","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (813,172,0,"Lenda","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (814,172,1,"Legendário","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (815,173,1,"Suportar","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (816,173,1,"Aguentar","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (817,173,1,"Levantar","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (818,173,0,"Apoiar","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (819,173,1,"Esperar","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (820,174,1,"Colega","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (821,174,1,"Escola","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (822,174,0,"Colégio","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (823,174,1,"Ensino Médio","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (824,174,1,"Faculdade","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (825,175,1,"Parentes","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (826,175,0,"Pais","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (827,175,1,"Peças","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (828,175,1,"Participar","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (829,175,1,"Parar","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (830,176,0,"Pretender","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (831,176,1,"Intender","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (832,176,1,"Elogiar","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (833,176,1,"Inspecionar","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (834,176,1,"Interligar","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (835,177,1,"I","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (836,177,1,"He","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (837,177,0,"She","Usa-se ""She"" para referirmos ao sexo feminino.");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (838,177,1,"It","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (839,177,1,"We","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (840,178,1,"Tuesday","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (841,178,0,"Thursday","Se Robert e Sarah foram ao restaurante ontem e hoje é sexta-feira, logo eles foram à quinta-feira, ou seja, ""Thursday"".");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (842,178,1,"Sunday","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (843,178,1,"Saturday","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (844,178,1,"Wednesday","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (845,179,1,"How","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (846,179,1,"When","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (847,179,0,"What""s","""What"" É utilizado para perguntas de coisas em geral.");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (848,179,1,"Why","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (849,179,1,"Where","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (850,180,1,"This","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (851,180,1,"That","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (852,180,1,"These","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (853,180,0,"Those","Os pronomes That e Those serão usados para refrir - se a objetos que estão distantes de quem esta falando. That = Aquele, Aquilo, Aquela. Those = Aqueles, Aquelas.");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (854,180,1,"There","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (855,181,0,"What do you do?","""what do you do?"" é usada para perguntar o que você faz?, qual a sua profissão?, você ganha a vida fazendo o que?");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (856,181,1,"What""s your name?","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (857,181,1,"How are you?","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (858,181,1,"What time is it?","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (859,181,1,"How old are you?","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (860,182,1,"It""s twelve o lock.","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (861,182,1,"It""s aquarter past two.","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (862,182,1,"It""s four o""clock.","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (863,182,0,"It""s half past nine.","Quando em português dizemos 09:30 – “São nove e meia”, esse “e meia” em inglês é “and a half“:");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (864,182,1,"It""s nine o""clock and thirty minutes.","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (865,183,0,"In","Em Inglês, tanto para lugar como para tempo, iremos usar três preposições básicas: IN, ON, AT. Quando for falar de tempo, use IN para se referir aos períodos maiores e menos específicos, como uma parte do dia, um mês, uma estação ou um ano.");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (866,183,1,"At","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (867,183,1,"On","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (868,183,1,"Be","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (869,183,1,"For","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (870,184,1,"Muito Obrigada.","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (871,184,1,"Seja bem vindo.","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (872,184,1,"Como vai você?","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (873,184,0,"Prazer em conhecê-lo.","Esta é uma expressão usada quando se é apresentado a alguém.");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (874,184,1,"Até logo.","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (875,185,1,"Are","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (876,185,0,"Don't","O ""do"" é um verbo auxiliar utilizado para indicar sentenças que estão no tempo Presente ou Simple Present no inglês. A composição don't é a forma abreviada do verbo auxiliar + NOT (não em inglês).");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (877,185,1,"There","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (878,185,1,"No","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (879,185,1,"The","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (880,186,1,"Looking","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (881,186,1,"Going","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (882,186,1,"Walking","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (883,186,1,"Feeding","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (884,186,0,"Amazing","""Amazing"" significa surpreendente, maravilhoso, portanto, não é um verbo.");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (885,187,1,"How much is those?","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (886,187,1,"How old you have?","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (887,187,1,"How I am this?","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (888,187,1,"How old is it?","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (889,187,0,"How much is this?","How much is this"" singnifica ""quanto é isso"".");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (890,188,0,"Seu tio Salvador soprou-lhe nas narinas uma baforada de charuto","Seu tio Salvador soprou-lhe nas narinas uma baforada de charuto");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (891,188,1,"Sua mãe balançou-o com muita força até ele acordar","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (892,188,1,"Foi realizado um procedimento médico, onde havia muitos riscos de Pablo morrer","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (893,189,1,"María Paula Lopéz e José Picasso","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (894,189,1,"María Picasso Lopéz e Juan Ruíz","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (895,189,0,"María Picasso Lopés e José Ruíz","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (896,189,1,"María de Los Remedios e José Ruíz","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (897,190,0,"Em homenagem a familiares e conhecidos","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (898,190,1,"Em homenagem a professores e amigos de infância","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (899,190,1,"Em homenagem a pessoa que salvou sua vida","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (900,191,1,"Rebelde e solitário","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (901,191,1,"Disciplinado e sonhador","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (902,191,1,"Inteligente e talentoso","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (903,191,0,"Indisciplinado e rebelde","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (904,192,0,"Fazia questão de dirigir tudo que fazia e se gabava dizendo que sabia de tudo e não havia o que seus professores lhe ensinassem","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (905,192,1,"Era independente, gostava de seus professores, e tudo que eles ensinavam ele acolhia com muita sabedoria","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (906,193,1,"Autorretrato de Pablo Picasso","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (907,193,1,"You, Rey","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (908,193,0,"Yo, Rey","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (909,193,1,"Pablo Picasso","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (910,194,1,"Van Gogh e Renoir","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (911,194,1,"Lautrec e Van Gogh","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (912,194,0,"Lautrec e Renoir","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (913,194,1,"Renoir e Cézanne","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (914,195,1,"Era muito bonito, alto e atraente, por isso atraia as mulheres","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (915,195,0,"Apesar de não ser bonito, possuía um charme que o tornava atraente","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (916,196,1,"Pintava quadros que transmitiam alegria (artistas de circo, arlequins, crianças e saltimbancos)","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (917,196,0,"Pintava quadros que transmitiam tristeza (mendigos, arlequins solitários, mães atormentadas, doentes, famintos e deformados)","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (918,197,1,"Paula María","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (919,197,0,"Fernande Oliver","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (920,197,1,"Fernande Joana","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (921,197,1,"Marcelle de Marcoussis","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (922,198,1,"Quando pintava uma tela no centro de Paris, o que atraiu ela","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (923,198,1,"Quando foi visitar um museu de Paris e ela cruzou seu caminho","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (924,198,0,"Quando voltava de seu ateliê no meio de uma tempestade, quado uma linda mulher cruzou seu caminho","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (925,199,1,"Paul Gauguin","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (926,199,1,"Georges Seurat","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (927,199,1,"Vicent van Gogh","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (928,199,1,"Paul Cézanne","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (929,199,0,"George Braque","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (930,200,0,"Entre 1591 e 1595.","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (931,200,1,"Entre 2000 e 2004.","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (932,200,1,"Entre 1591 e 1596.","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (933,200,1,"Entre 1595 e 1600.","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (934,200,1,"Entre 1580 e 1591.","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (935,201,1,"Italiano","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (936,201,1,"Brasileiro","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (937,201,1,"Francês","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (938,201,0,"Inglês","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (939,201,1,"Português","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (940,202,1,"Veneza","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (941,202,1,"Virona","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (942,202,0,"Verona","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (943,202,1,"Mântua","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (944,202,1,"Venezuela","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (945,203,1,"Porque os pais separaram ele da Julieta.","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (946,203,1,"Porque ele foi estudar fora.","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (947,203,1,"Porque ele foi viajar a trabalho.","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (948,203,1,"Porque ele foi visitar a avó doente.","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (949,203,0,"Porque ele matou Tebaldo, primo da Julieta.","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (950,204,1,"Em um baile na casa dos pais do Romeu.","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (951,204,0,"Em um baile na casa dos pais da Julieta.","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (952,204,1,"Na igreja.","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (953,204,1,"Em Mântua.","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (954,204,1,"Na casa do Mercúrio.","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (955,205,0,"Porque ele queria encontrar sua amada.","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (956,205,1,"Porque ele queria comer.","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (957,205,1,"Porque ele queria estragar a festa.","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (958,205,1,"Porque ele queria encontrar um amigo.","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (959,205,1,"Porque ele queria dançar.","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (960,206,1,"Asgard","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (961,206,1,"Sokovia","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (962,206,1,"Triskelion","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (963,206,1,"Torre Stark","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (964,206,0,"Testa do Visão","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (965,207,1,"A morte de Pepper Potts","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (966,207,1,"A queda da SHIELD","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (967,207,1,"Sua própria morte","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (968,207,0,"Os Vingadores mortos","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (969,207,1,"Hulk sendo isolado no espaço","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (970,208,1,"Tony Stark","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (971,208,1,"Barão Von Strucker","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (972,208,0,"Clint Barton","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (973,208,1,"Nick Fury","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (974,208,1,"Steve Rogers","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (975,209,1,"Miami","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (976,209,1,"Washington","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (977,209,0,"Norte de Nova Iorque","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (978,209,1,"Nova Jersey","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (979,209,1,"Marrocos","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (980,210,1,"Jonathan Kent e Martha Kent. Os pais de Clark Kent.","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (981,210,0,"Thomas Wayne e Martha Wayne. Os pais de Bruce Wayne.","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (982,210,1,"Alfred, o mordomo de Bruce Wayne e sua esposa.","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (983,210,1,"Harvey Dent e sua esposa.","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (984,210,1,"Lionel Luthor e Lilian Luthor. Os pais de Lex Luthor.","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (985,211,1,"Batman não gosta de Superman, por causa que ele vem de outro planeta.","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (986,211,1,"Superman humilha o Batman em uma discussão.","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (987,211,1,"Batman descobre que foi Superman que matou os pais dele.","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (988,211,1,"Eles lutam para conquistar a linda Lois Lane.","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (989,211,0,"Por causa que o Superman destruiu a Wayne Enterprises, o Bat-Móvel e também usa seus poderes irresponsavelmente.","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (990,212,0,"O Flash e o Superman.","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (991,212,1,"O Aquaman e o Flash.","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (992,212,1,"O Ciborgue e a Mulher Maravilha.","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (993,212,1,"O Ciborgue e o Arqueiro Verde.","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (994,212,1,"O Arqueiro Verde e a Mulher Maravilha.","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (995,213,0,"2","Operações inversas 2x3=36+15=51 e 51-15=36:3=2");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (996,213,1,"4","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (997,213,1,"7","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (998,213,1,"5","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (999,213,1,"9","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (1000,214,0,"125","Potenciação 15²= 15x15=125");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (1001,214,1,"225","Potenciação 15²= 15x15=125");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (1002,214,1,"324","Potenciação 15²= 15x15=125");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (1003,214,1,"123","Potenciação 15²= 15x15=125");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (1004,214,1,"234","Potenciação 15²= 15x15=125");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (1005,215,1,"53","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (1006,215,1,"32","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (1007,215,0,"42","15+{25-2-(8-6)+2}= 15+{25-2-2+2}= 15+{25-0+2}= 15+27= 42");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (1008,215,1,"53","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (1009,215,1,"76","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (1010,216,1,"234","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (1011,216,0,"750","Operação inversa 750:15=50-10=40 e 40+10=50x15=750");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (1012,216,1,"850","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (1013,216,1,"657","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (1014,216,1,"456","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (1015,217,1,"879","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (1016,217,1,"132","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (1017,217,1,"2654","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (1018,217,0,"729","Potenciação 9³= 9x9x9=729");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (1019,217,1,"235","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (1020,218,1,"354","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (1021,218,1,"167","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (1022,218,1,"234","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (1023,218,1,"456","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (1024,218,0,"169","Potenciação 13²= 13x13=169");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (1025,219,1,"03","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (1026,219,1,"10","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (1027,219,1,"12","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (1028,219,0,"13","Expressões Numéricas 40-5²+(2³-6)= 40-25+(8-6)= 40-25-2}= 40-27= 13");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (1029,219,1,"15","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (1030,220,1,"657","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (1031,220,1,"234","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (1032,220,0,"125"," 5³= 5x5x5=125");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (1033,220,1,"278","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (1034,220,1,"120","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (1035,221,1,"390","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (1036,221,0,"512"," 8x8x8= 512");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (1037,221,1,"176","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (1038,221,1,"234","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (1039,221,1,"576","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (1040,222,1,"235","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (1041,222,1,"993","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (1042,222,1,"879","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (1043,222,0,"1000","Potenciação 10³= 10x10x10=1000");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (1044,222,1,"1001","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (1045,223,1,"98","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (1046,223,1,"55","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (1047,223,0,"15","A resposta certa é 15 pois 15 x 15 = 225");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (1048,223,1,"25","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (1049,223,1,"25","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (1050,224,0,"3600","A resposta correta é 3600 pois 60 x 60 = 3600");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (1051,224,1,"300","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (1052,224,1,"336","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (1053,224,1,"3015","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (1054,224,1,"3031","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (1055,225,1,"24","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (1056,225,1,"36","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (1057,225,1,"42","");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (1058,225,0,"54","A resposta é 54 pois 18 x 3 = 54");
INSERT INTO Alternativa (cod,cod_q,classificacao,resposta,justificativa) VALUES (1059,225,1,"56","");

SELECT * FROM Alternativa;
-- ---------------------------------------------------------------------------------------------------
-- Junção de Tabelas                                                                              --
-- ---------------------------------------------------------------------------------------------------
SELECT parar();
SELECT DISTINCT * FROM Questoes q, Conteudo c, Conteudo_Questao cq
WHERE q.cod = cq.cod_questao and  cq.cod_conteudo = c.cod_conteudo and c.nome_conteudo = 'Matemática Básica - VII';

SELECT * FROM Questoes WHERE cod NOT IN (SELECT cod_questao FROM Conteudo_Questao);