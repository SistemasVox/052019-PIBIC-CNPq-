package com.sistemasvox.multquest.ui.progressoDAprendizagem;

import androidx.lifecycle.LiveData;
import androidx.lifecycle.MutableLiveData;
import androidx.lifecycle.ViewModel;

public class ShareViewModel extends ViewModel {

    private MutableLiveData<String> mText;

    public ShareViewModel() {
        mText = new MutableLiveData<>();
        mText.setValue("Progresso de Aprendizagem");
    }

    public LiveData<String> getText() {
        return mText;
    }
}