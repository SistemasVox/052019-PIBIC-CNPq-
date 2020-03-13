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
import com.sistemasvox.multquest.Tools.Aleatorio;
import com.sistemasvox.multquest.dao.AlternativaDAO;
import com.sistemasvox.multquest.dao.QuestaoDAO;
import com.sistemasvox.multquest.model.Alternativa;
import com.sistemasvox.multquest.model.Questoes;

import java.util.ArrayList;

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
    private int posicao = 0;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_teste_home);
        instaciarComponentes();
        pegarOutraClasse();
        contruirQuestoes();
        construirQuestao(questoes.get((posicao) % questoes.size()));
        Log.i("raiva", questoes.size() + "");
        cronometro();
    }

    public void avancar(View view) {
        construirQuestao(questoes.get(Math.abs((posicao + 1)) % questoes.size()));
        posicao = Math.abs((posicao + 1)) % questoes.size();
        construirQuestao(questoes.get(Math.abs((posicao) % questoes.size())));
        Log.i("raiva", posicao + " ava");
    }

    public void regredir(View view) {
        if (posicao == 0) {
            posicao = 0;
        } else {
            posicao = Math.abs((posicao - 1)) % questoes.size();
        }
        construirQuestao(questoes.get(Math.abs((posicao)) % questoes.size()));
        Log.i("raiva", posicao + " reg");
    }

    private void contruirQuestoes() {
        questoes.clear();
        for (int i = 0; i < conteudosSelecionados.size(); i++) {
            questoes.addAll(new QuestaoDAO(getApplicationContext()).getQuestoesConteudo(conteudosSelecionados.get(i)));
        }
        questoes = desordernarQuestoes(questoes);
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

    private void construirQuestao(Questoes questao) {
        //String id_Q = String.valueOf(new Random().nextInt(Integer.parseInt(new QuestaoDAO(getApplicationContext()).getTotalQuestoes())) + 1);
        //String id_Q = "161";
        //Questoes questao = new QuestaoDAO(getApplicationContext()).getQuestao(id_Q);
        //Toast.makeText(this, "ID: "+ id_Q, Toast.LENGTH_LONG).show();
        // Log.i("raiva", questoes.size() + "");


        txtEnun.setText((posicao + 1) + ") " + questao.getEnunciado());
        txtDisc.setText(new QuestaoDAO(getApplicationContext()).getNomeDiscQuestao(questao.getCod()));


        String name = "ic_" + txtDisc.getText().toString().toLowerCase().replaceAll("[^\\p{ASCII}]", "");
        Resources res = getResources();
        int id = res.getIdentifier(name, "drawable", getPackageName());
        imageView.setImageResource(id);


        //Toast.makeText(this, "ID: " + id + " nome: " + name, Toast.LENGTH_LONG).show();


        alternativas.clear();
        alternativas = desordernarAlternativas(new AlternativaDAO(getApplicationContext()).getAlternativas(questao.getCod()));

        //Log.i("raiva", alternativas.toString());

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

    private ArrayList<Alternativa> desordernarAlternativas(ArrayList<Alternativa> alternativas) {
        ArrayList<Alternativa> alternativasAUX = new ArrayList<>();
        ArrayList<Integer> aleatorios = Aleatorio.gerarCombinacaoAleatorio(alternativas.size(), alternativas.size());
        for (int i = 0; i < alternativas.size(); i++) {
            alternativasAUX.add(alternativas.get(aleatorios.get(i)));
        }
        return alternativasAUX;
    }

    private ArrayList<Questoes> desordernarQuestoes(ArrayList<Questoes> questoes) {
        ArrayList<Questoes> questoesAUX = new ArrayList<>();
        ArrayList<Integer> aleatorios = Aleatorio.gerarCombinacaoAleatorio(questoes.size(), questoes.size());
        for (int i = 0; i < questoes.size(); i++) {
            questoesAUX.add(questoes.get(aleatorios.get(i)));
        }
        return questoesAUX;
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
        construirQuestao(questoes.get((posicao + 1) % questoes.size()));
    }

    private void instaciarComponentes() {
        txtRel = findViewById(R.id.txtTempo);
        txtDisc = findViewById(R.id.txtDisciplina);
        txtEnun = findViewById(R.id.txtEnunciado);
        imageView = findViewById(R.id.imgDisci);

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
            return "0" + l;
        } else {
            return String.valueOf(l);
        }
    }
}
