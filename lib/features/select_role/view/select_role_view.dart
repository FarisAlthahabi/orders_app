import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orders_app/features/select_role/model/user_role_enum/user_role_enum.dart';
import 'package:orders_app/global/gen/assets.gen.dart';
import 'package:orders_app/global/repos/user_repo.dart';
import 'package:orders_app/global/router/router.gr.dart';
import 'package:orders_app/global/theme/components/colors.dart';
import 'package:orders_app/global/theme/components/shadows.dart';
import 'package:orders_app/global/utils/constants.dart';
import 'package:orders_app/global/widgets/main_button.dart';

abstract class SelectRoleViewCallBacks {
  void onPressed(UserRoleEnum userRole);
}

@RoutePage()
class SelectRoleView extends StatelessWidget {
  const SelectRoleView({super.key});

  @override
  Widget build(BuildContext context) {
    return const SelectRolePage();
  }
}

class SelectRolePage extends StatefulWidget {
  const SelectRolePage({super.key});

  @override
  State<SelectRolePage> createState() => _SelectRolePageState();
}

class _SelectRolePageState extends State<SelectRolePage>
    implements SelectRoleViewCallBacks {
  late final UserRepo userRepo = context.read();
  @override
  void onPressed(UserRoleEnum userRole) {
    userRepo.setKey(UserRepo.keys.isFirstTime, false);
    userRepo.setKey(UserRepo.keys.userRole, userRole.name);
    context.router.popAndPush(SignUpRoute());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: AppConstants.padding16,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 40),
              Text(
                "select_your_role".tr(),
                style: TextStyle(
                  color: AppColors.black,
                  fontSize: 30,
                  height: 1.3,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(height: 25),
              Image.asset(
                Assets.images.selectRole.path,
                scale: 0.7,
              ),
              // Spacer(),
              ...UserRoleEnum.values.map(
                (role) => Column(
                  children: [
                    MainButton(
                      onPressed: () => onPressed(role),
                      text: role.displayName,
                      buttonColor: AppColors.white,
                      textColor: AppColors.black,
                      border:
                          Border.all(width: 1.3, color: AppColors.mainColor),
                      borderRadius: AppConstants.borderRadius32,
                      shadow: AppShadows.shadow1,
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                    ),
                    SizedBox(height: 25),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
