package com.sistemasvox.multquest.Tools;

import java.util.ArrayList;
import java.util.Random;

public abstract class Aleatorio {

    public static int getNum(int intervalo) {
        Random radom = new Random();
        return (radom.nextInt(intervalo));
    }
    public static ArrayList<Integer> gerarCombinacaoAleatorio(int tam, int intervalo) {
        ArrayList<Integer> combA = new ArrayList<Integer>();

        for (int i = 0; i < tam; i++) {
            combA.add(getNum(intervalo));
            while (verificaIgual(i, combA.get(i), combA)) {
                combA.set(i, getNum(intervalo));
            }
        }
        return combA;
    }

    private static boolean verificaIgual(int p, int n, ArrayList<Integer> numeros) {
        for (int k = 0; k < numeros.size(); k++) {
            if ((k != p) && (numeros.get(k) == n)) {
                return true;
            }
        }
        return false;
    }
}