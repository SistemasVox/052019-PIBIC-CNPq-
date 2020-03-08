package com.sistemasvox.multquest.ui.homeTeste;

import android.content.Intent;
import android.content.res.Resources;
import android.os.Bundle;
import android.os.Handler;
import android.util.Log;
import android.view.View;
import android.widget.ImageView;
import android.widget.RadioButton;
import android.widget.RadioGroup;
import android.widget.TextView;
import android.widget.Toast;

import androidx.appcompat.app.AppCompatActivity;

import com.sistemasvox.multquest.R;
import com.sistemasvox.multquest.dao.AlternativaDAO;
import com.sistemasvox.multquest.dao.QuestaoDAO;
import com.sistemasvox.multquest.model.Alternativa;
import com.sistemasvox.multquest.model.Questoes;

import java.util.ArrayList;
import java.util.Random;

public class TesteHome extends AppCompatActivity {

    long ss = 600;//10min
    private TextView txtRel, txtDisc, txtEnun;
    private RadioGroup rdGrupo;
    private RadioButton a, b, c, d, e;
    private ArrayList<RadioButton> arrayListButtons = new ArrayList<>();
    private ArrayList<Alternativa> alternativas = new ArrayList<>();
    private ImageView imageView;
    private Handler handler = new Handler();
    private ArrayList<String> conteudosSelecionados;
    private ArrayList<Questoes> questoes;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_teste_home);
        instaciarComponentes();
        pegarOutraClasse();
        construirQuestao();
        cronometro();
    }

    private void pegarOutraClasse() {
        Intent intent = getIntent();
        //Bundle extra = getIntent().getBundleExtra("extra");
        try {
            conteudosSelecionados = intent.getStringArrayListExtra("conteudosSelecionados");
            // Log.i("raiva", conteudosSelecionados.toString() + "");
        } catch (Exception ex) {
            ex.printStackTrace();
            Log.i("raiva", ex.getMessage() + "");
        }

        //Log.i("raiva", conteudosSelecionados.toString() + "");
    }

    private void construirQuestao() {
        String id_Q = String.valueOf(new Random().nextInt(Integer.parseInt(new QuestaoDAO(getApplicationContext()).getTotalQuestoes())) + 1);
        //id_Q = "161";
        Questoes questao = new QuestaoDAO(getApplicationContext()).getQuestao(id_Q);
        //Toast.makeText(this, "ID: "+ id_Q, Toast.LENGTH_LONG).show();
        questoes.clear();

        for (int i = 0; i < conteudosSelecionados.size(); i++) {
            questoes.addAll(new QuestaoDAO(getApplicationContext()).getQuestoesConteudo(conteudosSelecionados.get(i)));
        }
        Log.i("raiva", questoes.size() + "");
        txtEnun.setText(questao.getCod() + ") " + questao.getEnunciado());
        txtDisc.setText(new QuestaoDAO(getApplicationContext()).getNomeDiscQuestao(id_Q));

        String name = "ic_" + txtDisc.getText().toString().toLowerCase().replaceAll("[^\\p{ASCII}]", "");

        Resources res = getResources();
        int id = res.getIdentifier(name, "drawable", getPackageName());
        imageView.setImageResource(id);


        //Toast.makeText(this, "ID: " + id + " nome: " + name, Toast.LENGTH_LONG).show();


        alternativas.clear();
        alternativas = new AlternativaDAO(getApplicationContext()).getAlternativas(id_Q);

        Log.i("raiva", alternativas.toString());

        for (int i = 0; i < alternativas.size(); i++) {
            //arrayListButtons.get(i).setChecked(false);
            rdGrupo.clearCheck();
            // ocultarTodos();
            arrayListButtons.get(i).setVisibility(View.VISIBLE);
            arrayListButtons.get(i).setText(alternativas.get(i).getResposta());
        }
        for (int j = alternativas.size(); j < arrayListButtons.size(); j++) {
            arrayListButtons.get(j).setVisibility(View.INVISIBLE);
        }
    }

    private void mensagem(String s) {
        Toast.makeText(this, s, Toast.LENGTH_LONG).show();
    }

    private void ocultarTodos() {
        for (int i = 0; i < 5; i++) {
            arrayListButtons.get(i).setVisibility(View.INVISIBLE);
        }
    }

    public void proxima(View v) {
        construirQuestao();
    }

    private void instaciarComponentes() {
        txtRel = (TextView) findViewById(R.id.txtTempo);
        txtDisc = (TextView) findViewById(R.id.txtDisciplina);
        txtEnun = (TextView) findViewById(R.id.txtEnunciado);
        imageView = (ImageView) findViewById(R.id.imgDisci);

        rdGrupo = findViewById(R.id.grupoRadio);
        a = findViewById(R.id.rd1);
        arrayListButtons.add(a);
        b = findViewById(R.id.rd2);
        arrayListButtons.add(b);
        c = findViewById(R.id.rd3);
        arrayListButtons.add(c);
        d = findViewById(R.id.rd4);
        arrayListButtons.add(d);
        e = findViewById(R.id.rd5);
        arrayListButtons.add(e);

        conteudosSelecionados = new ArrayList<>();
        questoes = new ArrayList<>();
    }

    private void cronometro() {
        new Thread() {
            public void run() {
                while (ss >= 0) {
                    handler.post(new Runnable() {
                        @Override
                        public void run() {
                            txtRel.setText("Tempo Restante: " + zero(ss / 3600) + ":" + zero(ss / 60) + ":" + zero(ss % 60) + ".");
                            ss--;
                        }
                    });
                    try {
                        Thread.sleep(1000);
                    } catch (InterruptedException e) {
                        e.printStackTrace();
                    }
                }
                sair();
            }
        }.start();
    }

    private void sair() {


        new Thread() {
            public void run() {

                handler.post(new Runnable() {
                    @Override
                    public void run() {
                        Toast.makeText(getApplicationContext(), "Seu tempo acabou.", Toast.LENGTH_SHORT).show();
                        finish();
                        //System.exit(0);
                    }
                });

            }
        }.start();
    }

    public String zero(Long l) {
        if (l < 10) {
            return "0" + String.valueOf(l);
        } else {
            return String.valueOf(l);
        }
    }
}
