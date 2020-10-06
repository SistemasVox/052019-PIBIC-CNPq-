package com.sistemasvox.multquest.model;

public class Gabarito {
    private String Questao, Alternativa;

    public Gabarito(String questao) {
        super();
        Questao = questao;
    }

    public String getQuestao() {
        return Questao;
    }

    public void setQuestao(String questao) {
        Questao = questao;
    }

    public String getAlternativa() {
        return Alternativa;
    }

    public void setAlternativa(String alternativa) {
        Alternativa = alternativa;
    }
}
