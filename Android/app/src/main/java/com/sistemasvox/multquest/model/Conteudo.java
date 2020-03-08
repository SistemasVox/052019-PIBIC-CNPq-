package com.sistemasvox.multquest.model;

public class Conteudo {
    private String cod, nome, desc;

    public Conteudo() {
        super();
    }

    public Conteudo(String cod, String nome, String desc) {
        super();
        this.cod = cod;
        this.nome = nome;
        this.desc = desc;
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

    public String getDesc() {
        return desc;
    }

    public void setDesc(String desc) {
        this.desc = desc;
    }

    @Override
    public String toString() {
        return this.nome;
    }
}
