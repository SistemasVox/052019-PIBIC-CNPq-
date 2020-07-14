package com.sistemasvox.multquest;

import android.content.Intent;
import android.os.Bundle;
import android.util.Log;
import android.view.Menu;
import android.view.View;
import android.widget.Toast;

import androidx.appcompat.app.AppCompatActivity;
import androidx.appcompat.widget.Toolbar;
import androidx.drawerlayout.widget.DrawerLayout;
import androidx.navigation.NavController;
import androidx.navigation.Navigation;
import androidx.navigation.ui.AppBarConfiguration;
import androidx.navigation.ui.NavigationUI;

import com.github.mikephil.charting.charts.PieChart;
import com.github.mikephil.charting.data.PieData;
import com.github.mikephil.charting.data.PieDataSet;
import com.github.mikephil.charting.data.PieEntry;
import com.github.mikephil.charting.utils.ColorTemplate;
import com.google.android.material.navigation.NavigationView;
import com.sistemasvox.multquest.dao.DisciplinaDAO;
import com.sistemasvox.multquest.dao.QuestionarioDAO;
import com.sistemasvox.multquest.model.Disciplina;
import com.sistemasvox.multquest.ui.ControllSimulado.ControladoraMenuModoSimuladoResponderQuestao;

import java.util.ArrayList;
import java.util.List;

public class MainActivity extends AppCompatActivity {

    private AppBarConfiguration mAppBarConfiguration;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        Toolbar toolbar = findViewById(R.id.toolbar);
        setSupportActionBar(toolbar);/*
        FloatingActionButton fab = findViewById(R.id.fab);
        fab.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Snackbar.make(view, "Replace with your own action", Snackbar.LENGTH_LONG)
                        .setAction("Action", null).show();
            }
        });*/
        DrawerLayout drawer = findViewById(R.id.drawer_layout);
        NavigationView navigationView = findViewById(R.id.nav_view);
        // Passing each menu ID as a set of Ids because each
        // menu should be considered as top level destinations.
        mAppBarConfiguration = new AppBarConfiguration.Builder(
                R.id.nav_home, R.id.nav_f_simulado, R.id.nav_r_questoes,
                R.id.nav_s_realizados, R.id.nav_p_aprendizagem, R.id.nav_sobre)
                .setDrawerLayout(drawer)
                .build();
        NavController navController = Navigation.findNavController(this, R.id.nav_host_fragment);
        NavigationUI.setupActionBarWithNavController(this, navController, mAppBarConfiguration);
        NavigationUI.setupWithNavController(navigationView, navController);
        //Toast.makeText(this, new AlternativaDAO(this).getTotalAlternativas(), Toast.LENGTH_LONG).show();
    }

    public void preencherGrafico(View view) {
        PieChart grafico = (PieChart) findViewById(R.id.graficoDisciplinas);
        Log.i("raiva", findViewById(R.id.graficoDisciplinas) + "");

        List<PieEntry> entradasGraficos = new ArrayList<>();
        ArrayList<Disciplina> disciplinas =  new DisciplinaDAO(this).getAllDisciplinas();


        for (int i = 0; i < disciplinas.size(); i++) {
            entradasGraficos.add(new PieEntry((float) 100/13, disciplinas.get(i).getNome()));
        }

        PieDataSet dataSet = new PieDataSet(entradasGraficos, "Legenda do Gráfico (disciplinas)");
        dataSet.setColors(ColorTemplate.COLORFUL_COLORS);

        PieData pieData = new PieData(dataSet);

        grafico.setData(pieData);

        grafico.invalidate();


    }

    public void startEscolhas(View view) {


        //Log.i("raiva", getIntent().getStringExtra("modoQuestao") + "");
        Intent i = new Intent(this, ControladoraMenuModoSimuladoResponderQuestao.class);
        i.putExtra("modoQuestao", getIntent().getStringExtra("modoQuestao"));
        startActivity(i);
        //finish();
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.main, menu);
        return true;
    }

    public void simuladosRealizados(View v) {
        try {
            //mensagem(new QuestionarioDAO(getApplicationContext()).getTotalQuestionario());
            Toast.makeText(this, new QuestionarioDAO(getApplicationContext()).getTotalQuestionario(), Toast.LENGTH_LONG).show();
            Log.i("raiva", new QuestionarioDAO(getApplicationContext()).getQuestionariosProgresso().toString().replace("Progresso", "\n Progresso"));
            Log.i("raiva", new QuestionarioDAO(getApplicationContext()).getQuestionarios().toString().replace("QuestionarioProgresso", "\n QuestionarioProgresso"));
        } catch (Exception e) {
            Log.i("raiva", e.toString());
        }

    }

    @Override
    public boolean onSupportNavigateUp() {
        NavController navController = Navigation.findNavController(this, R.id.nav_host_fragment);
        return NavigationUI.navigateUp(navController, mAppBarConfiguration)
                || super.onSupportNavigateUp();
    }
}
