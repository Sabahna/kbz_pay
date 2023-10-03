import 'dart:math';

class RandomGen {
  factory RandomGen() {
    return I;
  }

  RandomGen._();

  final _r = Random();

  static final RandomGen I = RandomGen._();

  String nonceStr(int length) {
    final nonceStr = String.fromCharCodes(
      List.generate(length, (index) => _r.nextInt(33) + 89),
    );
    print("nonce string -> $nonceStr");
    return nonceStr;
  }

  String timeStamp() {
    final timestamp = (DateTime.now().toUtc().millisecondsSinceEpoch ~/
            Duration.millisecondsPerSecond)
        .toString();
    print("timestamp $timestamp");
    return timestamp;
  }
}
