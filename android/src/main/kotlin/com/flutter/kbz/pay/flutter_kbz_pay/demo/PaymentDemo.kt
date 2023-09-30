package com.flutter.kbz.pay.flutter_kbz_pay.demo

import android.app.Activity
import android.util.Log
import com.flutter.kbz.pay.flutter_kbz_pay.SHA
import com.kbzbank.payment.KBZPay
import io.flutter.plugin.common.MethodChannel
import org.json.JSONException
import org.json.JSONObject

object PaymentDemo {

    private lateinit var app_id: String
    private lateinit var merch_code: String
    private lateinit var mSignKey: String
    private lateinit var mSign: String
    private lateinit var mPrepayId: String
    private lateinit var mOrderInfo: String

    private lateinit var nonceStr: String
    private lateinit var timestamp: String

    fun startPay(
        activity: Activity,
        hashMap: HashMap<String, Any>,
        result: MethodChannel.Result,
        nonceStr: String,
        timestamp: String
    ) {
        try {
            val params = JSONObject(hashMap as Map<*, *>)
            Log.v("startPay", params.toString())

            if (params.has("prepay_id") && params.has("merch_code") && params.has("appid") && params.has(
                    "sign_key"
                )
            ) {

                mPrepayId = params.getString("prepay_id")
                merch_code = params.getString("merch_code")
                app_id = params.getString("appid")
                mSignKey = params.getString("sign_key")
                this.nonceStr = nonceStr
                this.timestamp = timestamp

                buildOrderInfo()

                pay(activity)

                result.success("payStatus " + 0);
            } else {
                result.error("parameter error", "parameter error", null);
            }
        } catch (e: JSONException) {
            e.printStackTrace()
            return
        }
    }

    private fun buildOrderInfo() {
        Log.d("Build Order Info", mPrepayId)

        mOrderInfo =
            "appid=$app_id&merch_code=$merch_code&nonce_str=$nonceStr&prepay_id=$mPrepayId&timestamp=$timestamp"

        mSign = SHA.getSHA256Str("$mOrderInfo&key=$mSignKey")
    }

    private fun pay(activity: Activity) {
        KBZPay.startPay(activity, mOrderInfo, mSign, "SHA256");
    }

}