import 'package:flutter/material.dart';
import 'package:qeema_task/src/core/config/routes/app_router.dart';
import 'package:qeema_task/src/core/config/routes/navigation.dart';
import 'package:qeema_task/src/features/splash/presentation/screens/splash_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Qeema Tech',
      debugShowCheckedModeBanner: false,
      navigatorKey: navigationKey,
      onGenerateRoute: AppRouter.generateRoute,
      initialRoute: SplashScreen.routeName,
    );
  }
}
