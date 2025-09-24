class XRPTransaction {
  String account;
  String amount;
  String destination;
  String fee;
  String hash;
  int date;

  XRPTransaction({
    required this.account,
    required this.amount,
    required this.destination,
    required this.fee,
    required this.hash,
    required this.date,
  });

  factory XRPTransaction.fromJson(Map<String, dynamic> json) {
    return XRPTransaction(
      account: json['Account'],
      amount: json['Amount'],
      destination: json['Destination'],
      fee: json['Fee'],
      hash: json['hash'],
      date: json['date'],
    );
  }
}
