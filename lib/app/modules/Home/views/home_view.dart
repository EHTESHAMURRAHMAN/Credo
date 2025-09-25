import 'package:credo/app/Utils/logo.dart';
import 'package:credo/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 0, automaticallyImplyLeading: false),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 10),

            InkWell(
              onTap: () {},
              child: Text(
                'Total Balance',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Obx(
              () => Text(
                "\$${controller.totalValue.value.toStringAsFixed(2)}",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).hintColor,
                ),
              ),
            ),
            const SizedBox(height: 30),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _actionButton(
                  icon: Icons.arrow_downward,
                  label: "Receive",
                  onTap: () {},
                  context: context,
                ),
                _actionButton(
                  icon: Icons.arrow_upward,
                  label: "Send",
                  onTap: () {},
                  context: context,
                ),
                _actionButton(
                  icon: Icons.swap_vert,
                  label: "Swap",
                  onTap: () {},
                  context: context,
                ),
              ],
            ),

            const SizedBox(height: 30),

            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Assets",
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 12),

            Obx(() {
              if (controller.tokens.isEmpty) {
                return const Center(child: Text("No assets available"));
              }

              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.tokens.length,
                itemBuilder: (context, index) {
                  final token = controller.tokens[index];

                  return ListTile(
                    onTap: () {
                      Get.toNamed(
                        Routes.TRANSACTIONS,
                        arguments: {
                          "logo": token.symbol,
                          "address": controller.currencyAddress.value,
                          "currency": token.name,
                          "balance": token.balance.value.toStringAsFixed(6),
                          'symbols': token.symbol,
                        },
                      );
                    },
                    leading: LogoBuilder(img: token.symbol),
                    title: Text(token.symbol.toUpperCase()),
                    subtitle: Obx(
                      () => Text(
                        token.price.value > 0
                            ? "\$${token.price.value.toStringAsFixed(4)}"
                            : "N/A",
                      ),
                    ),
                    trailing: Obx(
                      () => Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            token.balance.value > 0
                                ? "\$${token.balance.value.toStringAsFixed(4)}"
                                : "0.0000",
                          ),
                          Text(
                            token.price.value > 0
                                ? token.symbol.toUpperCase()
                                : "",
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _actionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    required BuildContext context,
  }) {
    return Column(
      children: [
        InkWell(
          borderRadius: BorderRadius.circular(40),
          onTap: onTap,
          child: CircleAvatar(
            radius: 30,
            backgroundColor: Theme.of(
              context,
            ).colorScheme.primary.withOpacity(0.1),
            child: Icon(
              icon,
              size: 28,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(label, style: Theme.of(context).textTheme.bodyMedium),
      ],
    );
  }
}
