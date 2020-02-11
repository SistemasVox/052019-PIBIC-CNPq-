package com.sistemasvox.multquest.model;

public class AreaConhecimento {
    private String cod, nome;

    public AreaConhecimento() {
        super();
    }

    public AreaConhecimento(String cod, String nome) {
        super();
        this.cod = cod;
        this.nome = nome;
    }

    public String getCod() {
        return cod;
    }

    public void setCod(String cod) {
        this.cod = cod;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    @Override
    public String toString() {
        return "Area_Conhecimento [cod=" + cod + ", nome=" + nome + "]";
    }
}
