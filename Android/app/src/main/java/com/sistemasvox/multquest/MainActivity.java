package com.sistemasvox.multquest;

import androidx.appcompat.app.AppCompatActivity;

import android.os.Bundle;
import android.widget.TextView;
import android.widget.Toast;

import com.sistemasvox.multquest.dao.AlternativaDAO;
import com.sistemasvox.multquest.dao.AreaConhecimentoDAO;
import com.sistemasvox.multquest.dao.ConteudoDAO;
import com.sistemasvox.multquest.dao.DisciplinaDAO;
import com.sistemasvox.multquest.dao.QuestaoDAO;

public class MainActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        atualizarTotal();
    }

    private void atualizarTotal() {
        TextView questoes = findViewById(R.id.txtQ);
        TextView alternativas = findViewById(R.id.txtA);
        TextView areConhe = findViewById(R.id.txtAC);
        TextView conteudo = findViewById(R.id.txtC);
        TextView disc = findViewById(R.id.txtD);

        try {
            questoes.setText(new QuestaoDAO(this).getTotalQuestoes());
        } catch (Exception e) {
            Toast.makeText(this, e.getMessage(), Toast.LENGTH_LONG).show();
        }
        alternativas.setText(new AlternativaDAO(this).getTotalAlternativas());
        areConhe.setText(String.valueOf(new AreaConhecimentoDAO(this).getAlternativas().size()));
        conteudo.setText(new ConteudoDAO(this).getTotalConteudo());
        disc.setText(new DisciplinaDAO(this).getAllDisciplinas().size() + "");
    }
}
