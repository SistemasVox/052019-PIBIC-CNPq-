package com.sistemasvox.multquest.dao;

import android.content.ContentValues;
import android.content.Context;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.util.Log;

import com.sistemasvox.multquest.model.Progresso;
import com.sistemasvox.multquest.model.QuestionarioProgresso;

import java.util.ArrayList;

public class QuestionarioDAO {
    private static DataBaseOpenHelperProgresso instance;
    Cursor c = null;
    private DataBaseOpenHelperProgresso openHelper;
    private SQLiteDatabase db;

    public QuestionarioDAO(Context context) {
        this.openHelper = new DataBaseOpenHelperProgresso(context);
    }

    public static DataBaseOpenHelperProgresso getInstance(Context context) {
        if (instance == null) {
            instance = new DataBaseOpenHelperProgresso(context);
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
        String total = "";
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

    public ArrayList<Progresso> getQuestionariosProgresso() {
        ArrayList<Progresso> progressos = new ArrayList<>();
        open();
        c = db.rawQuery("SELECT * FROM Progresso;", new String[]{});
        while (c.moveToNext()) {
            progressos.add(new Progresso(c.getString(c.getColumnIndex("id")),
                    c.getString(c.getColumnIndex("tempo_total")),
                    c.getString(c.getColumnIndex("tempo_realizacao")),
                    c.getString(c.getColumnIndex("data_time"))));
        }
        close();
        return progressos;
    }

    public ArrayList<QuestionarioProgresso> getQuestionarios() {
        ArrayList<QuestionarioProgresso> questionarioProgressos = new ArrayList<>();
        open();
        c = db.rawQuery("SELECT * FROM Questionario;", new String[]{});
        while (c.moveToNext()) {
            questionarioProgressos.add(new QuestionarioProgresso(c.getString(c.getColumnIndex("cod_p")),
                    c.getString(c.getColumnIndex("cod_q")),
                    c.getString(c.getColumnIndex("cod_a"))));
        }
        close();
        return questionarioProgressos;
    }

    public ArrayList<QuestionarioProgresso> getConsultarProgressoQuestionario(String codP) {
        ArrayList<QuestionarioProgresso> questionarioProgressos = new ArrayList<>();
        open();
        c = db.rawQuery("SELECT DISTINCT * FROM Progresso p, Questionario q \r\n" +
                " WHERE p.id = q.cod_p and p.id = '" + codP + "';", null);
        while (c.moveToNext()) {
            questionarioProgressos.add(new QuestionarioProgresso(c.getString(c.getColumnIndex("cod_p")),
                    c.getString(c.getColumnIndex("cod_q")),
                    c.getString(c.getColumnIndex("cod_a"))));
        }
        close();
        return questionarioProgressos;
    }

    public String getConsultarTotalProgressoQuestionario(String codP) {
        String total = "0";
        open();
        c = db.rawQuery("SELECT DISTINCT COUNT(*) FROM Progresso p, Questionario q \r\n" +
                " WHERE p.id = q.cod_p and p.id = '" + codP + "';", null);
        while (c.moveToNext()) {
            total = c.getString(0);
        }
        close();
        return total;
    }

    public void salvarProgressoQuestionario(Progresso progresso) {
        open();
        Log.i("raiva", "Veio no insert salvarProgressoQuestionario");
        ContentValues dados = new ContentValues();
        dados.put("id", progresso.getId());
        dados.put("tempo_total", progresso.getTempo_total());
        dados.put("tempo_realizacao", progresso.getTempo_realizacao());
        dados.put("data_time", progresso.getData_time());
        db.insert("Progresso", null, dados);
        //Log.i("raiva", "Sintaxe: " + dados.toString());
        close();
    }

    public void salvarQuestionario(String progresso, String questao, String alternativa) {
        open();
        //Log.i("raiva", "Veio no insert salvarQuestionario");
        ContentValues dados = new ContentValues();
        dados.put("cod_p", progresso);
        dados.put("cod_q", questao);
        dados.put("cod_a", alternativa);
        db.insert("Questionario", null, dados);
        //Log.i("raiva", progresso + questao + alternativa);
        close();
    }
}