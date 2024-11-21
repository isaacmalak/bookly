import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import 'package:my_bookly/core/utils/assets.dart';
import 'package:my_bookly/features/home/presentaion/views/howe_view.dart';

class SpalshViewBody extends StatefulWidget {
  const SpalshViewBody({super.key});

  @override
  State<SpalshViewBody> createState() => _SpalshViewBodyState();
}

class _SpalshViewBodyState extends State<SpalshViewBody>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  late Animation<Offset> slidingAnimation;

  @override
  void initState() {
    super.initState();
    initSlidingAnimation();
    homeViewNavigation();
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AnimatedBuilder(
            animation: animationController,
            builder: (context, _) {
              return SlideTransition(
                position: slidingAnimation,
                child: SvgPicture.asset(
                  AssetsData.logo,
                ),
              );
            }),
      ],
    );
  }

  void initSlidingAnimation() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    slidingAnimation = Tween<Offset>(
      begin: const Offset(0, 3),
      end: Offset.zero,
    ).animate(
      animationController,
    );
    animationController.forward();
  }

  void homeViewNavigation() {
    Future.delayed(
      const Duration(seconds: 3),
      () {
        GoRouter.of(context).push('/home_page');
        // Get.to(
        //   () => const HomeView(),
        //   transition: Transition.fade,
        //   duration: const Duration(seconds: 2),
        // );
      },
    );
  }
}
