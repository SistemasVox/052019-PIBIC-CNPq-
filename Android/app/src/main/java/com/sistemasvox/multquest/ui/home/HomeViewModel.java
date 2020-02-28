package com.sistemasvox.multquest.ui.home;

import android.content.Context;

import androidx.lifecycle.LiveData;
import androidx.lifecycle.MutableLiveData;
import androidx.lifecycle.ViewModel;

import com.sistemasvox.multquest.dao.AlternativaDAO;

public class HomeViewModel extends ViewModel {

    private MutableLiveData<String> mText;

    public HomeViewModel() {
        mText = new MutableLiveData<>();
        mText.setValue("Home aqui... como editar?: ");
    }

    public LiveData<String> getText() {
        return mText;
    }
}