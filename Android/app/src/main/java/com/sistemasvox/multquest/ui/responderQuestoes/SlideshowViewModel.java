package com.sistemasvox.multquest.ui.responderQuestoes;

import androidx.lifecycle.LiveData;
import androidx.lifecycle.MutableLiveData;
import androidx.lifecycle.ViewModel;

public class SlideshowViewModel extends ViewModel {

    private MutableLiveData<String> mText;

    public SlideshowViewModel() {
        mText = new MutableLiveData<>();
        mText.setValue("Responda as Questões no seu tempo...");
    }

    public LiveData<String> getText() {
        return mText;
    }
}