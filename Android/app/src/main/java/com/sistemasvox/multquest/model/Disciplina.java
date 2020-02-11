package com.sistemasvox.multquest.model;

public class Disciplina {
    private String cod, nome, cod_area;

    public Disciplina() {
        super();
    }

    public Disciplina(String cod, String nome, String cod_area) {
        super();
        this.cod = cod;
        this.nome = nome;
        this.cod_area = cod_area;
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

    public String getCod_area() {
        return cod_area;
    }

    public void setCod_area(String cod_area) {
        this.cod_area = cod_area;
    }

    @Override
    public String toString() {
        return "Disciplina{" +
                "cod='" + cod + '\'' +
                ", nome='" + nome + '\'' +
                ", cod_area='" + cod_area + '\'' +
                '}';
    }
}
