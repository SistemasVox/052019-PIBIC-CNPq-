package com.sistemasvox.multquest.dao;

import android.content.Context;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;

import com.sistemasvox.multquest.model.Disciplina;

import java.util.ArrayList;

public class DisciplinaDAO {
    private static DataBaseOpenHelper instance;
    Cursor c = null;
    private SQLiteOpenHelper openHelper;
    private SQLiteDatabase db;

    public DisciplinaDAO(Context context) {
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

    public ArrayList<Disciplina> getAllDisciplinas() {
        ArrayList<Disciplina> disciplinas = new ArrayList<Disciplina>();
        open();
        c = db.rawQuery("SELECT * FROM Disciplina;", null);
        while (c.moveToNext()) {
            disciplinas.add(new Disciplina(c.getString(c.getColumnIndex("cod_disciplina")),
                    c.getString(c.getColumnIndex("nome_disciplina")),
                    c.getString(c.getColumnIndex("cod_area"))));
        }
        close();
        return disciplinas;
    }

    public ArrayList<Disciplina> getAllDisciplinas(String nomeArea) {
        ArrayList<Disciplina> disciplinas = new ArrayList<Disciplina>();
        open();
        c = db.rawQuery("SELECT * FROM Disciplina WHERE cod_area = (SELECT cod_area FROM Area_Conhecimento WHERE nome_area like '" + nomeArea + "');", null);
        while (c.moveToNext()) {
            disciplinas.add(new Disciplina(c.getString(c.getColumnIndex("cod_disciplina")),
                    c.getString(c.getColumnIndex("nome_disciplina")),
                    c.getString(c.getColumnIndex("cod_area"))));
        }
        close();
        return disciplinas;
    }

}
