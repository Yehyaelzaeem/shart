import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shart/widgets/custom_app_bar.dart';
import '../../../../../core/localization/appLocale.dart';
import '../../../../../core/resources/assets_menager.dart';

class AboutCompanyScreen extends StatelessWidget {
  const AboutCompanyScreen({Key? key, this.text}) : super(key: key);
  final String? text;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 70.h),
        child: CustomAppBar(
          title: getLang(context,'about_company'),hasBackButton: true,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(vertical: 24.h),
                child: Image.asset(ImagesManager.logoCircle),
              ),
              Center(child: Text(text!)),
              SizedBox(height: 20.h,)
            ],
          ),
        ),
      ),
    );
  }
}
