import 'package:get/get.dart';

import '../modules/Activity/bindings/activity_binding.dart';
import '../modules/Activity/views/activity_view.dart';
import '../modules/Biometric/bindings/biometric_binding.dart';
import '../modules/Biometric/views/biometric_view.dart';
import '../modules/BlockchainTransactionDetails/bindings/blockchain_transaction_details_binding.dart';
import '../modules/BlockchainTransactionDetails/views/blockchain_transaction_details_view.dart';
import '../modules/Browser/bindings/browser_binding.dart';
import '../modules/Browser/views/browser_view.dart';
import '../modules/CurrencyBundle/bindings/currency_bundle_binding.dart';
import '../modules/CurrencyBundle/views/currency_bundle_view.dart';
import '../modules/Dashboard/bindings/dashboard_binding.dart';
import '../modules/Dashboard/views/dashboard_view.dart';
import '../modules/History/bindings/history_binding.dart';
import '../modules/History/views/history_view.dart';
import '../modules/Home/bindings/home_binding.dart';
import '../modules/Home/views/home_view.dart';
import '../modules/Onboarding/bindings/onboarding_binding.dart';
import '../modules/Onboarding/views/onboarding_view.dart';
import '../modules/Password/bindings/password_binding.dart';
import '../modules/Password/views/password_view.dart';
import '../modules/Receive/bindings/receive_binding.dart';
import '../modules/Receive/views/receive_view.dart';
import '../modules/RecoveryPhrase/bindings/recovery_phrase_binding.dart';
import '../modules/RecoveryPhrase/views/recovery_phrase_view.dart';
import '../modules/Send/bindings/send_binding.dart';
import '../modules/Send/views/send_view.dart';
import '../modules/Setting/bindings/setting_binding.dart';
import '../modules/Setting/views/setting_view.dart';
import '../modules/Splash/bindings/splash_binding.dart';
import '../modules/Splash/views/splash_view.dart';
import '../modules/Swap/bindings/swap_binding.dart';
import '../modules/Swap/views/swap_view.dart';
import '../modules/Transactions/bindings/transactions_binding.dart';
import '../modules/Transactions/views/transactions_view.dart';
import '../modules/WalletSetup/bindings/wallet_setup_binding.dart';
import '../modules/WalletSetup/views/wallet_setup_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.DASHBOARD,
      page: () => const DashboardView(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.HISTORY,
      page: () => const HistoryView(),
      binding: HistoryBinding(),
    ),
    GetPage(
      name: _Paths.SEND,
      page: () => const SendView(),
      binding: SendBinding(),
    ),
    GetPage(
      name: _Paths.RECEIVE,
      page: () => const ReceiveView(),
      binding: ReceiveBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.BROWSER,
      page: () => const BrowserView(),
      binding: BrowserBinding(),
    ),
    GetPage(
      name: _Paths.SWAP,
      page: () => const SwapView(),
      binding: SwapBinding(),
    ),
    GetPage(
      name: _Paths.ACTIVITY,
      page: () => const ActivityView(),
      binding: ActivityBinding(),
    ),
    GetPage(
      name: _Paths.SETTING,
      page: () => const SettingView(),
      binding: SettingBinding(),
    ),
    GetPage(
      name: _Paths.ONBOARDING,
      page: () => const OnboardingView(),
      binding: OnboardingBinding(),
    ),
    GetPage(
      name: _Paths.WALLET_SETUP,
      page: () => const WalletSetupView(),
      binding: WalletSetupBinding(),
    ),
    GetPage(
      name: _Paths.BIOMETRIC,
      page: () => const BiometricView(),
      binding: BiometricBinding(),
    ),
    GetPage(
      name: _Paths.RECOVERY_PHRASE,
      page: () => const RecoveryPhraseView(),
      binding: RecoveryPhraseBinding(),
    ),
    GetPage(
      name: _Paths.PASSWORD,
      page: () => const PasswordView(),
      binding: PasswordBinding(),
    ),
    GetPage(
      name: _Paths.CURRENCY_BUNDLE,
      page: () => const CurrencyBundleView(),
      binding: CurrencyBundleBinding(),
    ),
    GetPage(
      name: _Paths.TRANSACTIONS,
      page: () => const TransactionsView(),
      binding: TransactionsBinding(),
    ),
    GetPage(
      name: _Paths.BLOCKCHAIN_TRANSACTION_DETAILS,
      page: () => const BlockchainTransactionDetailsView(),
      binding: BlockchainTransactionDetailsBinding(),
    ),
  ];
}
