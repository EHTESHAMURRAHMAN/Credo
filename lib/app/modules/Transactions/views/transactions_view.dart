import 'package:credo/app/Model/Blockchain_Response.dart';
import 'package:credo/app/Utils/Common_Widget.dart';
import 'package:credo/app/Utils/Transactions_Widgets.dart';
import 'package:credo/app/Utils/logo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
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
            _buildOtherTransactionList(context),
          ],
        ),
      ),
    );
  }

  Widget _buildBalanceInfo() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
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

  Widget _sendAndReceive(context, {currencys}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
            ontap: () {
              Get.toNamed(Routes.RECEIVE);
            },
            context,
            icon: Icons.arrow_downward,
            label: 'Receive'.tr,
          ),
        ],
      ),
    );
  }

  Widget _buildOtherTransactionList(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Obx(
        () =>
            controller.isblockchainExplorer.value == true
                ? controller.blockchainExplorer.isEmpty
                    ? SizedBox(
                      height: 400,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              Get.toNamed(Routes.RECEIVE);
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 15,
                                vertical: 8,
                              ),
                              height: 50,
                              decoration: BoxDecoration(
                                color: Theme.of(context).canvasColor,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  LogoBuilder(img: controller.logo.value),
                                  const SizedBox(width: 10),
                                  Text(
                                    'NO TRANSACTION'.tr,
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                    : ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount:
                          controller.blockchainExplorer
                              .where(
                                (model) =>
                                    BigInt.parse(model.value).toDouble() /
                                        BigInt.from(10).pow(18).toDouble() !=
                                    0,
                              )
                              .length,
                      itemBuilder: (context, index) {
                        // Filter transactions with non-zero value
                        final filteredTransactions =
                            controller.blockchainExplorer
                                .where(
                                  (model) =>
                                      BigInt.parse(model.value).toDouble() /
                                          BigInt.from(10).pow(18).toDouble() !=
                                      0,
                                )
                                .toList();
                        BlockchainExplorer model = filteredTransactions[index];
                        DateTime date = DateTime.fromMillisecondsSinceEpoch(
                          int.parse(model.timeStamp) * 1000,
                        );
                        String formattedDate = DateFormat(
                          'yyyy-MM-dd HH:mm:ss',
                        ).format(date);
                        double actualValue =
                            BigInt.parse(model.value).toDouble() /
                            BigInt.from(10).pow(18).toDouble();

                        final formatter = NumberFormat(
                          '0.000000',
                        ); // 6 digits after decimal
                        final gasPrice = int.parse(model.gasPrice) / 1000000000;
                        final gasfees =
                            int.parse(model.gasUsed) * gasPrice / 1000000000;

                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: ListTile(
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
                                  'gasfee': formatter.format(gasfees),
                                },
                              );
                            },
                            leading: CircleAvatar(
                              backgroundColor: Theme.of(context).canvasColor,
                              child: Icon(
                                controller.address.value.capitalize ==
                                        model.from.capitalize
                                    ? Icons.arrow_upward
                                    : Icons.arrow_downward,
                              ),
                            ),
                            title: Text(
                              model.to.length > 12
                                  ? "${model.to.substring(0, 6)}...${model.to.substring(model.to.length - 6)}"
                                  : model.to,
                              style: GoogleFonts.roboto(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                            subtitle: Text(
                              formattedDate,
                              style: GoogleFonts.roboto(
                                fontSize: 12,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            trailing:
                                controller.address.value.capitalize ==
                                        model.from.capitalize
                                    ? Text(
                                      actualValue == 0.0
                                          ? '- ${formatter.format(gasfees)}'
                                          : '- ${formatter.format(actualValue)}',
                                      style: GoogleFonts.roboto(
                                        fontSize: 16,
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                    : Text(
                                      '+ ${formatter.format(actualValue)}',
                                      style: GoogleFonts.roboto(
                                        fontSize: 16,
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                          ),
                        );
                      },
                    )
                : const SizedBox(
                  height: 400,
                  child: Center(child: CircularProgressIndicator()),
                ),
      ),
    );
  }

  // Widget _buildOtherTransactionList(BuildContext context) {
  //   return Padding(
  //     padding: const EdgeInsets.only(top: 5),
  //     child: Obx(
  //       () =>
  //           controller.isblockchainExplorer.value == true
  //               ? controller.blockchainExplorer.isEmpty
  //                   ? SizedBox(
  //                     height: 400,
  //                     child: Column(
  //                       mainAxisSize: MainAxisSize.min,
  //                       mainAxisAlignment: MainAxisAlignment.center,
  //                       children: [
  //                         InkWell(
  //                           onTap: () {
  //                             Get.toNamed(Routes.RECEIVE);
  //                           },
  //                           child: Container(
  //                             padding: const EdgeInsets.symmetric(
  //                               horizontal: 15,
  //                               vertical: 8,
  //                             ),
  //                             height: 50,
  //                             decoration: BoxDecoration(
  //                               color: Theme.of(context).canvasColor,
  //                               borderRadius: BorderRadius.circular(8),
  //                             ),
  //                             child: Row(
  //                               mainAxisSize: MainAxisSize.min,
  //                               children: [
  //                                 LogoBuilder(logoUrl: controller.logo.value),
  //                                 const SizedBox(width: 10),
  //                                 Text(
  //                                   'NO TRANSACTION'.tr,
  //                                   style: const TextStyle(
  //                                     fontSize: 15,
  //                                     fontWeight: FontWeight.w400,
  //                                   ),
  //                                 ),
  //                               ],
  //                             ),
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                   )
  //                   : ListView.builder(
  //                     physics: const NeverScrollableScrollPhysics(),
  //                     shrinkWrap: true,
  //                     itemCount: controller.blockchainExplorer.length,
  //                     itemBuilder: (context, index) {
  //                       BlockchainExplorer model = controller.blockchainExplorer
  //                           .elementAt(index);
  //                       DateTime date = DateTime.fromMillisecondsSinceEpoch(
  //                         int.parse(model.timeStamp) * 1000,
  //                       );
  //                       String formattedDate = DateFormat(
  //                         'yyyy-MM-dd HH:mm:ss',
  //                       ).format(date);
  //                       double actualValue =
  //                           BigInt.parse(model.value).toDouble() /
  //                           BigInt.from(10).pow(18).toDouble();

  //                       final formatter = NumberFormat('0.#########');
  //                       final gasPrice = int.parse(model.gasPrice) / 1000000000;

  //                       final gasfees =
  //                           int.parse(model.gasUsed) * gasPrice / 1000000000;

  //                       return Padding(
  //                         padding: const EdgeInsets.symmetric(vertical: 8),
  //                         child: ListTile(
  //                           onTap: () {
  //                             Get.toNamed(
  //                               Routes.BLOCKCHAIN_TRANSACTION_DETAILS,
  //                               arguments: {
  //                                 'currency': controller.currency.value,
  //                                 'value': formatter.format(actualValue),
  //                                 'from': model.from,
  //                                 'to': model.to,
  //                                 'hash': model.hash,
  //                                 'date': formattedDate,
  //                                 'address': controller.address.value,
  //                                 'gasfee': formatter.format(gasfees),
  //                               },
  //                             );
  //                           },
  //                           leading: CircleAvatar(
  //                             backgroundColor: Theme.of(context).canvasColor,
  //                             child: Icon(
  //                               controller.address.value.capitalize ==
  //                                       model.from.capitalize
  //                                   ? Icons.arrow_upward
  //                                   : Icons.arrow_downward,
  //                             ),
  //                           ),
  //                           title: Text(
  //                             model.to.length > 12
  //                                 ? "${model.to.substring(0, 6)}...${model.to.substring(model.to.length - 6)}"
  //                                 : model.to,
  //                             style: GoogleFonts.roboto(
  //                               fontWeight: FontWeight.bold,
  //                               fontSize: 13,
  //                             ),
  //                           ),
  //                           subtitle: Text(
  //                             formattedDate,
  //                             style: GoogleFonts.roboto(
  //                               fontSize: 12,
  //                               color: Colors.grey,
  //                               fontWeight: FontWeight.bold,
  //                             ),
  //                           ),
  //                           trailing:
  //                               controller.address.value.capitalize ==
  //                                       model.from.capitalize
  //                                   ? Text(
  //                                     actualValue == 0.0
  //                                         ? '- ${formatter.format(gasfees)}'
  //                                         : '- ${formatter.format(actualValue)}',
  //                                     style: GoogleFonts.roboto(
  //                                       fontSize: 16,
  //                                       color: Colors.red,
  //                                       fontWeight: FontWeight.bold,
  //                                     ),
  //                                   )
  //                                   : Text(
  //                                     '+ ${formatter.format(actualValue)}',
  //                                     style: GoogleFonts.roboto(
  //                                       fontSize: 16,
  //                                       color: Colors.green,
  //                                       fontWeight: FontWeight.bold,
  //                                     ),
  //                                   ),
  //                         ),
  //                       );
  //                     },
  //                   )
  //               : const SizedBox(
  //                 height: 400,
  //                 child: Center(child: CircularProgressIndicator()),
  //               ),
  //     ),
  //   );
  // }

  Widget _buildXRPTransactions(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return const SizedBox(
          height: 400,
          child: Center(child: CircularProgressIndicator()),
        );
      }

      if (controller.xRPTransaction.isEmpty) {
        return SizedBox(
          height: 400,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  Get.toNamed(Routes.RECEIVE);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 8,
                  ),
                  height: 50,
                  decoration: BoxDecoration(
                    color: Theme.of(context).canvasColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      LogoBuilder(img: controller.logo.value),
                      const SizedBox(width: 10),
                      Text(
                        'NO TRANSACTION'.tr,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }

      return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: controller.xRPTransaction.length,
        itemBuilder: (context, index) {
          final transaction = controller.xRPTransaction[index];
          return Padding(
            padding: const EdgeInsets.all(15.0),
            child: ListTile(
              onTap: () {
                Get.toNamed(
                  Routes.BLOCKCHAIN_TRANSACTION_DETAILS,
                  arguments: {
                    'currency': controller.currency.value,
                    'value':
                        controller.formatAmount(transaction.amount).toString(),
                    'from': transaction.account,
                    'to': transaction.destination,
                    'hash': transaction.hash,
                    'date': transaction.date.toString(),
                    'address': controller.address.value.capitalize,
                    'gasfee': controller.formatGasFee(transaction.fee),
                  },
                );
              },
              leading: CircleAvatar(
                backgroundColor: Theme.of(context).canvasColor,
                child: Icon(
                  controller.address.value.capitalize ==
                          transaction.account.capitalize
                      ? Icons.arrow_upward
                      : Icons.arrow_downward,
                ),
              ),
              title: Text(
                transaction.destination.length > 12
                    ? "${transaction.destination.substring(0, 6)}...${transaction.destination.substring(transaction.destination.length - 6)}"
                    : transaction.destination,
              ),
              trailing:
                  controller.address.value.capitalize ==
                          transaction.account.capitalize
                      ? Text(
                        controller.formatAmount(transaction.amount) == 0.0
                            ? '- ${controller.formatGasFee(transaction.fee)}'
                            : '- ${controller.formatAmount(transaction.amount)}',
                        style: GoogleFonts.roboto(
                          fontSize: 16,
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                      : Text(
                        '+ ${controller.formatAmount(transaction.amount)}',
                        style: GoogleFonts.roboto(
                          fontSize: 16,
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              subtitle: Text(transaction.date.toString()),
            ),
          );
        },
      );
    });
  }
}
