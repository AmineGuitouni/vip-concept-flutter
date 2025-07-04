import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:go_router/go_router.dart';
import 'package:localboss/core/router/app_router.dart';
import 'package:localboss/features/auth/viewModels/auth_provider.dart';
import 'package:localboss/features/auth/viewModels/user_credentials_provider.dart';
import 'package:localboss/features/business/viewModels/business_data.dart';
import 'package:localboss/features/reviews/viewModels/reviews_provider.dart';
import 'package:localboss/features/ai/viewModels/ai_settings.dart';
import 'package:localboss/core/themes.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Stripe.publishableKey = "pk_test_51PkCGa01gyWg5oRN1ZBjp8LZwKYUyWxFcsyT3r8MCnAaPNpyfIo0bGsZDQ6qCPQeS1zgYqmcGmDxTBqyDHMrJd0R00yYX6g6Oy";
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AiSettingsProvider()),
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => BusinessData()),
        ChangeNotifierProvider(create: (context) => ReviewsData()),
        ChangeNotifierProxyProvider<AuthProvider, UserCredentialsProvider>(
          create: (context) => UserCredentialsProvider(null),
          update: (context, authProvider, previous) => UserCredentialsProvider(authProvider),
        ),
      ],
      child: const MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    GoRouter router = goRouter(Provider.of<AuthProvider>(context, listen: true));
    
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: lightTheme,
      routerConfig: router,
    );
  }
}
