package com.sistemasvox.multquest.model;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.RadioButton;

import com.sistemasvox.multquest.R;

import java.util.List;

public class RespostaAdapter extends BaseAdapter {

    Context context;
    List<Alternativa> list;

    public RespostaAdapter(Context context, List<Alternativa> list) {
        this.context = context;
        this.list = list;
    }

    @Override
    public int getCount() {
        return list.size();
    }

    @Override
    public Object getItem(int position) {
        return list.get(position);
    }

    @Override
    public long getItemId(int position) {
        return position;
    }

    @Override
    public View getView(int position, View convertView, ViewGroup parent) {
        //Passo 1 Criar Objetos
        Alternativa alternativa = list.get(position);

        //Passo 2 Criar Linha (Lista de Layouts)
        View linha = LayoutInflater.from(context).inflate(R.layout.activity_respostas_radio, parent, false);

        //Passo 3
        RadioButton radioButton = linha.findViewById(R.id.checkBox);

        radioButton.setText(alternativa.getResposta());

        return linha;
    }
}
