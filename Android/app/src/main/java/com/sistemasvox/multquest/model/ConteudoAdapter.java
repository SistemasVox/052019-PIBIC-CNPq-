package com.sistemasvox.multquest.model;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.CheckBox;

import com.sistemasvox.multquest.R;

import java.util.List;

public class ConteudoAdapter extends BaseAdapter {
    Context context;
    List<Conteudo> list;

    public ConteudoAdapter(Context context, List<Conteudo> list) {
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
        Conteudo conteudo = list.get(position);
        View linha = LayoutInflater.from(context).inflate(R.layout.activity_escolha_conteudos, parent, false);
        CheckBox checkBox = linha.findViewById(R.id.checkBox);
        checkBox.setText(conteudo.getNome());
        return linha;
    }
}