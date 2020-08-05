package com.sistemasvox.multquest.model;

import android.content.Context;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.TextView;

import com.sistemasvox.multquest.R;
import com.sistemasvox.multquest.dao.AlternativaDAO;
import com.sistemasvox.multquest.dao.MyApplication;
import com.sistemasvox.multquest.dao.QuestionarioDAO;

import java.util.ArrayList;
import java.util.List;

public class ProgressoAdapter extends BaseAdapter {

    Context context;
    List<Progresso> list;

    public ProgressoAdapter(Context context, List<Progresso> list) {
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
        Progresso progresso = list.get(position);

        //Passo 2 Criar Linha (Lista de Layouts)
        View linha = LayoutInflater.from(context).inflate(R.layout.model_layout_s_realizados, parent, false);

        //Passo 3
        TextView textViewData = linha.findViewById(R.id.txtDataS);
        textViewData.setText(progresso.getData_time().substring(0, 10));

        TextView textViewPts = linha.findViewById(R.id.txtPtsS);

       ArrayList<QuestionarioProgresso> questionarioProgressos = new QuestionarioDAO(context).getConsultarProgressoQuestionario(progresso.getId());
        int c = 0;
        for (int i = 0; i < questionarioProgressos.size(); i++) {
            if (!questionarioProgressos.get(i).getCod_a().equals("0")) {
                if (new AlternativaDAO(context).getAlternativa(questionarioProgressos.get(i).getCod_a()).getClassificacao().equals("0")) {
                    c++;
                }
            }
            //Log.i("raiva", new AlternativaDAO(context).getAlternativa(questionarioProgressos.get(i).getCod_a()).getClassificacao());
        }
        textViewPts.setText("Pontos: " + c + "/" + questionarioProgressos.size() + ".");
        //Log.i("raiva", new AlternativaDAO(context).getAlternativa(questionarioProgressos.get(i).getCod_a()).getResposta());

        return linha;
    }
}
