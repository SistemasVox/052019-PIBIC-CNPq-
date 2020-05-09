package com.sistemasvox.multquest.dao;

import android.content.ContentValues;
import android.content.Context;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;

import com.sistemasvox.multquest.model.Progresso;
import com.sistemasvox.multquest.model.Questoes;

public class QuestionarioDAO {
    private static DataBaseOpenHelper instance;
    Cursor c = null;
    private SQLiteOpenHelper openHelper;
    private SQLiteDatabase db;

    public QuestionarioDAO(Context context) {
        this.openHelper = new DataBaseOpenHelperProgresso(context);
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

    public String getTotalQuestionario() {
        String total = "0";
        open();
        c = db.rawQuery("SELECT COUNT(*) FROM Progresso;", null);
        while (c.moveToNext()) {
            total = c.getString(0);
        }
        close();
        return total;
    }

    public Progresso getQuestionario(String id) {
        open();
        c = db.rawQuery("SELECT * FROM Progresso WHERE id = '" + id + "' ; ", new String[]{});
        while (c.moveToNext()) {
            return new Progresso(c.getString(c.getColumnIndex("id")),
                    c.getString(c.getColumnIndex("tempo_total")),
                    c.getString(c.getColumnIndex("tempo_realizacao")),
                    c.getString(c.getColumnIndex("data_time")));
        }
        close();
        return null;
    }

    public String getConsultarQuestaoConteudo(String codQ, String codC) {
        String total = "0";
        open();
        c = db.rawQuery("SELECT DISTINCT COUNT(*) FROM Questoes q, Conteudo c, Conteudo_Questao cq\r\n" +
                "WHERE q.cod = cq.cod_questao and  cq.cod_conteudo = c.cod_conteudo and c.cod_conteudo = '" + codC + "' and q.cod = '" + codQ + "';", null);
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
        c = db.rawQuery("SELECT nome_disciplina FROM Disciplina d, Disciplina_Conteudo dc, Conteudo_Questao cq WHERE" +
                " d.cod_disciplina = dc.cod_disciplina AND dc.cod_conteudo = cq.cod_conteudo AND cq.cod_questao = '" + idQ + "';", null);
        while (c.moveToNext()) {
            nome = c.getString(0);
        }
        close();
        return nome;
    }
}