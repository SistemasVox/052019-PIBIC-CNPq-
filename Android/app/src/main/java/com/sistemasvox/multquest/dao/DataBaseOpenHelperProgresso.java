package com.sistemasvox.multquest.dao;


import android.content.Context;

import com.readystatesoftware.sqliteasset.SQLiteAssetHelper;

public class DataBaseOpenHelperProgresso extends SQLiteAssetHelper {

    private static final String DATABASE_NAME = "progresso.db";
    private static final int DATABASE_VERSION = 1;

    public DataBaseOpenHelperProgresso(Context context) {
        super(context, DATABASE_NAME, null, DATABASE_VERSION);
    }
}