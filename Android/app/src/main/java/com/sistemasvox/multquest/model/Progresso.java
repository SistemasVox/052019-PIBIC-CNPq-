package com.sistemasvox.multquest.model;

public class Progresso {
    private String id, tempo_total, tempo_realizacao, data_time;

    public Progresso(String id, String tempo_total, String tempo_realizacao, String data_time) {
        this.id = id;
        this.tempo_total = tempo_total;
        this.tempo_realizacao = tempo_realizacao;
        this.data_time = data_time;
    }

    public String getId() {
        return id;
    }

    public String getTempo_total() {
        return tempo_total;
    }

    public String getTempo_realizacao() {
        return tempo_realizacao;
    }

    public String getData_time() {
        return data_time;
    }
}
