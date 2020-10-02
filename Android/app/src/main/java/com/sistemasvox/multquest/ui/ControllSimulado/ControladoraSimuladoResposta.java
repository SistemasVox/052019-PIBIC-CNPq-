package com.sistemasvox.multquest.ui.ControllSimulado;

import android.content.Intent;
import android.content.res.Resources;
import android.os.Build;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.RadioButton;
import android.widget.RadioGroup;
import android.widget.TextView;
import android.widget.Toast;

import androidx.annotation.RequiresApi;
import androidx.appcompat.app.AppCompatActivity;

import com.sistemasvox.multquest.R;
import com.sistemasvox.multquest.dao.AlternativaDAO;
import com.sistemasvox.multquest.dao.QuestaoDAO;
import com.sistemasvox.multquest.model.Alternativa;
import com.sistemasvox.multquest.model.Questionario;
import com.sistemasvox.multquest.model.Questoes;

import java.util.ArrayList;

public class ControladoraSimuladoResposta extends AppCompatActivity {

    private TextView txtRel, txtDisc, txtEnun, txtResposta;
    private RadioGroup rdGrupo;
    private RadioButton radioButton;
    private Button voltar, finalizar, proximo;
    private ArrayList<Alternativa> alternativas = new ArrayList<>();
    private ImageView imageView;
    private ArrayList<Questoes> questoes;
    private ArrayList<Questionario> questionario;
    private int posicao = 0;
    private String questaoSelecionada;
    private String alternativaSelecionada;
    private String nQuest = "";


    @RequiresApi(api = Build.VERSION_CODES.JELLY_BEAN)
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_teste_home);
        pegarOutraClasse();
        instaciarComponentes();
        removerComponentes();
        construirQuestao(questionario.get(0).getQuestao());
        responderResposta();
    }

    @RequiresApi(api = Build.VERSION_CODES.JELLY_BEAN)
    private void responderResposta() {
        Alternativa alternativa;
        if (!alternativaSelecionada.equals("0")) {
            alternativa = new AlternativaDAO(this).getAlternativa(alternativaSelecionada);
        } else {
            alternativa = new Alternativa("", "", "", "", "você deixou em branco");
        }
        String resposta = "";
        if (alternativa.getClassificacao().equals("0")) {
            resposta = "Está correto! A alternativa correta é: " + alternativa.getResposta() + ".\nPorque: " + alternativa.getJustificativa();
            txtResposta.setText(resposta);
        } else {
            resposta = "Está incorreto. " + alternativa.getResposta() + ".\nPorque: " + alternativa.getJustificativa();
            txtResposta.setText(resposta);
            txtResposta.setBackgroundColor(this.getResources().getColor(R.color.errado));
        }


        for (int i = 0; i < rdGrupo.getChildCount(); i++) {
            RadioButton radioButton = (RadioButton) rdGrupo.getChildAt(i);
            if (radioButton.getText().toString().equals(alternativa.getResposta())) {
                ((RadioButton) rdGrupo.getChildAt(i)).setChecked(true);
                rdGrupo.getChildAt(i).setBackgroundColor(this.getResources().getColor(R.color.cinza));
            } else {
                rdGrupo.getChildAt(i).setEnabled(false);
            }
        }

    }


    private void pegarOutraClasse() {
        Intent intent = getIntent();
        //Bundle extra = getIntent().getBundleExtra("extra");
        try {
            questaoSelecionada = intent.getStringExtra("questaoSelecionada");
            alternativaSelecionada = intent.getStringExtra("alternativaSelecionada");
            nQuest = intent.getStringExtra("nQuest");
            //Log.i("raiva", questaoSelecionada.toString() + "");
            //Log.i("raiva", alternativaSelecionada.toString() + "");
        } catch (Exception ex) {
            ex.printStackTrace();
            Log.i("raiva", ex.getMessage() + "");
        }

        //Log.i("raiva", conteudosSelecionados.toString() + "");
    }

    @RequiresApi(api = Build.VERSION_CODES.JELLY_BEAN_MR1)
    private void construirQuestao(Questoes questao) {

        txtEnun.setText(nQuest + ") " + questao.getEnunciado());
        txtDisc.setText(new QuestaoDAO(getApplicationContext()).getNomeDiscQuestao(questao.getCod()));


        String name = "ic_" + txtDisc.getText().toString().toLowerCase().replaceAll("[^\\p{ASCII}]", "");
        Resources res = getResources();
        int id = res.getIdentifier(name, "drawable", getPackageName());
        imageView.setImageResource(id);

        //alternativas.clear();
        //alternativas = desordernarAlternativas(new AlternativaDAO(getApplicationContext()).getAlternativas(questao.getCod()));
        alternativas = questionario.get(posicao).getAlternativas();

        //Log.i("raiva", alternativas.toString());

        rdGrupo.removeAllViews();

        for (int i = 0; i < alternativas.size(); i++) {
            try {
                RadioButton rb_flash = clonarBotao(radioButton);
                rb_flash.setText(alternativas.get(i).getResposta());
                rdGrupo.addView(rb_flash);
            } catch (Exception e) {
                Log.i("raiva", e.getMessage());
            }
        }
        if (questionario.get(posicao).getResposta() != -1) {
            ((RadioButton) rdGrupo.getChildAt(questionario.get(posicao).getResposta())).setChecked(true);
            Log.i("raiva", questionario.get(posicao).getResposta() + "");
        }

    }


    private void mensagem(String s) {
        Toast.makeText(this, s, Toast.LENGTH_LONG).show();
    }


    @RequiresApi(api = Build.VERSION_CODES.JELLY_BEAN)
    private void instaciarComponentes() {
        txtRel = findViewById(R.id.txtTempo);
        txtDisc = findViewById(R.id.txtDisciplina);
        txtEnun = findViewById(R.id.txtEnunciado);
        imageView = findViewById(R.id.imgDisci);

        txtResposta = findViewById(R.id.txtResposta);

        rdGrupo = findViewById(R.id.grupoRadio);
        radioButton = clonarBotao((RadioButton) rdGrupo.getChildAt(0));
        voltar = findViewById(R.id.btnVoltar1);
        finalizar = findViewById(R.id.btnFinalizar1);
        proximo = findViewById(R.id.btnAvancar1);

        questoes = new ArrayList<>();
        questoes.add(new QuestaoDAO(this).getQuestao(questaoSelecionada));
        //Log.i("raiva", questoes.toString() + "");
        questionario = new ArrayList<>();
        questionario.add(new Questionario(questoes.get(0), new AlternativaDAO(this).getAlternativas(questoes.get(0).getCod())));

    }

    private void removerComponentes() {
        TextView tempo = findViewById(R.id.txtTempo);
        tempo.setVisibility(View.INVISIBLE);
        voltar.setVisibility(View.INVISIBLE);
        finalizar.setVisibility(View.INVISIBLE);
        proximo.setVisibility(View.INVISIBLE);
    }

    @RequiresApi(api = Build.VERSION_CODES.JELLY_BEAN)
    private RadioButton clonarBotao(RadioButton childAt) {
        RadioButton cloneButton = new RadioButton(getApplicationContext());
        cloneButton.setLayoutParams(childAt.getLayoutParams());
        cloneButton.setTextSize(childAt.getTextSize() / 3);
        cloneButton.setTextColor(childAt.getCurrentTextColor());
        cloneButton.setTypeface(childAt.getTypeface());
        cloneButton.setBackground(childAt.getBackground());
        return cloneButton;
    }

    public String zero(Long l) {
        if (l < 10) {
            return "0" + l;
        } else {
            return String.valueOf(l);
        }
    }
}
