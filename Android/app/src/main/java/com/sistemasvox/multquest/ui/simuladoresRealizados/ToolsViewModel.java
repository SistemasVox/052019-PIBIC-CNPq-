package com.sistemasvox.multquest.ui.simuladoresRealizados;

import androidx.lifecycle.LiveData;
import androidx.lifecycle.MutableLiveData;
import androidx.lifecycle.ViewModel;

public class ToolsViewModel extends ViewModel {

    private MutableLiveData<String> mText;

    public ToolsViewModel() {
        mText = new MutableLiveData<>();
        mText.setValue("This is Simulado Realizado fragment");
    }

    public LiveData<String> getText() {
        return mText;
    }
}