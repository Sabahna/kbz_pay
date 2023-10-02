package com.flutter.kbz.pay.flutter_kbz_pay

import java.io.UnsupportedEncodingException
import java.nio.charset.Charset
import java.security.MessageDigest
import java.security.NoSuchAlgorithmException

object SHA {
    fun getSHA256Str(str: String): String {
        val messageDigest: MessageDigest
        var encodeStr = ""
        try {
            messageDigest = MessageDigest.getInstance("SHA-256")
            messageDigest.update(str.toByteArray(Charset.forName("UTF-8")))
            encodeStr = byte2Hex(messageDigest.digest())
        } catch (e: NoSuchAlgorithmException) {
            e.printStackTrace()
        } catch (e: UnsupportedEncodingException) {
            e.printStackTrace()
        }
        return encodeStr
    }

    private fun byte2Hex(bytes: ByteArray): String {
        val stringBuffer = StringBuffer()
        var temp: String? = null
        for (i in bytes.indices) {
            temp = Integer.toHexString(bytes[i].toInt() and 0xFF)
            if (temp.length == 1) {
                // 1得到一位的进行补0操作
                stringBuffer.append("0")
            }
            stringBuffer.append(temp)
        }
        return stringBuffer.toString()
    }
}