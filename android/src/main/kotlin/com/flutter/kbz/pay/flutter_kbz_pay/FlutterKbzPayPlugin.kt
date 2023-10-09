package com.flutter.kbz.pay.flutter_kbz_pay

import android.app.Activity
import com.kbzbank.payment.KBZPay
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.EventChannel.EventSink
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import org.json.JSONException
import org.json.JSONObject


/** FlutterKbzPayPlugin */
class FlutterKbzPayPlugin : FlutterPlugin, MethodCallHandler, ActivityAware {

    private lateinit var channel: MethodChannel
    private lateinit var eventChannel: EventChannel
    private lateinit var activity: Activity


    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        /// Flutter Method Channel
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "com.flutter.kbz.pay")
        channel.setMethodCallHandler(this)

        /// Flutter Event Channel to emit stream data
        eventChannel =
            EventChannel(flutterPluginBinding.binaryMessenger, "com.flutter.kbz.pay/pay_status")
        eventChannel.setStreamHandler(object : EventChannel.StreamHandler {
            override fun onListen(args: Any?, eventSink: EventSink) {

                /// for companion method
                sinkCompanion = eventSink
            }

            override fun onCancel(args: Any?) {}
        })
    }


    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        if (call.method.equals("startPay")) {
            val map: HashMap<String, Any>? = call.arguments()
            if (map != null) {
                try {
                    val params = JSONObject(map as Map<*, *>)

                    if (params.has("orderInfo") && params.has("sign")) {
                        val orderInfo = params.getString("orderInfo")
                        val sign = params.getString("sign")
                        val signType = params.getString("signType")

                        KBZPay.startPay(this.activity, orderInfo, sign, signType)

                        result.success("Ready to pay with KBZ Pay App")
                    } else {
                        result.error("Required params", "Required params", "Required params")
                        return
                    }
                } catch (e: JSONException) {
                    e.printStackTrace()
                    return
                }
            }

        } else {
            result.notImplemented();
        }
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }


    companion object {
        private var sinkCompanion: EventSink? = null

        // PayStatus Callback
        fun sendPayStatus(status: Int, orderId: String?) {
            val map: HashMap<Any?, Any?> = HashMap<Any?, Any?>()
            map["status"] = status
            map["orderId"] = orderId
            sinkCompanion?.success(map)
        }
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
