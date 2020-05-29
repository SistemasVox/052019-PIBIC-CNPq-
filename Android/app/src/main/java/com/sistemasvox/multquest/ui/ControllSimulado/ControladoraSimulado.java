package com.sistemasvox.multquest.ui.ControllSimulado;

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
import com.sistemasvox.multquest.model.Questionario;
import com.sistemasvox.multquest.model.Questoes;

import java.util.ArrayList;

public class ControladoraSimulado extends AppCompatActivity {

    private long tempoS = 600;//10min
    private TextView txtRel, txtDisc, txtEnun;
    private RadioGroup rdGrupo;
    private RadioButton a, b, c, d, e;
    private ArrayList<RadioButton> arrayListButtons = new ArrayList<>();
    private ArrayList<Alternativa> alternativas = new ArrayList<>();
    private ImageView imageView;
    private Handler handler = new Handler();
    private ArrayList<String> conteudosSelecionados;
    private ArrayList<Questoes> questoes;
    private ArrayList<Questionario> questionario;
    private int posicao = 0;
    private int minPQ = 10;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_teste_home);
        instaciarComponentes();
        pegarOutraClasse();
        contruirQuestoes();
        construirQuestao(questionario.get(0).getQuestao());
        //checarSalvar();
        //Log.i("raiva", questoes.size() + "");
        tempoS = questoes.size() * minPQ; //1min para cada questão ser respondida.
        mensagem("Boa sorte, você tem 1 (um) minuto para responder cada questão.");
        cronometro();
    }

    private void checarSalvar() {
        rdGrupo.setOnCheckedChangeListener(new RadioGroup.OnCheckedChangeListener() {
            @Override
            public void onCheckedChanged(RadioGroup group, int checkedId) {
                int index = rdGrupo.indexOfChild(findViewById(rdGrupo.getCheckedRadioButtonId()));
                if (index != -1) {
                    atualizarResposta();
                }
            }

        });
    }

    public void finalizar(View view) {
        int parar = 0;
        for (int i = 0; i < questionario.size(); i++) {
            if (questionario.get(i).getResposta() == -1)
                parar++;
        }
        if (parar != 0) {
            Toast.makeText(getApplicationContext(), "Ainda tem questões não respondidas", Toast.LENGTH_SHORT).show();
        } else {
            Toast.makeText(getApplicationContext(), "Salvando.", Toast.LENGTH_SHORT).show();
            salvarQuestoes();
            finish();
        }
    }


    private void atualizarResposta() {
        int index = rdGrupo.indexOfChild(findViewById(rdGrupo.getCheckedRadioButtonId()));
        // Toast.makeText(getApplicationContext(), index + "", Toast.LENGTH_SHORT).show();
        questionario.get(posicao).setResposta(index);
        Log.i("raiva", questionario.get(posicao).getResposta() + "");
    }

    public void avancar(View view) {
        atualizarResposta();
        if (posicao == questionario.size() - 1) {
            posicao = questionario.size() - 1;
            checarSalvar();

        } else {
            posicao++;
        }
        construirQuestao(questionario.get(posicao).getQuestao());
        //Log.i("raiva", posicao + " ava");

    }

    public void regredir(View view) {
        atualizarResposta();
        if (posicao == 0) {
            posicao = 0;
        } else {
            posicao--;
        }
        construirQuestao(questionario.get(posicao).getQuestao());
        //Log.i("raiva", posicao + " reg");
    }

    private void contruirQuestoes() {
        questoes.clear();
        questionario.clear();
        for (int i = 0; i < conteudosSelecionados.size(); i++) {
            questoes.addAll(new QuestaoDAO(getApplicationContext()).getQuestoesConteudo(conteudosSelecionados.get(i)));
        }
        questoes = desordernarQuestoes(questoes);
        for (int i = 0; i < questoes.size(); i++) {
            questionario.add(new Questionario(questoes.get(i), desordernarAlternativas(new AlternativaDAO(getApplicationContext()).getAlternativas(questoes.get(i).getCod()))));
        }
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


        //alternativas.clear();
        //alternativas = desordernarAlternativas(new AlternativaDAO(getApplicationContext()).getAlternativas(questao.getCod()));
        alternativas = questionario.get(posicao).getAlternativas();

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
        if (questionario.get(posicao).getResposta() != -1) {
            ((RadioButton) rdGrupo.getChildAt(questionario.get(posicao).getResposta())).setChecked(true);
            Log.i("raiva", questionario.get(posicao).getResposta() + "");
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
        questionario = new ArrayList<>();
    }

    private void cronometro() {
        new Thread() {
            public void run() {
                while (tempoS >= 0) {
                    handler.post(new Runnable() {
                        @Override
                        public void run() {
                            txtRel.setText("Tempo Restante: " + zero(tempoS / 3600) + ":" + zero(tempoS / 60) + ":" + zero(tempoS % 60) + ".");
                            tempoS--;
                        }
                    });
                    try {
                        Thread.sleep(1000);
                    } catch (InterruptedException e) {
                        e.printStackTrace();
                    }
                }
                sair();
                finish();
            }
        }.start();
    }

    private void sair() {
        
        salvarQuestoes();

        new Thread() {
            public void run() {

                handler.post(new Runnable() {
                    @Override
                    public void run() {
                        Toast.makeText(getApplicationContext(), "Seu tempo acabou.", Toast.LENGTH_SHORT).show();
                        //System.exit(0);
                    }
                });

            }
        }.start();
    }

    private void salvarQuestoes() {
        for (int i  = 0; i < questionario.size(); i ++) {
            if (questionario.get(i).getResposta() != -1) {
                Log.i("raiva", questionario.get(i).getQuestao().getEnunciado() + " == " + questionario.get(i).getAlternativas().get(questionario.get(i).getResposta()).getResposta());
            } else {
                Log.i("raiva", questionario.get(i).getQuestao().getEnunciado() + " == Ficou sem resposta.");
            }
        }
    }

    public String zero(Long l) {
        if (l < 10) {
            return "0" + l;
        } else {
            return String.valueOf(l);
        }
    }
}
