import 'package:credo/app/Utils/Common_Widget.dart';
import 'package:credo/app/Utils/logo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/send_controller.dart';

class SendView extends GetView<SendController> {
  const SendView({super.key});

  @override
  Widget build(BuildContext context) {
    final sendCtrl = controller;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: backButton(),
        centerTitle: true,
        title: const Text("Send"),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          children: [
            // Token Card
            Row(
              children: [
                LogoBuilder(img: controller.icon.value, height: 60, width: 60),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      controller.currency.value,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      controller.symbols.value,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.hintColor,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Column(
                  children: [
                    Obx(
                      () => Text(
                        "${sendCtrl.balance.value.toStringAsFixed(4)} ${sendCtrl.selectedToken.value}",
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Obx(
                      () => Text(
                        "\$${sendCtrl.balance.value.toStringAsFixed(4)} ${sendCtrl.selectedToken.value}",
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Recipient Field
            TextField(
              controller: sendCtrl.recipientController,
              decoration: InputDecoration(
                labelText: 'Recipient Address',
                hintText: '0x...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: theme.cardColor,
                suffixIcon: IconButton(
                  icon: const Icon(Icons.qr_code_scanner),
                  onPressed: sendCtrl.scanQRCode,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Amount Field
            Obx(
              () => TextField(
                controller: sendCtrl.amountController,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: InputDecoration(
                  labelText: 'Amount',
                  hintText: '0.0',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: theme.cardColor,
                  suffix: Text(sendCtrl.selectedToken.value),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Gas Fee Row
            Obx(
              () => Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: theme.cardColor,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Gas Fee"),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text("${sendCtrl.gasFee.value} Gwei"),
                        Text(
                          "~\$${(sendCtrl.gasFee.value * 0.00021).toStringAsFixed(2)}", // fake USD est
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.hintColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const Spacer(),

            // Send Button pinned bottom
            Obx(
              () => SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed:
                      sendCtrl.isValid.value ? sendCtrl.sendTransaction : null,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text("Send"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
