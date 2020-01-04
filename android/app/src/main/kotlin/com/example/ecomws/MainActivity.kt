package com.example.ecomws

import androidx.annotation.NonNull
import com.example.greetFromKotlin
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity : FlutterActivity() {
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine);
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "kotlin_shared").setMethodCallHandler { call, result ->
            when (call.method) {
                "greet" -> result.success(greetFromKotlin())
                else -> result.notImplemented()
            }
        }
    }
}
