package com.sistemasvox.multquest.Tools;

import android.content.Context;
import android.graphics.drawable.Drawable;
import android.util.Log;

import com.sistemasvox.multquest.model.Disciplina;

import java.lang.reflect.Field;
import java.util.ArrayList;

public class Utilidades {
    public static final String TAG = "raiva";

    public static ArrayList<Drawable> getIC(Context context, String ic) {
        Field[] drawablesFields = com.sistemasvox.multquest.R.drawable.class.getFields();
        ArrayList<Drawable> drawables = new ArrayList<>();
        for (Field field : drawablesFields) {
            try {
                if (field.getName().contains(ic)) {
                    Log.i(Utilidades.TAG, "com.your.project.R.drawable.: " + field.getName());
                    drawables.add(context.getResources().getDrawable(field.getInt(null)));
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return drawables;
    }

    public static boolean disciplinaDiferente(ArrayList<Disciplina> disciplinas, String nomeDiscQuestao) {
        for (int i = 0; i < disciplinas.size(); i++) {
            if (disciplinas.get(i).getNome().equals(nomeDiscQuestao)) {
                return true;
            }
        }
        return false;
    }

    public static String getAproveitamento(String valor) {
        if (Integer.parseInt(valor) < 40) {
            return "40";
        } else if (valor.equals("100")) {
            return "100";
        } else {
            for (int i = 5; i <= 9; i++) {
                if (valor.substring(0, 1).equals(String.valueOf(i))) {
                    return i + "0";
                }
            }
        }
        return "40";
    }
}