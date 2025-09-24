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
              onTap: () {
                //controller.secureStore.deleteAll();
              },
              child: Text(
                'Total Balance',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "\$0.00 USD",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).hintColor,
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
              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.tokens.length,
                itemBuilder: (context, index) {
                  final token = controller.tokens[index];

                  return Obx(
                    () => ListTile(
                      leading: LogoBuilder(img: token.symbol),
                      title: Text(token.name),
                      subtitle: Text(
                        token.price.value > 0
                            ? "\$${token.price.value.toStringAsFixed(6)}"
                            : "N/A",
                      ),
                      trailing: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            token.price.value > 0
                                ? "\$${token.price.value.toStringAsFixed(6)}"
                                : "N/A",
                          ),
                          Text(
                            token.price.value > 0
                                ? "\$${token.price.value.toStringAsFixed(6)}"
                                : "N/A",
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }),

            const SizedBox(height: 20),

            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
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
