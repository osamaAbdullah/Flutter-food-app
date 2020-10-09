package com.osama.firstfluttertest;

import androidx.annotation.NonNull;
//import android.content.ContextWrapper;
//import android.content.Intent;
//import android.content.IntentFilter;
//import android.os.BatteryManager;
//import android.os.Build.VERSION;
//import android.os.Build.VERSION_CODES;
import io.flutter.embedding.android.FlutterActivity;
//import io.flutter.embedding.engine.FlutterEngine;
//import io.flutter.plugin.common.MethodCall;
//import io.flutter.plugin.common.MethodChannel.Result;
//import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
//import io.flutter.plugin.common.MethodChannel;
//import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {
//  private static final String CHANNEL = "osama.com/battery";
//
//  private int getBatteryLevel() {
//    int batteryLevel = -1;
//    if (VERSION.SDK_INT >= VERSION_CODES.LOLLIPOP) {
//      BatteryManager batteryManager = (BatteryManager) getSystemService(BATTERY_SERVICE);
//      batteryLevel = batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY);
//    }
//    else {
//      Intent intent = new ContextWrapper(getApplicationContext()).registerReciver(null, new IntentFilter(Intent.ACTION_BATTERY_CHANGED));
//      batteryLevel = (intent.getIntExtra(BatteryManager.EXTRA_LEVEL, -1) * 100) / intent.getIntExtra(BatteryManager.EXTRA_SCALE, -1);
//    }
//    return batteryLevel;
//  }


//  @Override
//  public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
//    new MethodChannel(getFlutterView(), CHANNEL).setMethodCallHandler(new MethodChannel.MethodCallHandler() {
//      @java.lang.Override
//      public void onMethodCall(MethodCall methodCall, MethodChannel.Result result) {
//        if (methodCall.method.equals("osama.com/battery")) {
//          int batteryLevel = getBatteryLevel();
//          if (batteryLevel != -1) {
//            result.success(batteryLevel);
//          }
//          else {
//            result.error("UNAVAILABLE!", "Could not fetch battery level!", null);
//          }
//        }
//        else {
//          result.notImplemented();
//        }
//      }
//    });
//    GeneratedPluginRegistrant.registerWith(flutterEngine);
//  }
}
