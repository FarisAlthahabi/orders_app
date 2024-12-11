import 'package:animated_size_and_fade/animated_size_and_fade.dart';
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:image_picker/image_picker.dart';
import 'package:orders_app/features/profile/view/widgets/choose_image_source_widget.dart';
import 'package:orders_app/global/theme/components/colors.dart';
import 'package:orders_app/global/utils/constants.dart';
import 'package:orders_app/global/widgets/main_button.dart';
import 'package:orders_app/global/widgets/main_show_bottom_sheet.dart';
import 'package:orders_app/global/widgets/main_text_field.dart';

abstract class ProfileViewCallBacks {
  void onImageTap();

  Future<void> pickGalleryImage();

  Future<void> pickCameraImage();

  void onFirstNameChanged(String firstName);

  void onFirstNameSubmitted(String firstName);

  void onLastNameChanged(String lastName);

  void onLastNameSubmitted(String lastName);

  void onPhoneNumberChanged(String phoneNumber);

  void onPhoneNumberSubmitted(String phoneNumber);

  void onLocationChanged(String location);

  void onLocationSubmitted(String location);

  void onEditTap();

  void onApplyTap();

  void onCancelTap();
}

@RoutePage()
class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return const ProfilePage();
  }
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    implements ProfileViewCallBacks {
  final firstNameFocusNode = FocusNode();
  final lastNameFocusNode = FocusNode();
  final phoneNumberFocusNode = FocusNode();
  final locationFocusNode = FocusNode();

  bool isReadOnly = true;

  @override
  void dispose() {
    firstNameFocusNode.dispose();
    lastNameFocusNode.dispose();
    phoneNumberFocusNode.dispose();
    locationFocusNode.dispose();
    
    super.dispose();
  }

  @override
  void onFirstNameChanged(String firstName) {
    // TODO: implement onFirstNameChanged
  }

  @override
  void onFirstNameSubmitted(String firstName) {
    lastNameFocusNode.requestFocus();
  }

  @override
  void onPhoneNumberChanged(String phoneNumber) {
    // TODO: implement onPhoneNumberChanged
  }

  @override
  void onPhoneNumberSubmitted(String phoneNumber) {
    locationFocusNode.requestFocus();
  }

  @override
  void onLocationChanged(String location) {
    // TODO: implement onLocationChanged
  }

  @override
  void onLocationSubmitted(String location) {
    locationFocusNode.unfocus();
  }

  @override
  void onLastNameChanged(String lastName) {
    // TODO: implement onLastNameChanged
  }

  @override
  void onLastNameSubmitted(String lastName) {
    phoneNumberFocusNode.requestFocus();
  }

  @override
  void onEditTap() {
    firstNameFocusNode.unfocus();
    lastNameFocusNode.unfocus();
    locationFocusNode.unfocus();
    setState(() {
      isReadOnly = false;
    });
  }

  @override
  void onApplyTap() {
    // TODO: implement onApplyTap
  }

  @override
  void onCancelTap() {
    firstNameFocusNode.unfocus();
    lastNameFocusNode.unfocus();
    locationFocusNode.unfocus();
    setState(() {
      isReadOnly = true;
    });
  }

  @override
  Future<void> pickCameraImage() async {
    context.router.popForced();
    final imagePicker = ImagePicker();
    final image = await imagePicker.pickImage(source: ImageSource.camera);
    if (image != null) {}
  }

  @override
  Future<void> pickGalleryImage() async {
    context.router.popForced();
    final imagePicker = ImagePicker();
    final image = await imagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {}
  }

  @override
  void onImageTap() {
    mainShowBottomSheet(
      context,
      widget: ChooseImageSourceWidget(
        pickCameraImage: pickCameraImage,
        pickGalleryImage: pickGalleryImage,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: AppConstants.padding16,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Bounce(
                onPressed: onImageTap,
                duration: AppConstants.duration200ms,
                child: Center(
                  child: SizedBox(
                    height: 150,
                    width: 150,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: AppColors.greyShade,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.person_2_outlined, size: 120),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 60),
              MainTextField(
                onChanged: onFirstNameChanged,
                onSubmitted: onFirstNameSubmitted,
                focusNode: firstNameFocusNode,
                hintText: "first_name".tr(),
                readOnly: isReadOnly,
                prefixIcon: Icon(Icons.person),
              ),
              SizedBox(height: 30),
              MainTextField(
                onChanged: onLastNameChanged,
                onSubmitted: onLastNameSubmitted,
                focusNode: lastNameFocusNode,
                hintText: "last_name".tr(),
                readOnly: isReadOnly,
                prefixIcon: Icon(Icons.person),
              ),
              SizedBox(height: 30),
              MainTextField(
                onChanged: onPhoneNumberChanged,
                onSubmitted: onPhoneNumberSubmitted,
                focusNode: phoneNumberFocusNode,
                hintText: "phone_number".tr(),
                readOnly: isReadOnly,
                prefixIcon: Icon(Icons.phone),
              ),
              SizedBox(height: 30),
              MainTextField(
                onChanged: onLocationChanged,
                onSubmitted: onLocationSubmitted,
                focusNode: locationFocusNode,
                hintText: "location".tr(),
                readOnly: isReadOnly,
                prefixIcon: Icon(Icons.place),
              ),
              SizedBox(height: 30),
              AnimatedSizeAndFade.showHide(
                show: isReadOnly,
                child: Row(
                  children: [
                    IconButton(
                      onPressed: onEditTap,
                      icon: Icon(Icons.edit),
                      iconSize: 40,
                    ),
                    Text("Edit Profile"),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: AnimatedSizeAndFade.showHide(
        alignment: Alignment.centerRight,
        show: !isReadOnly,
        child: Padding(
          padding: AppConstants.paddingB16,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              MainButton(
                width: 120,
                onPressed: onCancelTap,
                text: "cancel".tr(),
                textColor: AppColors.mainColor,
                buttonColor: AppColors.white,
                border: Border.all(color: AppColors.mainColor, width: 1.5),
              ),
              SizedBox(width: 10),
              MainButton(
                width: 120,
                onPressed: onApplyTap,
                text: "apply".tr(),
              ),
              SizedBox(width: 10),
            ],
          ),
        ),
      ),
    );
  }
}
