package com.flutter.kbz.pay.flutter_kbz_pay

import android.app.Activity
import android.util.Log
import com.flutter.kbz.pay.flutter_kbz_pay.demo.OrderPreCreateDemo
import com.flutter.kbz.pay.flutter_kbz_pay.demo.PaymentDemo
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import java.util.Calendar
import java.util.Random
import kotlin.math.abs


/** FlutterKbzPayPlugin */
class FlutterKbzPayPlugin : FlutterPlugin, MethodCallHandler, ActivityAware {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel
    private lateinit var activity: Activity

    private val sink: EventChannel.EventSink? = null

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "com.flutter.kbz.pay")
        channel.setMethodCallHandler(this)
    }


    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        if (call.method.equals("createPay")) {
            val map: HashMap<String, Any>? = call.arguments()
            if (map != null) {
                OrderPreCreateDemo.createPay(map, result, createRandomStr(), createTimestamp())
            }

        } else if (call.method.equals("startPay")) {
            Log.d("startPay", "call");
            val map: HashMap<String, Any>? = call.arguments()

            if (map != null) {
                PaymentDemo.startPay(activity, map, result, createRandomStr(), createTimestamp())
            }
        } else {
            result.notImplemented();
        }
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    private fun createRandomStr(): String {
        val random = Random()
        return abs(random.nextLong()).toString()
    }

    private fun createTimestamp(): String {
        val cal = Calendar.getInstance()
        val time = (cal.timeInMillis / 1000).toDouble()
        val d = java.lang.Double.valueOf(time)
        return d.toInt().toString()
    }


    // ActivityAware Section
    override fun onDetachedFromActivity() {
        TODO("Not yet implemented")
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        TODO("Not yet implemented")
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        activity = binding.activity;
    }

    override fun onDetachedFromActivityForConfigChanges() {
        TODO("Not yet implemented")
    }


}
