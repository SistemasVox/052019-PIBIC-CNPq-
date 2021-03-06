package com.sistemasvox.multquest.model;

import android.content.Context;
import android.content.res.Resources;
import android.os.Build;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.ImageView;
import android.widget.ProgressBar;
import android.widget.TextView;

import com.sistemasvox.multquest.R;
import com.sistemasvox.multquest.Tools.Utilidades;
import com.sistemasvox.multquest.dao.AlternativaDAO;
import com.sistemasvox.multquest.dao.DisciplinaDAO;
import com.sistemasvox.multquest.dao.QuestaoDAO;
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
        ArrayList<Disciplina> disciplinas = new ArrayList<>();
        int acertos = 0;
        for (int i = 0; i < questionarioProgressos.size(); i++) {
            if (!questionarioProgressos.get(i).getCod_a().equals("0")) {
                if (new AlternativaDAO(context).getAlternativa(questionarioProgressos.get(i).getCod_a()).getClassificacao().equals("0")) {
                    acertos++;
                }
            }
            if (!Utilidades.disciplinaDiferente(disciplinas, new QuestaoDAO(context).getNomeDiscQuestao(questionarioProgressos.get(i).getCod_q()))) {
                disciplinas.add(new DisciplinaDAO(context).getDisciplinaQuestao(questionarioProgressos.get(i).getCod_q()));
            }
        }
        Log.i("raiva", disciplinas.size() + " CD");
        textViewPts.setText("Pontos: " + acertos + "/" + questionarioProgressos.size() + ".");
        try {
            if (disciplinas.size() == 1) {
                Log.i("raiva", disciplinas.toString());
                String name = "ic_" + disciplinas.get(0).getNome().toLowerCase().replaceAll("[^\\p{ASCII}]", "");
                Resources res = context.getResources();
                int id = res.getIdentifier(name, "drawable", context.getPackageName());
                ImageView imageView = linha.findViewById(R.id.imgDiscSR);
                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
                    imageView.setBackground(context.getDrawable(id));
                } else {
                    imageView.setImageResource(id);
                }
            }
        } catch (Exception e) {
            Log.e(Utilidades.TAG, e.getMessage());
        }
        //Log.i("raiva", new AlternativaDAO(context).getAlternativa(questionarioProgressos.get(i).getCod_a()).getResposta());
        ImageView aprovado = linha.findViewById(R.id.imgAPRE);
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.JELLY_BEAN) {
            aprovado.setBackground(Utilidades.getIC(context, "ic_aprovado_" + Utilidades.getAproveitamento(String.valueOf((acertos * 100) / questionarioProgressos.size()))).get(0));
        }
        ProgressBar process = linha.findViewById(R.id.progress_sr);
        process.setProgress((acertos * 100) / questionarioProgressos.size());


        return linha;
    }
}
