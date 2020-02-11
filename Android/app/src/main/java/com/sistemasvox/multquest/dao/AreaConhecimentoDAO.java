package com.sistemasvox.multquest.dao;

import android.content.Context;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;

import com.sistemasvox.multquest.model.AreaConhecimento;

import java.util.ArrayList;

public class AreaConhecimentoDAO {
    private static DataBaseOpenHelper instance;
    Cursor c = null;
    private SQLiteOpenHelper openHelper;
    private SQLiteDatabase db;

    public AreaConhecimentoDAO(Context context) {
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

    public ArrayList<AreaConhecimento> getAlternativas() {
        ArrayList<AreaConhecimento> areaConhecimentos = new ArrayList<AreaConhecimento>();
        open();
        c = db.rawQuery("SELECT * FROM [Area_Conhecimento];", null);
        while (c.moveToNext()) {
            areaConhecimentos.add(new AreaConhecimento(c.getString(c.getColumnIndex("cod_area")),
                    c.getString(c.getColumnIndex("nome_area"))));
        }
        close();
        return areaConhecimentos;
    }

}
