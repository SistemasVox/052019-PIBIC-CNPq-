package com.sistemasvox.multquest.dao;

import android.content.ContentValues;
import android.content.Context;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;

import com.sistemasvox.multquest.model.Questoes;

import java.util.ArrayList;

public class QuestaoDAO {
    Cursor c = null;
    private SQLiteOpenHelper openHelper;
    private SQLiteDatabase db;

    public QuestaoDAO(Context context) {
        this.openHelper = new DataBaseOpenHelper(context);
    }

    public void open() {
        this.db = openHelper.getWritableDatabase();
    }

    public void close() {
        if (db != null) {
            this.db.close();
        }
    }

    public String getTotalQuestoes() {
        String total = "";
        open();
        c = db.rawQuery("SELECT COUNT(*) FROM Questoes;", null);
        while (c.moveToNext()) {
            total = c.getString(0);
        }
        close();
        return total;
    }

    public String getTotalQuestaoConteudo(String nomeConteudo) {
        String total = "";
        open();
        c = db.rawQuery("SELECT DISTINCT COUNT(*) FROM Questoes q, Conteudo c, Conteudo_Questao cq " + " WHERE q.cod = cq.cod_questao and cq.cod_conteudo = c.cod_conteudo and c.nome_conteudo = '" + nomeConteudo + "';", null);
        while (c.moveToNext()) {
            total = c.getString(0);
        }
        close();
        return total;
    }

    public ArrayList<Questoes> getQuestoesConteudo(String nomeConteudo) {
        ArrayList<Questoes> temp = new ArrayList<>();
        open();
        c = db.rawQuery("SELECT DISTINCT * FROM Questoes q, Conteudo c, Conteudo_Questao cq" + " WHERE q.cod = cq.cod_questao and cq.cod_conteudo = c.cod_conteudo and c.nome_conteudo = '" + nomeConteudo + "';", null);
        while (c.moveToNext()) {
            temp.add(new Questoes(c.getString(c.getColumnIndex("cod")), c.getString(c.getColumnIndex("enunciado")), c.getString(c.getColumnIndex("dificuldade")), c.getString(c.getColumnIndex("referencia"))));
        }
        close();
        return temp;
    }

    public ArrayList<Questoes> getQuestoesSemAssociacao() {
        ArrayList<Questoes> temp = new ArrayList<>();
        open();
        c = db.rawQuery("SELECT * FROM [Questoes] WHERE [cod] NOT IN (SELECT [cod_questao] FROM [Conteudo_Questao]);", null);
        while (c.moveToNext()) {
            temp.add(new Questoes(c.getString(c.getColumnIndex("cod")), c.getString(c.getColumnIndex("enunciado")), c.getString(c.getColumnIndex("dificuldade")), c.getString(c.getColumnIndex("referencia"))));
        }
        close();
        return temp;
    }

    public Questoes getQuestao(String id) {
        open();
        c = db.rawQuery("SELECT * FROM Questoes WHERE cod = '" + id + "' ; ", new String[]{});
        while (c.moveToNext()) {
            return new Questoes(c.getString(c.getColumnIndex("cod")), c.getString(c.getColumnIndex("enunciado")), c.getString(c.getColumnIndex("dificuldade")), c.getString(c.getColumnIndex("referencia")));
        }
        close();
        return null;
    }

    public String getConsultarQuestaoConteudo(String codQ, String codC) {
        String total = "";
        open();
        c = db.rawQuery("SELECT DISTINCT COUNT(*) FROM Questoes q, Conteudo c, Conteudo_Questao cq" + " WHERE q.cod = cq.cod_questao and cq.cod_conteudo = c.cod_conteudo and c.cod_conteudo = '" + codC + "' and q.cod = '" + codQ + "';", null);
        while (c.moveToNext()) {
            total = c.getString(0);
        }
        close();
        return total;
    }

    public void salvarQuestao(Questoes questao) {
        open();
        ContentValues dados = new ContentValues();
        dados.put("cod", questao.getCod());
        dados.put("enunciado", questao.getEnunciado());
        dados.put("dificuldade", questao.getDificuldade());
        dados.put("referencia", questao.getReferencia());
        db.insert("Questoes", null, dados);
        close();
    }

    public void associarQuestaoConteudo(String codQ, String codC) {
        open();
        ContentValues dados = new ContentValues();
        dados.put("cod_conteudo", codC);
        dados.put("cod_questao", codQ);
        db.insert("Conteudo_Questao", null, dados);
        close();
    }

    public String getNomeDiscQuestao(String idQ) {
        String nome = "";
        open();
        c = db.rawQuery("SELECT nome_disciplina FROM Disciplina d, Disciplina_Conteudo dc, Conteudo_Questao cq WHERE" + " d.cod_disciplina = dc.cod_disciplina AND dc.cod_conteudo = cq.cod_conteudo AND cq.cod_questao = '" + idQ + "';", null);
        while (c.moveToNext()) {
            nome = c.getString(0);
        }
        close();
        return nome;
    }
}