import 'package:credo/app/Model/Blockchain_Response.dart';
import 'package:credo/app/Utils/Common_Widget.dart';
import 'package:credo/app/Utils/Transactions_Widgets.dart';
import 'package:credo/app/Utils/logo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../../routes/app_pages.dart';
import '../controllers/transactions_controller.dart';

class TransactionsView extends GetView<TransactionsController> {
  const TransactionsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: backButton(),
        title: heading('Transactions'.tr, ''),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            _buildBalanceInfo(),
            const SizedBox(height: 20),
            _sendAndReceive(context),
            const SizedBox(height: 20),
            _buildEvmTransactions(context),
            //_buildXrpTransactions(context),
          ],
        ),
      ),
    );
  }

  /// 🔹 Top Balance Section
  Widget _buildBalanceInfo() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          LogoBuilder(img: controller.logo.value),
          const SizedBox(height: 20),
          Text(
            controller.currency.value,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
          ),
          Text(
            controller.balance.value,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
          ),
        ],
      ),
    );
  }

  /// 🔹 Send & Receive Buttons
  Widget _sendAndReceive(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          buildSendReceiveOption(
            context,
            icon: Icons.arrow_upward,
            label: 'Send'.tr,
            ontap: () {
              Get.toNamed(
                Routes.SEND,
                arguments: {
                  'logo': controller.logo.value,
                  'currency': controller.currency.value,
                },
              );
            },
          ),
          buildSendReceiveOption(
            context,
            icon: Icons.arrow_downward,
            label: 'Receive'.tr,
            ontap: () {
              Get.toNamed(
                Routes.RECEIVE,
                arguments: {
                  'logo': controller.logo.value,
                  'currency': controller.currency.value,
                  'address': controller.address.value,
                  'symbols': controller.symbols.value,
                },
              );
            },
          ),
        ],
      ),
    );
  }

  /// 🔹 EVM Transactions
  Widget _buildEvmTransactions(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Obx(() {
        if (!controller.isblockchainExplorer.value) {
          return const SizedBox(
            height: 400,
            child: Center(child: CircularProgressIndicator()),
          );
        }

        final filteredTx =
            controller.blockchainExplorer
                .where(
                  (model) =>
                      BigInt.parse(model.value).toDouble() /
                          BigInt.from(10).pow(18).toDouble() !=
                      0,
                )
                .toList();

        if (filteredTx.isEmpty) {
          print(filteredTx.length);
          return _noTransactionWidget(context);
        }

        return ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: filteredTx.length,
          itemBuilder: (context, index) {
            final model = filteredTx[index];
            final date = DateTime.fromMillisecondsSinceEpoch(
              int.parse(model.timeStamp) * 1000,
            );
            final formattedDate = DateFormat(
              'yyyy-MM-dd HH:mm:ss',
            ).format(date);

            final actualValue =
                BigInt.parse(model.value).toDouble() /
                BigInt.from(10).pow(18).toDouble();
            final formatter = NumberFormat('0.000000');
            final gasPrice = int.parse(model.gasPrice) / 1e9;
            final gasFee =
                int.parse(model.gasUsed) * gasPrice / 1e9; // in ETH/BNB/etc.

            return _transactionTile(
              context,
              isOutgoing:
                  controller.address.value.capitalize == model.from.capitalize,
              address: model.to,
              date: formattedDate,
              value: actualValue,
              gasFee: gasFee,
              formatter: formatter,
              onTap: () {
                Get.toNamed(
                  Routes.BLOCKCHAIN_TRANSACTION_DETAILS,
                  arguments: {
                    'currency': controller.currency.value,
                    'value': formatter.format(actualValue),
                    'from': model.from,
                    'to': model.to,
                    'hash': model.hash,
                    'date': formattedDate,
                    'address': controller.address.value,
                    'gasfee': formatter.format(gasFee),
                  },
                );
              },
            );
          },
        );
      }),
    );
  }

  /// 🔹 XRP Transactions
  Widget _buildXrpTransactions(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return const SizedBox(
          height: 400,
          child: Center(child: CircularProgressIndicator()),
        );
      }

      if (controller.xRPTransaction.isEmpty) {
        return _noTransactionWidget(context);
      }

      return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: controller.xRPTransaction.length,
        itemBuilder: (context, index) {
          final tx = controller.xRPTransaction[index];
          final value = controller.formatAmount(tx.amount);
          final gasFee = controller.formatGasFee(tx.fee);

          return _transactionTile(
            context,
            isOutgoing:
                controller.address.value.capitalize == tx.account.capitalize,
            address: tx.destination,
            date: tx.date.toString(),
            value: value,
            gasFee: double.tryParse(gasFee) ?? 0,
            formatter: NumberFormat("0.######"),
            onTap: () {
              Get.toNamed(
                Routes.BLOCKCHAIN_TRANSACTION_DETAILS,
                arguments: {
                  'currency': controller.currency.value,
                  'value': value.toString(),
                  'from': tx.account,
                  'to': tx.destination,
                  'hash': tx.hash,
                  'date': tx.date.toString(),
                  'address': controller.address.value.capitalize,
                  'gasfee': gasFee,
                },
              );
            },
          );
        },
      );
    });
  }

  /// 🔹 Common: No Transaction Widget
  Widget _noTransactionWidget(BuildContext context) {
    return SizedBox(
      height: 400,
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          decoration: BoxDecoration(
            color: Theme.of(context).canvasColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              LogoBuilder(img: controller.logo.value),
              const SizedBox(width: 10),
              Text('NO TRANSACTION'.tr, style: const TextStyle(fontSize: 15)),
            ],
          ),
        ),
      ),
    );
  }

  /// 🔹 Common: Transaction Tile
  Widget _transactionTile(
    BuildContext context, {
    required bool isOutgoing,
    required String address,
    required String date,
    required double value,
    required double gasFee,
    required NumberFormat formatter,
    required VoidCallback onTap,
  }) {
    final shortAddr =
        address.length > 12
            ? "${address.substring(0, 6)}...${address.substring(address.length - 6)}"
            : address;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
      child: ListTile(
        onTap: onTap,
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).canvasColor,
          child: Icon(isOutgoing ? Icons.arrow_upward : Icons.arrow_downward),
        ),
        title: Text(
          shortAddr,
          style: GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: 13),
        ),
        subtitle: Text(
          date,
          style: GoogleFonts.roboto(
            fontSize: 12,
            color: Colors.grey,
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing: Text(
          isOutgoing
              ? "- ${formatter.format(value == 0.0 ? gasFee : value)}"
              : "+ ${formatter.format(value)}",
          style: GoogleFonts.roboto(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: isOutgoing ? Colors.red : Colors.green,
          ),
        ),
      ),
    );
  }
}
