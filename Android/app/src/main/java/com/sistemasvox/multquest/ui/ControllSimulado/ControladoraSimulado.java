package com.sistemasvox.multquest.ui.ControllSimulado;

import android.content.Intent;
import android.content.res.Resources;
import android.os.Build;
import android.os.Bundle;
import android.os.Handler;
import android.util.Log;
import android.view.View;
import android.widget.ImageView;
import android.widget.RadioButton;
import android.widget.RadioGroup;
import android.widget.TextView;
import android.widget.Toast;

import androidx.annotation.RequiresApi;
import androidx.appcompat.app.AppCompatActivity;
import androidx.constraintlayout.widget.ConstraintLayout;

import com.sistemasvox.multquest.R;
import com.sistemasvox.multquest.Tools.Aleatorio;
import com.sistemasvox.multquest.dao.AlternativaDAO;
import com.sistemasvox.multquest.dao.QuestaoDAO;
import com.sistemasvox.multquest.dao.QuestionarioDAO;
import com.sistemasvox.multquest.model.Alternativa;
import com.sistemasvox.multquest.model.Progresso;
import com.sistemasvox.multquest.model.Questionario;
import com.sistemasvox.multquest.model.Questoes;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

public class ControladoraSimulado extends AppCompatActivity {
    private long tempoTotal = 600;
    private TextView txtRel, txtDisc, txtEnun;
    private RadioGroup rdGrupo;
    private RadioButton radioButton;
    private ArrayList<RadioButton> arrayListButtons = new ArrayList<>();
    private ArrayList<Alternativa> alternativas = new ArrayList<>();
    private ImageView imageView;
    private Handler handler = new Handler();
    private ArrayList<String> conteudosSelecionados;
    private ArrayList<Questoes> questoes;
    private ArrayList<Questionario> questionario;
    private int posicao = 0;
    private int minPQ = 60;
    private boolean respondido;

