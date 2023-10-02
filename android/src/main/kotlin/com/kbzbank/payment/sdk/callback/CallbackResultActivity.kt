package com.kbzbank.payment.sdk.callback;

import android.app.Activity
import android.content.Intent
import android.os.Bundle
import android.util.Log
import com.kbzbank.payment.KBZPay

class CallbackResultActivity : Activity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        val intent: Intent = getIntent()
        val result: Int = intent.getIntExtra(KBZPay.EXTRA_RESULT, 0)
        if (result == KBZPay.COMPLETED) {
            Log.d("KBZPay", "pay success!")
            val orderId: String? = intent.getStringExtra(KBZPay.EXTRA_ORDER_ID)
//            FlutterKpayKitPlugin.sendPayStatus(result, orderId)
        } else {
            val failMsg: String? = intent.getStringExtra(KBZPay.EXTRA_FAIL_MSG)
            Log.d("KBZPay", "pay fail, fail reason = $failMsg")
            val orderId: String? = intent.getStringExtra(KBZPay.EXTRA_ORDER_ID)
//            FlutterKpayKitPlugin.sendPayStatus(result, orderId)
        }
        finish()
    }

    protected override fun onResume() {
        Log.i("onResume", "callback activity on Resume")
        super.onResume()
    }
}