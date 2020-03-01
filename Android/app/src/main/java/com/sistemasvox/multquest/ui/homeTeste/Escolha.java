package com.sistemasvox.multquest.ui.homeTeste;

import androidx.appcompat.app.AppCompatActivity;

import android.os.Bundle;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.Spinner;
import android.widget.Toast;

import com.google.android.material.chip.Chip;
import com.google.android.material.chip.ChipGroup;
import com.sistemasvox.multquest.R;
import com.sistemasvox.multquest.dao.AreaConhecimentoDAO;
import com.sistemasvox.multquest.dao.DisciplinaDAO;
import com.sistemasvox.multquest.model.AreaConhecimento;
import com.sistemasvox.multquest.model.Disciplina;

import java.util.ArrayList;

public class Escolha extends AppCompatActivity {

    private Spinner spArea, spDisc;
    private ChipGroup gpClip;
    private Chip a, b;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_escolha);
        instanciarObjs();
        preencherTela();
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
                //Toast.makeText(getApplicationContext(), "Oi", Toast.LENGTH_LONG).show();
                Toast.makeText(getApplicationContext(), spArea.getSelectedItem().toString(), Toast.LENGTH_LONG).show();
                ArrayList<Disciplina> disciplinaArrayList = new DisciplinaDAO(getApplicationContext()).getAllDisciplinas(spArea.getSelectedItem().toString());
                final ArrayList<String> listaDados2 = new ArrayList<>();
                for (int i = 0; i < disciplinaArrayList.size(); i++) {
                    listaDados2.add(disciplinaArrayList.get(i).getNome());
                }
                ArrayAdapter<String> adapter2 = new ArrayAdapter<String>(getApplicationContext(), android.R.layout.simple_spinner_item, listaDados2);
                spDisc.setAdapter(adapter2);
            }
            public void onNothingSelected(AdapterView<?> parent) {
            }
        });
    }

    private void instanciarObjs() {
        spArea = (Spinner) findViewById(R.id.spADC);
        spDisc = (Spinner) findViewById(R.id.spDisci);
        // gpClip = (ChipGroup) findViewById(R.id.gpClip);
    }
}
