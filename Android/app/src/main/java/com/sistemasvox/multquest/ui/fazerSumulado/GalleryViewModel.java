package com.sistemasvox.multquest.ui.fazerSumulado;

import androidx.lifecycle.LiveData;
import androidx.lifecycle.MutableLiveData;
import androidx.lifecycle.ViewModel;

public class GalleryViewModel extends ViewModel {

    private MutableLiveData<String> mText;

    public GalleryViewModel() {
        mText = new MutableLiveData<>();
        mText.setValue("Iniciar Simulado");
    }

    public LiveData<String> getText() {
        return mText;
    }
}