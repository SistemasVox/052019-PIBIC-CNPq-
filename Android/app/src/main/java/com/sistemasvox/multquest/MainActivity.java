package com.sistemasvox.multquest;

import android.content.Intent;
import android.os.Bundle;
import android.util.Log;
import android.view.Menu;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ListView;
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
import com.sistemasvox.multquest.model.Progresso;
import com.sistemasvox.multquest.model.ProgressoAdapter;
import com.sistemasvox.multquest.ui.ControllSimulado.ControladoraMenuModoSimuladoResponderQuestao;
import com.sistemasvox.multquest.ui.simuladoresRealizados.Questionario_Resultados;

import java.util.ArrayList;
import java.util.List;

public class MainActivity extends AppCompatActivity {
    private AppBarConfiguration mAppBarConfiguration;

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
    }

    public void preencherGrafico(View view) {
        PieChart grafico = findViewById(R.id.graficoDisciplinas);
        Log.i("raiva", findViewById(R.id.graficoDisciplinas) + "");
        List<PieEntry> entradasGraficos = new ArrayList<>();
        ArrayList<Disciplina> disciplinas = new DisciplinaDAO(this).getAllDisciplinas();
        for (int i = 0; i < disciplinas.size(); i++) {
            entradasGraficos.add(new PieEntry((float) 100 / 13, disciplinas.get(i).getNome()));
        }
        PieDataSet dataSet = new PieDataSet(entradasGraficos, "Legenda do Gráfico (disciplinas)");
        dataSet.setColors(ColorTemplate.COLORFUL_COLORS);
        PieData pieData = new PieData(dataSet);
        grafico.setData(pieData);
        grafico.invalidate();
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
            Toast.makeText(this, "Atualmente você tem: " + new QuestionarioDAO(getApplicationContext()).getTotalQuestionario() + ". Simulados Realizados.", Toast.LENGTH_SHORT).show();
            ArrayList<Progresso> progressos = new QuestionarioDAO(getApplicationContext()).getQuestionariosProgresso();
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