import 'package:flutter/material.dart';

Widget buildSendReceiveOption(
  context, {
  required IconData icon,
  required String label,
  required VoidCallback ontap,
}) {
  return InkWell(
    onTap: ontap,
    child: Column(
      children: [
        Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
            color: Theme.of(context).canvasColor,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Icon(icon),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
      ],
    ),
  );
}

Widget buildTransactionItem(transaction, ctx) {
  final isPositive = transaction.signvalue == '+';

  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: ListTile(
      leading: CircleAvatar(
        backgroundColor: Theme.of(ctx).canvasColor,
        child: Icon(isPositive ? Icons.arrow_downward : Icons.arrow_upward),
      ),
      title: Text(
        transaction.fromAdress.length > 12
            ? "${transaction.fromAdress.substring(0, 6)}...${transaction.fromAdress.substring(transaction.fromAdress.length - 6)}"
            : transaction.fromAdress,
      ),
      subtitle: Text(transaction.transactionDate),
      trailing: Text(
        isPositive ? '+ ${transaction.credit}' : '- ${transaction.credit}',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: isPositive ? Colors.green : Colors.red,
        ),
      ),
    ),
  );
}

Widget buildTransactionDetail(String label, String value,
    {bool isHash = false}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 4),
    child: Text(
      '$label: $value',
      style: TextStyle(
        color: isHash ? Colors.grey[500] : Colors.grey[700],
        fontSize: 14,
      ),
    ),
  );
}
