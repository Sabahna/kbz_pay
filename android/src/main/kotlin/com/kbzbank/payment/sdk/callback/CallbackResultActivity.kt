package com.kbzbank.payment.sdk.callback;

import android.app.Activity
import android.content.Intent
import android.os.Bundle
import android.util.Log
import com.flutter.kbz.pay.flutter_kbz_pay.FlutterKbzPayPlugin
import com.kbzbank.payment.KBZPay

class CallbackResultActivity : Activity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        val intent: Intent = intent
        val result: Int = intent.getIntExtra(KBZPay.EXTRA_RESULT, 0)

        Log.d("JackKBZPay", result.toString())
        if (result == KBZPay.COMPLETED) {
            Log.d("JackKBZPay", "Pay Success!")
            val orderId: String? = intent.getStringExtra(KBZPay.EXTRA_ORDER_ID)
            FlutterKbzPayPlugin.sendPayStatus(result, orderId)
        } else {
            val failMsg: String? = intent.getStringExtra(KBZPay.EXTRA_FAIL_MSG)
            Log.d("JackKBZPay", "Pay failed, $failMsg")
            val orderId: String? = intent.getStringExtra(KBZPay.EXTRA_ORDER_ID)
            FlutterKbzPayPlugin.sendPayStatus(result, orderId)
        }

        finish()
    }

    protected override fun onResume() {
        Log.i("onResume", "Resume Activity in KBZ Pay Callback")
        super.onResume()
    }
}