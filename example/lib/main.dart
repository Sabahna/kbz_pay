import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_kbz_pay_example/demo/pre_create.dart';
import 'package:flutter_kbz_pay_example/demo/secure_info.dart';
import 'package:uni_links/uni_links.dart';

import 'demo/startPay.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  /// Required Bank & App Info
  ///
  late String appId;
  late String merchCode;
  late String merchKey;

  /// Text controller
  ///
  final orderIdController = TextEditingController();
  final amountController = TextEditingController();
  String? precreateText;

  late SecureInfo info;
  late PreCreate preCreate;
  late StartPay startPay;

  /// Deep link
  ///
  late StreamSubscription _sub;

  Future<void> initUniLinks() async {
    _sub = uriLinkStream.listen((Uri? uri) {
      print("unilinkStream $uri");
    }, onError: (err) {});
  }

  @override
  void initState() {
    super.initState();
    init();
    initUniLinks();
  }

  /// Initialize to get the merchant & appId information from environment file
  Future<void> init() async {
    await dotenv.load(fileName: ".env");
    appId = dotenv.env['app_id']!;
    merchCode = dotenv.env['merch_code']!;
    merchKey = dotenv.env['merch_key']!;

    info = SecureInfo(
      merchCode: merchCode,
      appId: appId,
      merchKey: merchKey,
    );

    preCreate = PreCreate(info: info);
    startPay = StartPay(info: info);
  }

  void createOrder() async {
    print("create order");
    final response = await preCreate.createPay(
      amount: amountController.text,
      merchOrderId: orderIdController.text,
    );

    setState(() {
      precreateText = response["Response"]["prepay_id"];
    });
  }

  void pay() async {
    startPay.pay(prePayId: precreateText!, merchantKey: info.merchKey);

    startPay.onPayStatus().listen((event) {
      print("onPayStatus $event");
    });
  }

  @override
  void dispose() {
    _sub.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('KBZ Pay Plugin Example'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Pre-Create Id",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(precreateText ?? "None"),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: Text(
                    precreateText != null ? "Now Ready to pay" : "",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
                TextField(
                  decoration: const InputDecoration(label: Text("OrderId")),
                  controller: orderIdController,
                ),
                TextField(
                  decoration: const InputDecoration(label: Text("Amount")),
                  controller: amountController,
                ),

                /// Pre-Create Order
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: ElevatedButton(
                    onPressed: createOrder,
                    child: const Text("Pre-Create Order"),
                  ),
                ),

                /// Pay in-app Payment
                precreateText != null
                    ? Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: ElevatedButton(
                          onPressed: pay,
                          child: const Text("Pay"),
                        ),
                      )
                    : const SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
