import 'package:ai/api/api_calls.dart';
import 'package:ai/home/home.dart';
import 'package:ai/product/product.dart';
import 'package:ai/providers/products_provider.dart';
import 'package:ai/providers/transactions_provider.dart';
import 'package:ai/providers/translation_provider.dart';
import 'package:ai/transaction/transaction.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

ApiClient apiClient = ApiClient();

final productProvider = StateNotifierProvider<ProductProvider, ProductState>(
  (ref) => ProductProvider(ref),
);

final transactionProvider =
    StateNotifierProvider<TransactionProvider, TransactionState>(
  (ref) => TransactionProvider(ref),
);

final translationProvider = StateNotifierProvider<TranslationProvider, String>(
  (ref) => TranslationProvider(ref),
);

void main() {
  final GoRouter router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return const HomeScreen();
        },
        routes: <RouteBase>[
          GoRoute(
            onExit: (context) {
              ProviderScope.containerOf(context)
                  .read(productProvider.notifier)
                  .resetState();
              return true;
            },
            path: 'products',
            builder: (BuildContext context, GoRouterState state) {
              return const ProductScreen();
            },
          ),
          GoRoute(
            onExit: (context) {
              ProviderScope.containerOf(context)
                  .read(transactionProvider.notifier)
                  .resetState();
              return true;
            },
            path: 'transactions',
            builder: (BuildContext context, GoRouterState state) {
              return const TransactionScreen();
            },
          ),
        ],
      ),
    ],
  );
  runApp(
    ProviderScope(child: MyApp(router: router)),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key, required this.router});

  final GoRouter router;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      title: 'Go Ai',
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        textTheme: GoogleFonts.interTextTheme(
          Theme.of(context).textTheme,
        ),
        useMaterial3: true,
      ),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('hu'),
      ],
      locale: Locale(ref.watch(translationProvider)),
    );
  }
}
