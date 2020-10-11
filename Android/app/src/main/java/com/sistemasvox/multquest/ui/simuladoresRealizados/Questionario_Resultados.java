package com.sistemasvox.multquest.ui.simuladoresRealizados;

import android.content.Intent;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.AdapterView;
import android.widget.GridView;
import android.widget.TextView;

import androidx.appcompat.app.AppCompatActivity;

import com.sistemasvox.multquest.R;
import com.sistemasvox.multquest.dao.QuestionarioDAO;
import com.sistemasvox.multquest.model.Progresso;
import com.sistemasvox.multquest.model.QuestionarioProgresso;
import com.sistemasvox.multquest.model.TabelaQuestoesAdapter;
import com.sistemasvox.multquest.ui.ControllSimulado.ControladoraSimuladoResposta;

import java.util.ArrayList;

public class Questionario_Resultados extends AppCompatActivity {
    private TextView txtQuestTitulo, txtQuestSub;
    private String progressoSelecionado;
    private GridView gridView;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_questionario__resultados);
        instaciarComponentes();
        pegarOutraClasse();
        construirTabela();
    }

    private void construirTabela() {
        Progresso progresso = new QuestionarioDAO(getApplicationContext()).getProgresso(progressoSelecionado);
        ArrayList<QuestionarioProgresso> questionarioProgressos = new QuestionarioDAO(getApplicationContext()).getConsultarProgressoQuestionario(progressoSelecionado);
        txtQuestTitulo.setText(getApplicationContext().getResources().getString(R.string.txtTituloQuestionario) + "\n" + progresso.getData_time());
        txtQuestSub.setText(getApplicationContext().getResources().getString(R.string.txtTituloSub) + " " + progresso.getTempo_realizacao());
        gridView.setAdapter(new TabelaQuestoesAdapter(getApplicationContext(), questionarioProgressos));
        gridView.setOnItemClickListener(new AdapterView.OnItemClickListener() {
            @Override
            public void onItemClick(AdapterView<?> adapterView, View view, int i, long l) {
                QuestionarioProgresso questoes = (QuestionarioProgresso) adapterView.getItemAtPosition(i);
                Intent iq = new Intent(Questionario_Resultados.this, ControladoraSimuladoResposta.class);
                iq.putExtra("questaoSelecionada", questoes.getCod_q());
                iq.putExtra("alternativaSelecionada", questoes.getCod_a());
                iq.putExtra("nQuest", String.valueOf(i + 1));
                startActivity(iq);
            }
        });
    }

    private void pegarOutraClasse() {
        Intent intent = getIntent();
        try {
            progressoSelecionado = intent.getStringExtra("progressoSelecionado");
            Log.i("raiva", progressoSelecionado + "");
        } catch (Exception ex) {
            ex.printStackTrace();
            Log.i("raiva", ex.getMessage() + "");
        }
    }

    private void instaciarComponentes() {
        txtQuestTitulo = findViewById(R.id.txtQuestTitulo);
        txtQuestSub = findViewById(R.id.txtQuestSub);
        gridView = findViewById(R.id.gridView);
    }
}