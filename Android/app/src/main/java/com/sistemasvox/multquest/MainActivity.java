package com.sistemasvox.multquest;

import android.content.Intent;
import android.graphics.Color;
import android.os.Bundle;
import android.util.Log;
import android.view.Menu;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.ListView;
import android.widget.Spinner;
import android.widget.Toast;

import androidx.appcompat.app.AppCompatActivity;
import androidx.appcompat.widget.Toolbar;
import androidx.drawerlayout.widget.DrawerLayout;
import androidx.navigation.NavController;
import androidx.navigation.Navigation;
import androidx.navigation.ui.AppBarConfiguration;
import androidx.navigation.ui.NavigationUI;

import com.github.mikephil.charting.charts.PieChart;
import com.github.mikephil.charting.components.Description;
import com.github.mikephil.charting.data.PieData;
import com.github.mikephil.charting.data.PieDataSet;
import com.github.mikephil.charting.data.PieEntry;
import com.github.mikephil.charting.utils.ColorTemplate;
import com.google.android.material.navigation.NavigationView;
import com.sistemasvox.multquest.Tools.Utilidades;
import com.sistemasvox.multquest.dao.AlternativaDAO;
import com.sistemasvox.multquest.dao.DisciplinaDAO;
import com.sistemasvox.multquest.dao.QuestaoDAO;
import com.sistemasvox.multquest.dao.QuestionarioDAO;
import com.sistemasvox.multquest.model.Disciplina;
import com.sistemasvox.multquest.model.Progresso;
import com.sistemasvox.multquest.model.ProgressoAdapter;
import com.sistemasvox.multquest.model.QuestionarioProgresso;
import com.sistemasvox.multquest.ui.ControllSimulado.ControladoraMenuModoSimuladoResponderQuestao;
import com.sistemasvox.multquest.ui.simuladoresRealizados.Questionario_Resultados;

import java.util.ArrayList;
import java.util.List;

