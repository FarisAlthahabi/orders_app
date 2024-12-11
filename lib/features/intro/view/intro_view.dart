import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:orders_app/features/intro/view/intro_view_item.dart';
import 'package:orders_app/global/gen/assets.gen.dart';
import 'package:orders_app/global/router/router.gr.dart';
import 'package:orders_app/global/theme/components/colors.dart';
import 'package:orders_app/global/utils/constants.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

abstract class IntroViewCallBacks {
  void onPressed();
}

@RoutePage()
class IntroView extends StatelessWidget {
  const IntroView({super.key});

  @override
  Widget build(BuildContext context) {
    return const IntroPage();
  }
}

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> implements IntroViewCallBacks {
  final controller = PageController(keepPage: true);

  @override
  void onPressed() {
    if (controller.page == 3) {
      context.router.push(SelectRoleRoute());
    } else {
      controller.nextPage(
        duration: AppConstants.duration1s,
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final introImages = [
      Assets.images.introFirst.path,
      Assets.images.introSecond.path,
      Assets.images.introThird.path,
      Assets.images.introFourth.path,
    ];

    final introTitles = [
      "hello".tr(),
      "geolocation".tr(),
      "payment_method".tr(),
      "relax".tr(),
    ];

    final introSubTitles = [
      "choose_and_select".tr(),
      "creatr_address".tr(),
      "pay_by_net_or_when_arrive".tr(),
      "our_delivery_do".tr(),
    ];

    final pages = List.generate(
      4,
      (index) => IntroViewItem(
        image: introImages[index],
        title: introTitles[index],
        subtitle: introSubTitles[index],
      ),
    );

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 32,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 50),
              ExpandablePageView.builder(
                physics: NeverScrollableScrollPhysics(),
                controller: controller,
                itemCount: 4,
                itemBuilder: (context, index) {
                  return pages[index];
                },
              ),
              Spacer(),
              Center(
                child: SmoothPageIndicator(
                  controller: controller,
                  count: pages.length,
                  effect: const ExpandingDotsEffect(
                    activeDotColor: AppColors.mainColor,
                    dotHeight: 16,
                    dotWidth: 16,
                  ),
                ),
              ),
              SizedBox(height: 80),
              Text(
                "next".tr(),
                style: TextStyle(
                  color: AppColors.blackShade,
                  fontSize: 20,
                  height: 1.46,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: FloatingActionButton(
          onPressed: onPressed,
          shape: RoundedRectangleBorder(
            borderRadius: AppConstants.circularBorderRadius,
          ),
          backgroundColor: AppColors.mainColor,
          child: const Icon(
            Icons.arrow_forward,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
