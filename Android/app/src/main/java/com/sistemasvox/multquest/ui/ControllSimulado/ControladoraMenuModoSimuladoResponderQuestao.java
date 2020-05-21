package com.sistemasvox.multquest.ui.ControllSimulado;

import android.content.Intent;
import android.os.Bundle;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.CheckBox;
import android.widget.LinearLayout;
import android.widget.Spinner;
import android.widget.Toast;

import androidx.appcompat.app.AppCompatActivity;

import com.sistemasvox.multquest.R;
import com.sistemasvox.multquest.dao.AreaConhecimentoDAO;
import com.sistemasvox.multquest.dao.ConteudoDAO;
import com.sistemasvox.multquest.dao.DisciplinaDAO;
import com.sistemasvox.multquest.model.AreaConhecimento;
import com.sistemasvox.multquest.model.Conteudo;
import com.sistemasvox.multquest.model.Disciplina;

import java.util.ArrayList;

public class ControladoraMenuModoSimuladoResponderQuestao extends AppCompatActivity {

    private Spinner spArea, spDisc;
    private LinearLayout linearLayout;
    private ArrayList<Conteudo> conteudos;
    private ArrayList<String> conteudosSelecionados;
    private String modo = "ZZZ";


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_escolha);
        instanciarObjs();
        preencherTela();
    }

    public void checarConteudos(View view) {
        //CheckBox cb = (CheckBox) linearLayout.getChildAt(0).findViewById(R.id.checkBox);
        //Toast.makeText(getApplicationContext(), cb.isChecked()+"", Toast.LENGTH_SHORT).show();
        int t = 0;
        conteudosSelecionados.clear();
        for (int i = 0; i < linearLayout.getChildCount(); i++) {
            CheckBox cb = (CheckBox) linearLayout.getChildAt(i).findViewById(R.id.checkBox);
            if (cb.isChecked()) {
                conteudosSelecionados.add(conteudos.get(i).getNome());
                t++;
            }
        }

        //Log.i("raiva", conteudosSelecionados.toString() + "");

        try {
            if (t > 0){
                if (modo.equals("0")) {
                    Intent intent = new Intent(this, ControladoraDesenhoTelaSimulado.class);
                    intent.putExtra("conteudosSelecionados", conteudosSelecionados);
                    startActivity(intent);
                } else {
                    Intent intent = new Intent(this, ControladoraSimulado.class);
                    intent.putExtra("conteudosSelecionados", conteudosSelecionados);
                    startActivity(intent);
                }
                //Log.i("raiva", modo + "");
                finish();
            }else{
                Toast.makeText(getApplicationContext(), "Selecione ao menos 1 conteúdo.", Toast.LENGTH_SHORT).show();
            }
        } catch (Exception e) {
            Log.i("raiva", e.getMessage() + "");
        }


        //finish();
    }


    private void preencherConteudo() {
        //Log.i("raiva", conteudos.toString() + "");
        LayoutInflater inflater = LayoutInflater.from(this);
        linearLayout.removeAllViewsInLayout();

        for (int i = 0; i < conteudos.size(); i++) {
            View view = inflater.inflate(R.layout.activity_escolha_conteudos, linearLayout, false);
            CheckBox checkBox = view.findViewById(R.id.checkBox);
            checkBox.setText(conteudos.get(i).getNome());
            linearLayout.addView(view);
        }
    }

    private void preencherTela() {
        final ArrayList<AreaConhecimento> areaConhecimentos = new AreaConhecimentoDAO(getApplicationContext()).getAreas();
        final ArrayList<String> listaDados = new ArrayList<>();
        listaDados.add("");//Vazio selecionar

        for (int i = 0; i < areaConhecimentos.size(); i++) {
            listaDados.add(areaConhecimentos.get(i).getNome());
        }

        ArrayAdapter<String> adapter = new ArrayAdapter<String>(this,
                android.R.layout.simple_spinner_item, listaDados);
        spArea.setAdapter(adapter);
        spArea.setOnItemSelectedListener(new AdapterView.OnItemSelectedListener() {
            public void onItemSelected(AdapterView<?> parent, View view, int pos, long id) {
                ArrayList<Disciplina> disciplinaArrayList = new DisciplinaDAO(getApplicationContext()).getAllDisciplinas(spArea.getSelectedItem().toString());
                final ArrayList<String> listaDados2 = new ArrayList<>();
                for (int i = 0; i < disciplinaArrayList.size(); i++) {
                    listaDados2.add(disciplinaArrayList.get(i).getNome());
                }
                ArrayAdapter<String> adapter2 = new ArrayAdapter<>(getApplicationContext(), android.R.layout.simple_spinner_item, listaDados2);
                spDisc.setAdapter(adapter2);
                if (!spArea.getSelectedItem().toString().isEmpty()) {
                    spDisc.setOnItemSelectedListener(new AdapterView.OnItemSelectedListener() {
                        @Override
                        public void onItemSelected(AdapterView<?> parent, View view, int position, long id) {
                            conteudos.clear();
                            conteudos = new ConteudoDAO(getApplicationContext()).getConteudosDisc(spDisc.getSelectedItem().toString());
                            preencherConteudo();
                        }

                        @Override
                        public void onNothingSelected(AdapterView<?> parent) {

                        }
                    });
                } else {
                    conteudos.clear();
                    conteudos = new ConteudoDAO(getApplicationContext()).getConteudosAll();
                    preencherConteudo();
                }
            }

            public void onNothingSelected(AdapterView<?> parent) {
            }
        });
    }

    private void instanciarObjs() {
        spArea = (Spinner) findViewById(R.id.spADC);
        spDisc = (Spinner) findViewById(R.id.spDisci);
        linearLayout = findViewById(R.id.ae_LinearLay);
        conteudosSelecionados = new ArrayList<>();
        conteudos = new ArrayList<>();
        Intent i = getIntent();
        modo = i.getStringExtra("modoQuestao");
        //Log.i("raiva", modo + "");
    }
}
