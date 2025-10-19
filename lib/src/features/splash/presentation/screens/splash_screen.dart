import 'dart:async';
import 'package:flutter/material.dart';
import 'package:qeema_task/gen/assets.gen.dart';
import 'package:qeema_task/src/core/config/routes/navigation.dart';
import 'package:qeema_task/src/features/home/presentation/screens/movies_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const routeName = 'splash_screen';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    _controller.forward();
    Timer(const Duration(seconds: 2), () {
      CustomNavigator.instance.pushReplacementNamed(MoviesScreen.routeName);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: FadeTransition(
          opacity: _animation,
          child: Assets.images.qemmaLogo.image(width: 150, height: 150),
        ),
      ),
    );
  }
}
