import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shart/core/localization/appLocale.dart';
import 'package:shart/core/resources/color.dart';
import 'package:shart/core/resources/font_manager.dart';
import 'package:shart/core/routing/navigation_services.dart';
import 'package:shart/widgets/custom_menu_top_log_widget.dart';
import 'package:shart/features/user/menu/presentation/menu/widget/custom_services_type_widget.dart';
import 'package:shart/widgets/custom_text_field.dart';
import '../../../../../core/resources/assets_menager.dart';
import '../../../../../core/routing/routes.dart';
import '../../../../../widgets/custom_alert_dialog.dart';
import '../../../../../widgets/custom_slider_widget.dart';
import '../../../../../widgets/custom_welcome_message.dart';
import '../../logic/menu_cubit.dart';

class UserMenuScreen extends StatefulWidget {
  const UserMenuScreen({Key? key}) : super(key: key);
  @override
  State<UserMenuScreen> createState() => _UserMenuScreenState();
}
class _UserMenuScreenState extends State<UserMenuScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (_) async {
        CustomDialogs.showAlertDialog(
          type: DialogType.warning,
          btnOkOnPress: () {
            exit(0);
          },
          ctx: context,
          btnCancelOnPress: () {},
          title: 'الخروج',
          desc: 'هل أنت متأكد من أنك تريد  الخروج ؟',
          btnOkText: 'نعم',
          btnCancelText: 'لا',
        );
        // NavigationManager.pushReplacement(Routes.login);
      },
      child: Scaffold(
        backgroundColor: whiteColor,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(height: 30.h,),
                CustomTopRowLogo(type: 'user',),
                CustomWelcomeMessage(),
                Padding(
                  padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 16.h),
                  child: InkWell(
                    onTap: (){
                      NavigationManager.push(Routes.store);
                    },
                    child: CustomTextField(
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.black
                      ),
                      hintText:  getLang(context, 'hit_message'),
                      enabled: false,
                      hintColor: blackColor,
                      hintFontFamily: FontConstants.lateefFont,
                      controller: searchController,
                      prefixIcon: Icon(Icons.search_outlined, color: greyColor),
                    ),
                  ),
                ),
                CustomSliderWidget(),
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: EdgeInsets.only(left: 16.w, right: 16.w),
                    child: Text(
                      getLang(context, 'our_services'),
                      style: TextStyle(
                        fontSize: 30.sp,
                        fontWeight: FontWeightManager.medium,
                        fontFamily: FontConstants.lateefFont,
                      ),
                    ),
                  ),
                ),
                CustomServicesTypeWidget(
                  onTap: (){
                    MenuCubit.get(context).getPackageCheck(context);
                    NavigationManager.push(Routes.checkingPackages);
                  },
                  image: ImagesManager.car1,
                  text:  getLang(context, 'check_cars'),
                  color: carCheckColor,
                ),
                CustomServicesTypeWidget(
                  onTap: (){
                    NavigationManager.push(Routes.spareParts);
                  },
                  image: ImagesManager.oil,
                  text:  getLang(context, 'spare_parts'),
                  color: carCheckColor2,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}