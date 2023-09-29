package com.flutter.kbz.pay.flutter_kbz_pay.demo

import android.util.Log
import com.flutter.kbz.pay.flutter_kbz_pay.SHA
import io.flutter.plugin.common.MethodChannel
import org.json.JSONException
import org.json.JSONObject

/**
 * Creating order should be in server side. This just as a demo
 */
object OrderPreCreateDemo {

    private lateinit var mMerchantCode: String
    private lateinit var callbackInfo: String
    private lateinit var notifyUrl: String
    private lateinit var mAppId: String
    private lateinit var mSignKey: String
    private lateinit var mTitle: String
    private lateinit var mAmount: String
    private lateinit var mMerchantOrderId: String
    private const val method = "kbz.payment.precreate"

    private lateinit var nonceStr: String
    private lateinit var timestamp: String

    fun createPay(
        hashMap: HashMap<String, Any>,
        result: MethodChannel.Result,
        nonceStr: String,
        timestamp: String
    ) {
        try {
            val params = JSONObject(hashMap as Map<*, *>)
            Log.v("createPay", params.toString())
            if (params.has("merch_code") && params.has("appid") && params.has("sign_key")) {
                mMerchantCode = params.getString("merch_code")
                mAppId = params.getString("appid")
                mSignKey = params.getString("sign_key")
                mAmount = params.getString("amount")
                mTitle = params.getString("title")
                mMerchantOrderId = params.getString("order_id")
                callbackInfo = params.getString("callback_info")
                notifyUrl = params.getString("notify_url")
                this.nonceStr = nonceStr
                this.timestamp = timestamp
                val createOrderString: String = createOrder()
                result.success(createOrderString)
            }
        } catch (e: JSONException) {
            e.printStackTrace()
            return
        }
    }

    private fun createOrder(): String {
        var json = ""
        return try {

            val jsonObject = JSONObject()
            val jsonRequest = JSONObject()
            jsonObject.put("Request", jsonRequest)
            jsonRequest.put("timestamp", timestamp)
            jsonRequest.put("method", method)
            jsonRequest.put("notify_url", notifyUrl)
            jsonRequest.put("nonce_str", nonceStr)
            jsonRequest.put("sign_type", "SHA256")
            jsonRequest.put(
                "sign", createOrderSign(notifyUrl, timestamp).uppercase()
            )
            jsonRequest.put("version", "1.0")

            val jsonContent = JSONObject()
            jsonRequest.put("biz_content", jsonContent)
            jsonContent.put("merch_order_id", mMerchantOrderId.toLong())
            jsonContent.put("merch_code", mMerchantCode)
            jsonContent.put("appid", mAppId)
            jsonContent.put("trade_type", "APP")
            jsonContent.put("title", mTitle)
            jsonContent.put("total_amount", mAmount)
            jsonContent.put("trans_currency", "MMK")
            jsonContent.put("timeout_express", "100m")
            jsonContent.put("callback_info", callbackInfo)
            json = jsonObject.toString()

            json
        } catch (jex: JSONException) {
            "Error in create order"
        }
    }

    private fun createOrderSign(
        notifyUrl: String, timestamp: String
    ): String {
        val str =
            "appid=$mAppId&callback_info=$callbackInfo&merch_code=$mMerchantCode&merch_order_id=$mMerchantOrderId&method=$method&nonce_str=$nonceStr&notify_url=$notifyUrl&timeout_express=100m&timestamp=$timestamp&title=$mTitle&total_amount=$mAmount&trade_type=APP&trans_currency=MMK&version=1.0"
        val s = "$str&key=$mSignKey"
        Log.d("kbz_pay", "sign string = $s")
        return SHA.getSHA256Str(s)
    }


}