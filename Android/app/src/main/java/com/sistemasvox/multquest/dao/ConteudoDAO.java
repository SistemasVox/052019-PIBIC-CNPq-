package com.sistemasvox.multquest.dao;

import android.content.ContentValues;
import android.content.Context;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;

import com.sistemasvox.multquest.model.Conteudo;

import java.util.ArrayList;

public class ConteudoDAO {
    private static DataBaseOpenHelper instance;
    Cursor c = null;
    private SQLiteOpenHelper openHelper;
    private SQLiteDatabase db;

    public ConteudoDAO(Context context) {
        this.openHelper = new DataBaseOpenHelper(context);
    }

    public static DataBaseOpenHelper getInstance(Context context) {
        if (instance == null) {
            instance = new DataBaseOpenHelper(context);
        }
        return instance;
    }

    public void open() {
        this.db = openHelper.getWritableDatabase();
    }

    public void close() {
        if (db != null) {
            this.db.close();
        }
    }

    public String getTotalConteudo() {
        String total = "";
        open();
        c = db.rawQuery("SELECT COUNT(*) FROM Conteudo;", null);
        while (c.moveToNext()) {
            total = c.getString(0);
        }
        close();
        return total;
    }

    public ArrayList<Conteudo> getConteudosDisc(String nomeDisc) {
        ArrayList<Conteudo> conteudos = new ArrayList<Conteudo>();
        open();
        c = db.rawQuery("SELECT * FROM Conteudo c, Disciplina_Conteudo dc where dc.cod_disciplina = (SELECT cod_disciplina FROM Disciplina WHERE nome_disciplina = '"
                + nomeDisc + "') and c.cod_conteudo = dc.cod_conteudo;", null);
        while (c.moveToNext()) {
            conteudos.add(new Conteudo(c.getString(c.getColumnIndex("cod_conteudo")),
                    c.getString(c.getColumnIndex("nome_conteudo")),
                    c.getString(c.getColumnIndex("descricao_conteudo"))));
        }
        close();
        return conteudos;
    }

    public ArrayList<Conteudo> getConteudosNome(String nomeConte) {
        ArrayList<Conteudo> conteudos = new ArrayList<Conteudo>();
        open();
        c = db.rawQuery("SELECT * FROM Conteudo WHERE nome_conteudo like '%" + nomeConte + "%';", null);
        while (c.moveToNext()) {
            conteudos.add(new Conteudo(c.getString(c.getColumnIndex("cod_conteudo")),
                    c.getString(c.getColumnIndex("nome_conteudo")),
                    c.getString(c.getColumnIndex("descricao_conteudo"))));
        }
        close();
        return conteudos;
    }

    public boolean consultarConteudoExiste(String nomeConte) {
        boolean achou = false;
        open();
        c = db.rawQuery("SELECT COUNT(*) FROM Conteudo WHERE nome_conteudo = '" + nomeConte + "';", null);
        while (c.moveToNext()) {
            if (Integer.parseInt(c.getString(0)) != 0) {
                achou = true;
            }
        }
        close();
        return achou;
    }

    public void salvarConteudo(String nome, String desc, String cod, String serie) {
        open();
        ContentValues dados = new ContentValues();
        dados.put("nome_conteudo", nome);
        dados.put("descricao_conteudo", desc);
        db.insert("Conteudo", null, dados);

        dados.clear();

        dados.put("serie", serie);
        dados.put("cod_conteudo", getConteudosNome(nome).get(0).getCod());
        dados.put("cod_disciplina", cod);
        db.insert("Disciplina_Conteudo", null, dados);
        close();
    }

    public void excluirConteudo(String cod) {
        open();
        db.execSQL("DELETE FROM Disciplina_Conteudo WHERE cod_conteudo = '" + cod + "';");
        db.execSQL("DELETE FROM Conteudo WHERE cod_conteudo = '" + cod + "';");
        close();
    }
}
