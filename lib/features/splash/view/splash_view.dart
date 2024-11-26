import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:orders_app/global/gen/assets.gen.dart';
import 'package:orders_app/global/mixins/post_frame_mixin.dart';
import 'package:orders_app/global/router/router.gr.dart';

@RoutePage()
class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return const SpashPage();
  }
}

class SpashPage extends StatefulWidget {
  const SpashPage({super.key});

  @override
  State<SpashPage> createState() => _SpashPageState();
}

class _SpashPageState extends State<SpashPage> with PostFrameMixin {
  @override
  void onPostFrame() {
    Future.delayed(
      Duration(seconds: 2),
      () {
        if (mounted) {
          context.router.push(IntroRoute());
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Assets.images.logo.svg(),
            SizedBox(height: 20),
            Text(
              "kaba_delivery".tr(),
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                height: 1.24,
                color: Color(0xFFCD1F45),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