    @RequiresApi(api = Build.VERSION_CODES.JELLY_BEAN)
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_teste_home);
        instaciarComponentes();
        pegarOutraClasse();
        contruirQuestoes();
        construirQuestao(questionario.get(0).getQuestao());
        checarSalvar();
        tempoTotal = questoes.size() * minPQ;
        mensagem("Boa sorte, você tem 1 (um) minuto para responder cada questão.");
        cronometro();
    }

    private void ocultarBarraNavegacao() {
        View decorView = getWindow().getDecorView();
        int uiOptions = View.SYSTEM_UI_FLAG_HIDE_NAVIGATION | View.SYSTEM_UI_FLAG_FULLSCREEN;
        decorView.setSystemUiVisibility(uiOptions);
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
            if (questionario.get(i).getResposta() == -1) parar++;
        }
        if (parar != 0) {
            Toast.makeText(getApplicationContext(), "Ainda possui questões não respondidas", Toast.LENGTH_SHORT).show();
        } else {
            Toast.makeText(getApplicationContext(), "Salvando...", Toast.LENGTH_SHORT).show();
            salvarQuestoes();
            finish();
        }
    }

    @Override
    protected void onPause() {
        super.onPause();
        if (!respondido) {
            Toast.makeText(getApplicationContext(), "Você não pode abandonar o questionário ativo. Caso faça isso, perderá os pontos restante.", Toast.LENGTH_LONG).show();
            salvarQuestoes();
            finish();
        } else {
        }
    }

    @Override
    public void onBackPressed() {
        Toast.makeText(getApplicationContext(), "Você deve terminar de responder as questões antes de sair.", Toast.LENGTH_SHORT).show();
    }

    private void atualizarResposta() {
        int index = rdGrupo.indexOfChild(findViewById(rdGrupo.getCheckedRadioButtonId()));
        questionario.get(posicao).setResposta(index);
    }

    @RequiresApi(api = Build.VERSION_CODES.JELLY_BEAN_MR1)
    public void avancar(View view) {
        atualizarResposta();
        if (posicao == questionario.size() - 1) {
            posicao = questionario.size() - 1;
        } else {
            posicao++;
        }
        construirQuestao(questionario.get(posicao).getQuestao());
    }

    @RequiresApi(api = Build.VERSION_CODES.JELLY_BEAN_MR1)
    public void regredir(View view) {
        atualizarResposta();
        if (posicao == 0) {
            posicao = 0;
        } else {
            posicao--;
        }
        construirQuestao(questionario.get(posicao).getQuestao());
    }

    @RequiresApi(api = Build.VERSION_CODES.JELLY_BEAN_MR1)
    private void contruirQuestoes() {
        questoes.clear();
        questionario.clear();
        respondido = false;
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
        try {
            conteudosSelecionados = intent.getStringArrayListExtra("conteudosSelecionados");
        } catch (Exception ex) {
            ex.printStackTrace();
            Log.i("raiva", ex.getMessage() + "");
        }
    }

    @RequiresApi(api = Build.VERSION_CODES.JELLY_BEAN_MR1)
    private void construirQuestao(Questoes questao) {
        txtEnun.setText((posicao + 1) + ") " + questao.getEnunciado());
        txtDisc.setText(new QuestaoDAO(getApplicationContext()).getNomeDiscQuestao(questao.getCod()));
        String name = "ic_" + txtDisc.getText().toString().toLowerCase().replaceAll("[^\\p{ASCII}]", "");
        Resources res = getResources();
        int id = res.getIdentifier(name, "drawable", getPackageName());
        imageView.setImageResource(id);
        alternativas = questionario.get(posicao).getAlternativas();
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

    @RequiresApi(api = Build.VERSION_CODES.JELLY_BEAN_MR1)
    public void proxima(View v) {
        construirQuestao(questoes.get((posicao + 1) % questoes.size()));
    }

    @RequiresApi(api = Build.VERSION_CODES.JELLY_BEAN)
    private void instaciarComponentes() {
        txtRel = findViewById(R.id.txtTempo);
        txtDisc = findViewById(R.id.txtDisciplina);
        txtEnun = findViewById(R.id.txtEnunciado);
        imageView = findViewById(R.id.imgDisci);
        rdGrupo = findViewById(R.id.grupoRadio);
        radioButton = clonarBotao((RadioButton) rdGrupo.getChildAt(0));
        conteudosSelecionados = new ArrayList<>();
        questoes = new ArrayList<>();
        questionario = new ArrayList<>();
        removerResposta();
    }

    private void removerResposta() {
        ConstraintLayout constraintLayout = findViewById(R.id.constraintlayoutRadio);
        TextView view = findViewById(R.id.txtResposta);
        constraintLayout.removeView(view);
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

    private void cronometro() {
        new Thread() {
            public void run() {
                while (tempoTotal >= 0 && respondido == false) {
                    handler.post(new Runnable() {
                        @Override
                        public void run() {
                            txtRel.setText("Tempo Restante: " + zero(tempoTotal / 3600) + ":" + zero(tempoTotal / 60) + ":" + zero(tempoTotal % 60) + ".");
                            tempoTotal--;
                        }
                    });
                    try {
                        Thread.sleep(1000);
                    } catch (InterruptedException e) {
                        e.printStackTrace();
                    }
                }
                if (respondido == false) {
                    sair();
                    finish();
                }
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
                    }
                });
            }
        }.start();
    }

    private void salvarQuestoes() {
        try {
            if (respondido == false) {
                String idProgresso = String.valueOf(Integer.parseInt(new QuestionarioDAO(getApplicationContext()).getTotalProgresso()) + 1);
                Progresso progresso = new Progresso(idProgresso, calTempo(questoes.size() * minPQ), calTempo((questoes.size() * minPQ) - tempoTotal), getDateTime());
                new QuestionarioDAO(getApplicationContext()).salvarProgressoQuestionario(progresso);
                for (int i = 0; i < questionario.size(); i++) {
                    if (questionario.get(i).getResposta() != -1) {
                        new QuestionarioDAO(getApplicationContext()).salvarQuestionario(idProgresso, questionario.get(i).getQuestao().getCod(), questionario.get(i).getAlternativas().get(questionario.get(i).getResposta()).getCod());
                    } else {
                        new QuestionarioDAO(getApplicationContext()).salvarQuestionario(idProgresso, questionario.get(i).getQuestao().getCod(), "00");
                    }
                }
                respondido = true;
            }
        } catch (Exception e) {
            Log.i("raiva", e.getMessage());
        }
    }

    private String calTempo(long i) {
        return zero(i / 3600) + ":" + zero(i / 60) + ":" + zero(i % 60);
    }

    private String getDateTime() {
        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSS");
        Date date = new Date();
        return dateFormat.format(date);
    }

    public String zero(Long l) {
        if (l < 10) {
            return "0" + l;
        } else {
            return String.valueOf(l);
        }
    }
}