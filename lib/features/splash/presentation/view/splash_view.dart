import 'package:flutter/material.dart';
import 'package:my_bookly/features/splash/presentation/view/widgets/spalsh_view_body.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SpalshViewBody(),
    );
  }
}
