package com.sistemasvox.multquest.model;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.TextView;

import com.sistemasvox.multquest.R;
import com.sistemasvox.multquest.dao.AlternativaDAO;

import java.util.List;

public class TabelaQuestoesAdapter extends BaseAdapter {

    Context ctx;
    List<QuestionarioProgresso> lista;

    public TabelaQuestoesAdapter(Context ctx, List<QuestionarioProgresso> lista) {
        this.ctx = ctx;
        this.lista = lista;
    }


    @Override
    public int getCount() {
        return lista.size();
    }

    @Override
    public Object getItem(int position) {
        return lista.get(position);
    }

    @Override
    public long getItemId(int position) {
        return position;
    }

    @Override
    public View getView(int position, View convertView, ViewGroup parent) {

        QuestionarioProgresso questionarioProgresso = lista.get(position);
        View linha = LayoutInflater.from(ctx).inflate(R.layout.quest_resul_layout, null);

        TextView titulo = linha.findViewById(R.id.txtQuestOps);
        titulo.setText(String.valueOf(position + 1));

        if (!questionarioProgresso.getCod_a().equals("0")) {
            if (new AlternativaDAO(ctx).getAlternativa(questionarioProgresso.getCod_a()).getClassificacao().equals("0")) {
                titulo.setBackgroundColor(ctx.getResources().getColor(R.color.acerto));
            } else {
                titulo.setBackgroundColor(ctx.getResources().getColor(R.color.errado));
            }
        } else {
            titulo.setBackgroundColor(ctx.getResources().getColor(R.color.errado));
        }

        return linha;
    }
}
