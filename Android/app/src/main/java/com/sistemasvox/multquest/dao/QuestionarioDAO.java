package com.sistemasvox.multquest.dao;

import android.content.ContentValues;
import android.content.Context;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;

import com.sistemasvox.multquest.model.Alternativa;
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

    public String getConsultarProgressoQuestionario(String codP) {
        String total = "0";
        open();
        c = db.rawQuery("SELECT DISTINCT COUNT(*) FROM Progresso p, Questionario q \r\n" +
                "WHERE p.id = q.cod_p and p.id = '" + codP + "';", null);
        while (c.moveToNext()) {
            total = c.getString(0);
        }
        close();
        return total;
    }

    public void salvarQuestionario(Progresso progresso, Questoes questao, Alternativa alternativa) {
        open();
        ContentValues dados = new ContentValues();
        dados.put("cod_p", progresso.getId());
        dados.put("cod_q", questao.getCod());
        dados.put("cod_a", alternativa.getCod());
        db.insert("Questoes", null, dados);
        close();
    }
}