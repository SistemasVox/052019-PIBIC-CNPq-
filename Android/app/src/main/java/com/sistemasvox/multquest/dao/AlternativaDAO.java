package com.sistemasvox.multquest.dao;

import android.content.ContentValues;
import android.content.Context;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;

import com.sistemasvox.multquest.model.Alternativa;

import java.util.ArrayList;

public class AlternativaDAO {

    private static DataBaseOpenHelper instance;
    Cursor c = null;
    private SQLiteOpenHelper openHelper;
    private SQLiteDatabase db;

    public AlternativaDAO(Context context) {
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

    public String getTotalAlternativas() {
        String total = "";
        open();
        c = db.rawQuery("SELECT COUNT(*) FROM Alternativa;", null);
        while (c.moveToNext()) {
            total = c.getString(0);
        }
        close();
        return total;
    }

    public Alternativa getAlternativa(String id) {
        String total = "";
        open();
        c = db.rawQuery("SELECT * FROM Alternativa WHERE cod = '" + id + "' ; ", null);
        while (c.moveToNext()) {
            return new Alternativa(c.getString(c.getColumnIndex("cod")),
                    c.getString(c.getColumnIndex("cod_q")),
                    c.getString(c.getColumnIndex("classificacao")),
                    c.getString(c.getColumnIndex("resposta")),
                    c.getString(c.getColumnIndex("justificativa")));
        }
        close();
        return null;
    }

    public ArrayList<Alternativa> getAlternativas(String id) {
        ArrayList<Alternativa> alternativas = new ArrayList<Alternativa>();
        open();
        c = db.rawQuery("SELECT * FROM Alternativa WHERE cod_q = '" + id + "' ; ", null);
        while (c.moveToNext()) {
            alternativas.add(new Alternativa(c.getString(c.getColumnIndex("cod")),
                    c.getString(c.getColumnIndex("cod_q")),
                    c.getString(c.getColumnIndex("classificacao")),
                    c.getString(c.getColumnIndex("resposta")),
                    c.getString(c.getColumnIndex("justificativa"))));
        }
        close();
        return alternativas;
    }

    public void salvarAlternativa(Alternativa alternativa) {
        open();
        ContentValues dados = new ContentValues();
        dados.put("cod", alternativa.getCod());
        dados.put("cod_q", alternativa.getCod_q());
        dados.put("classificacao", alternativa.getClassificacao());
        dados.put("resposta", alternativa.getResposta());
        dados.put("justificativa", alternativa.getJustificativa());
        db.insert("Alternativa", null, dados);
        close();
    }
}
