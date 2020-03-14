package com.sistemasvox.multquest.model;

import java.util.ArrayList;

public class Questionario {
    private Questoes questao;
    private ArrayList<Alternativa> alternativas;
    private int resposta = -1;

    public Questionario(Questoes questao, ArrayList<Alternativa> alternativas) {
        this.questao = questao;
        this.alternativas = alternativas;
    }

    public Questoes getQuestao() {
        return questao;
    }

    public ArrayList<Alternativa> getAlternativas() {
        return alternativas;
    }

    public int getResposta() {
        return resposta;
    }

    public void setResposta(int resposta) {
        this.resposta = resposta;
    }
}
