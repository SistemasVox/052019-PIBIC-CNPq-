package com.sistemasvox.multquest.model;

public class QuestionarioProgresso {
    private String cod_p, cod_q, cod_a;

    public QuestionarioProgresso(String cod_p, String cod_q, String cod_a) {
        this.cod_p = cod_p;
        this.cod_q = cod_q;
        this.cod_a = cod_a;
    }

    public String getCod_p() {
        return cod_p;
    }

    public String getCod_q() {
        return cod_q;
    }

    public String getCod_a() {
        return cod_a;
    }

    @Override
    public String toString() {
        return "QuestionarioProgresso{" +
                "cod_p= '" + cod_p + '\'' +
                ", cod_q= '" + cod_q + '\'' +
                ", cod_a= '" + cod_a + '\'' +
                '}';
    }
}
