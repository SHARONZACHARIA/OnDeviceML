package com.example.ondevice;
import org.tensorflow.lite.Interpreter;
import android.os.Bundle;
import java.util.ArrayList;
import java.lang.Integer;
import io.flutter.app.FlutterActivity;
import io.flutter.plugins.GeneratedPluginRegistrant;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import java.io.FileInputStream;
import java.io.IOException;
import java.nio.MappedByteBuffer;
import java.nio.channels.FileChannel;
import android.content.res.AssetFileDescriptor;


public class MainActivity extends FlutterActivity {
private static final String CHANNEL = "ondeviceML";
protected Interpreter tflite;
  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    GeneratedPluginRegistrant.registerWith(this);

    try {
      tflite = new Interpreter(loadModelFile());
    } catch (Exception e) {
      //TODO: handle exception
    }

   
    new MethodChannel(getFlutterView(), CHANNEL).setMethodCallHandler(
    new MethodCallHandler() {
        @Override
        public void onMethodCall(MethodCall call, Result result) {
          if (call.method.equals("predictData")) {
            ArrayList<Integer> args  = new ArrayList<>();
            args = call.argument("arg");
            String prediction = predictData(args);
            if (prediction !=null) {
                result.success(prediction);
            } else {
                result.error("UNAVAILABLE", "prediction  not available.", null);
            }
        } else {
            result.notImplemented();
        }}
    });
  }
  
 
  String predictData(ArrayList<Integer> input_data)
  {
    float intArray[][] = new float[1][input_data.size()];
    int i =0;
    for(Integer e : input_data)
    { intArray[0][i] = e;
      i++;
    }
     System.out.println(intArray);
     float [][] output_datas= new float[1][1];
     tflite.run(intArray,output_datas);
     System.out.println(output_datas);
     if (output_datas[0][0]>0.5)
     {
      return "1";
     }
     else
      {
        return "0";
      }}
 

  // method to load tflite file from device 
  
  private MappedByteBuffer loadModelFile() throws Exception {
  AssetFileDescriptor fileDescriptor = this.getAssets().openFd("newdevice.tflite");
  FileInputStream inputStream = new FileInputStream(fileDescriptor.getFileDescriptor());
  FileChannel fileChannel = inputStream.getChannel();
  long startOffset = fileDescriptor.getStartOffset();
  long declaredLength = fileDescriptor.getDeclaredLength();
  return fileChannel.map(FileChannel.MapMode.READ_ONLY, startOffset, declaredLength);
  }


  
}
 
  
  





