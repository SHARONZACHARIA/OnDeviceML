package com.example.ondevice;

import android.os.Bundle;
import io.flutter.app.FlutterActivity;
import io.flutter.plugins.GeneratedPluginRegistrant;

import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

public class MainActivity extends FlutterActivity {
  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    GeneratedPluginRegistrant.registerWith(this);
  }

   new MethodChannel(getFlutterView(), CHANNEL).setMethodCallHandler(
                new MethodCallHandler() {
                  @Override
                  public void onMethodCall(MethodCall call, Result result) {
                      // Note: this method is invoked on the main thread.
                      if (call.method.equals("getPrediction")) {
                          String predict = getBatteryLevel();
                  
                          if (batteryLevel != null) {
                              result.success(predict);
                          } else {
                              result.error("UNAVAILABLE", "error ", null);
                          }
                      } else {
                          result.notImplemented();
                      }
                  }
                });
}

String getPrediction()
{

}