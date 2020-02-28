package com.sistemasvox.multquest.ui.homeTeste;

import android.os.Build;
import android.os.Bundle;
import android.os.Handler;

import androidx.annotation.RequiresApi;
import androidx.appcompat.app.AppCompatActivity;

import android.widget.TextView;
import android.widget.Toast;

import com.sistemasvox.multquest.R;

public class TesteHome extends AppCompatActivity {

    private TextView txtRel;
    long ss = 6;//10min
    private Handler handler = new Handler();

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_teste_home);
        txtRel = (TextView) findViewById(R.id.txtTempo);
        cronometro();

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