public class MainActivity extends AppCompatActivity {
    private AppBarConfiguration mAppBarConfiguration;
    private boolean startApp = true;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        Toolbar toolbar = findViewById(R.id.toolbar);
        setSupportActionBar(toolbar);
        DrawerLayout drawer = findViewById(R.id.drawer_layout);
        NavigationView navigationView = findViewById(R.id.nav_view);
        mAppBarConfiguration = new AppBarConfiguration.Builder(R.id.nav_home, R.id.nav_f_simulado, R.id.nav_r_questoes, R.id.nav_s_realizados, R.id.nav_p_aprendizagem, R.id.nav_sobre).setDrawerLayout(drawer).build();
        NavController navController = Navigation.findNavController(this, R.id.nav_host_fragment);
        NavigationUI.setupActionBarWithNavController(this, navController, mAppBarConfiguration);
        NavigationUI.setupWithNavController(navigationView, navController);
        //controlarSpinnerAcessoEspecifico();
    }

    private void controlarSpinnerAcessoEspecifico() {

        final Spinner spinner = findViewById(R.id.spDiscP);
        spinner.setOnItemSelectedListener(new AdapterView.OnItemSelectedListener() {
            @Override
            public void onItemSelected(AdapterView<?> adapterView, View view, int i, long l) {
                if (spinner.getSelectedItemPosition() == 0) {
                    //startSpinner();
                } else {
                    Log.i(Utilidades.TAG, spinner.getSelectedItem().toString());
                    Disciplina disciplina = new DisciplinaDAO(getApplicationContext()).getDisciplinaName(spinner.getSelectedItem().toString());
                    escreverGraficoEspecifico(getIDDisciplinaExiste(spinner.getSelectedItem().toString()), disciplina);

                }
            }

            @Override
            public void onNothingSelected(AdapterView<?> adapterView) {

            }
        });
    }

    public void preencherGrafico(View view) {
        startSpinner();
        controlarSpinnerAcessoEspecifico();
        /*

        ArrayList<String> floats = new ArrayList<>();
        floats.add("1");
        floats.add("2");
        floats.add("3");
        ArrayList<Float> floats2 = new ArrayList<>();
        floats2.add(new Float(50.5));
        floats2.add(new Float(62.8));
        floats2.add(new Float(93.9));
        escreverGraficoEspecifico(floats, floats2, "Biologia");*/

    }

    private void startSpinner() {
        if (!new QuestionarioDAO(this).getTotalProgresso().equals("0")) {
            ArrayList<Disciplina> disciplinas = getDisciplinasSimuladosRealizados();
            preecherSpinners(disciplinas);
            ArrayList<Float> pontos = getPtsDisciplinaSimuladosRealizados(disciplinas);
            Log.i(Utilidades.TAG, pontos.toString());
            Log.i(Utilidades.TAG, disciplinas.toString());
            escreverGrafico(disciplinas, pontos);
            Toast.makeText(this, "Spinners Atualizados, escolha suas disciplinas.", Toast.LENGTH_SHORT).show();
        } else {
            Toast.makeText(this, "Realize ao menos um Simulado", Toast.LENGTH_LONG).show();
        }
    }


    private ArrayList<Float> getPtsDisciplinaSimuladosRealizados(ArrayList<Disciplina> disciplinas) {
        ArrayList<Float> pontos = new ArrayList<>();
        for (int i = 0; i < disciplinas.size(); i++) {
            pontos.add(0f);
        }
        for (int i = 0; i < Integer.parseInt(new QuestionarioDAO(this).getTotalProgresso()); i++) {
            for (int j = 0; j < disciplinas.size(); j++) {
                pontos.set(j, (pontos.get(j) + getPtsDisciplinasSimuladosRealizados(disciplinas.get(j), String.valueOf(i + 1)) / getIDDisciplinaExiste(disciplinas.get(j).getNome()).size()));
            }
        }
        return pontos;
    }

    private Float getPtsDisciplinasSimuladosRealizados(Disciplina disciplina, String cod_Prog_Ques) {
        ArrayList<QuestionarioProgresso> questionarioProgressos = new QuestionarioDAO(this).getConsultarProgressoQuestionario(cod_Prog_Ques);
        float acertos = 0;
        float erros = 0;
        for (int i = 0; i < questionarioProgressos.size(); i++) {
            if (disciplina.getNome().equals(new QuestaoDAO(this).getNomeDiscQuestao(questionarioProgressos.get(i).getCod_q()))) {
                if (new AlternativaDAO(this).getAlternativa(questionarioProgressos.get(i).getCod_a()).getClassificacao().equals("0")) {
                    acertos++;
                } else {
                    erros++;
                }
            }
        }
        if (acertos == 0 && erros == 0) {
            return 0f;
        } else {
            return ((acertos * 100) / (acertos + erros));
        }
    }

    private ArrayList<Disciplina> getDisciplinasSimuladosRealizados() {
        ArrayList<Disciplina> disciplinas = new ArrayList<>();
        for (int m = 0; m < Integer.parseInt(new QuestionarioDAO(this).getTotalProgresso()); m++) {
            ArrayList<QuestionarioProgresso> questionarioProgressos = new QuestionarioDAO(this).getConsultarProgressoQuestionario(String.valueOf(m + 1));
            for (int i = 0; i < questionarioProgressos.size(); i++) {
                if (!Utilidades.disciplinaDiferente(disciplinas, new QuestaoDAO(this).getNomeDiscQuestao(questionarioProgressos.get(i).getCod_q()))) {
                    disciplinas.add(new DisciplinaDAO(this).getDisciplinaQuestao(questionarioProgressos.get(i).getCod_q()));
                }
            }
        }
        return disciplinas;
    }


    private ArrayList<String> getIDDisciplinaExiste(String nome) {
        ArrayList<String> arrayList = new ArrayList<>();
        for (int m = 0; m < Integer.parseInt(new QuestionarioDAO(this).getTotalProgresso()); m++) {
            if ((getDisciplinasExiste(nome, String.valueOf(m + 1)))) {
                arrayList.add(String.valueOf(m + 1));
            }
        }
        return arrayList;
    }

    private boolean getDisciplinasExiste(String nome, String id_Progresso) {
        ArrayList<QuestionarioProgresso> questionarioProgressos = new QuestionarioDAO(this).getConsultarProgressoQuestionario(id_Progresso);
        for (int i = 0; i < questionarioProgressos.size(); i++) {
            if (new QuestaoDAO(this).getNomeDiscQuestao(questionarioProgressos.get(i).getCod_q()).equals(nome)) {
                return true;
            }
        }
        return false;
    }

    private void escreverGrafico(ArrayList<Disciplina> disciplinas, ArrayList<Float> pts) {
        PieChart grafico = findViewById(R.id.graficoDisciplinas);
        List<PieEntry> entradasGraficos = new ArrayList<>();
        for (int i = 0; i < disciplinas.size(); i++) {
            entradasGraficos.add(new PieEntry((float) (pts.get(i) * 1.00), getAbreviacaoNome(disciplinas.get(i).getNome())));
        }
        PieDataSet dataSet = new PieDataSet(entradasGraficos, "");
        dataSet.setColors(ColorTemplate.COLORFUL_COLORS);
        dataSet.setValueTextColor(Color.BLACK);
        dataSet.setValueTextSize(18f);

        PieData pieData = new PieData(dataSet);
        grafico.setData(pieData);
        Description temp = new Description();
        temp.setText("Seu aproveitamento geral em todos os Simulados Realizados.");
        grafico.animateX(1000);
        grafico.setDescription(temp);
        grafico.invalidate();
    }

    private void escreverGraficoEspecifico(ArrayList<String> progressos, Disciplina disciplina) {
        PieChart grafico = findViewById(R.id.graficoDisciplinas);
        List<PieEntry> entradasGraficos = new ArrayList<>();
        for (int i = 0; i < progressos.size(); i++) {
            entradasGraficos.add(new PieEntry(getPtsDisciplinasSimuladosRealizados(disciplina, progressos.get(i)), (i + 1) + "º Simulado"));
        }
        PieDataSet dataSet = new PieDataSet(entradasGraficos, "");
        dataSet.setColors(ColorTemplate.COLORFUL_COLORS);
        dataSet.setColors(ColorTemplate.COLORFUL_COLORS);
        dataSet.setValueTextColor(Color.BLACK);
        dataSet.setValueTextSize(18f);

        PieData pieData = new PieData(dataSet);
        grafico.setData(pieData);
        Description temp = new Description();
        temp.setText("Seu aproveitamento em " + getAbreviacaoNome(disciplina.getNome()) + " nos Simulados Realizados.");
        grafico.setDescription(temp);
        grafico.animateX(1500);
        grafico.invalidate();
    }

    private String getAbreviacaoNome(String nome) {
        if (nome.trim().contains(" ")) {
            String temp = "";
            String[] vS = nome.split(" ");
            for (int i = 0; i < vS.length; i++) {
                if (vS[i].length() > 2) {
                    temp += vS[i].substring(0, 1);
                }
            }
            return temp;
        } else {
            return nome;
        }
    }

    private void preecherSpinners(ArrayList<Disciplina> simuladosRealizados) {
        Spinner spDisc = findViewById(R.id.spDiscP);
        ArrayList<String> listaDados = new ArrayList<>();
        listaDados.add("");
        for (int i = 0; i < simuladosRealizados.size(); i++) {
            listaDados.add(simuladosRealizados.get(i).getNome());
        }
        ArrayAdapter<String> adapter = new ArrayAdapter<>(this, android.R.layout.simple_spinner_item, listaDados);
        spDisc.setAdapter(adapter);
    }

    public void startEscolhas(View view) {
        Intent i = new Intent(this, ControladoraMenuModoSimuladoResponderQuestao.class);
        i.putExtra("modoQuestao", getIntent().getStringExtra("modoQuestao"));
        startActivity(i);
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        getMenuInflater().inflate(R.menu.main, menu);
        return true;
    }

    public void simuladosRealizados(View v) {
        try {
            Toast.makeText(this, "Atualmente você tem: " + new QuestionarioDAO(getApplicationContext()).getTotalProgresso() + ". Simulados Realizados.", Toast.LENGTH_SHORT).show();
            ArrayList<Progresso> progressos = new QuestionarioDAO(getApplicationContext()).getAllProgressos();
            ListView listView = findViewById(R.id.listSRe);
            listView.setAdapter(new ProgressoAdapter(getApplicationContext(), progressos));
            listView.setOnItemClickListener(new AdapterView.OnItemClickListener() {
                @Override
                public void onItemClick(AdapterView<?> adapterView, View view, int i, long l) {
                    Progresso progresso = (Progresso) adapterView.getItemAtPosition(i);
                    Intent iq = new Intent(MainActivity.this, Questionario_Resultados.class);
                    iq.putExtra("progressoSelecionado", progresso.getId());
                    startActivity(iq);
                }
            });
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public boolean onSupportNavigateUp() {
        NavController navController = Navigation.findNavController(this, R.id.nav_host_fragment);
        return NavigationUI.navigateUp(navController, mAppBarConfiguration) || super.onSupportNavigateUp();
    }
}