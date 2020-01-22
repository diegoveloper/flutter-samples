package com.example.flutter_samples;

import android.os.Bundle;
import io.flutter.app.FlutterActivity;
import io.flutter.plugins.GeneratedPluginRegistrant;

import android.view.ViewTreeObserver;
import android.view.WindowManager;

public class MainActivity extends FlutterActivity {
  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    //make transparent status bar
    getWindow().setStatusBarColor(0x00000000);
    GeneratedPluginRegistrant.registerWith(this); 
    //Remove full screen flag after load
    ViewTreeObserver vto = getFlutterView().getViewTreeObserver();
    vto.addOnGlobalLayoutListener(new ViewTreeObserver.OnGlobalLayoutListener() {
      @Override
      public void onGlobalLayout() {
        getFlutterView().getViewTreeObserver().removeOnGlobalLayoutListener(this);
        getWindow().clearFlags(WindowManager.LayoutParams.FLAG_FULLSCREEN);
      }
    });
  }
}
