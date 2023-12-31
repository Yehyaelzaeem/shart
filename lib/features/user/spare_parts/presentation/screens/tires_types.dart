import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shart/core/routing/navigation_services.dart';
import 'package:shart/widgets/custom_app_bar.dart';

import '../../../../../core/resources/assets_menager.dart';
import '../../../../../core/resources/font_manager.dart';
import '../../../../../core/routing/routes.dart';

class TiresTypesScreen extends StatefulWidget {
  const TiresTypesScreen({Key? key}) : super(key: key);

  @override
  State<TiresTypesScreen> createState() => _TiresTypesScreenState();
}

class _TiresTypesScreenState extends State<TiresTypesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 80.h),
        child: CustomAppBar(title: 'خدمات الإطارات  ',hasBackButton: true),
      ),
      body: Column(
        children: <Widget>[
          GestureDetector(
            onTap: () => NavigationManager.push(Routes.tires),
            child: Container(
              margin: EdgeInsets.all(16.w),
              width: double.infinity,
              height: 103.h,
              decoration: BoxDecoration(
                color: Color.fromRGBO(253, 142, 59, 0.70),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    ImagesManager.aetar,
                    width: 95.w,
                    height: 75.h,
                  ),
                  SizedBox(width: 15.w),
                  Text(
                    'الإطارات',
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeightManager.light,
                      fontFamily: FontConstants.lateefFont,
                    ),
                  ),
                  SizedBox(width: 15.w),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () => NavigationManager.push(Routes.rims),
            child: Container(
              margin: EdgeInsets.all(16.w),
              width: double.infinity,
              height: 103.h,
              decoration: BoxDecoration(
                color: Color.fromRGBO(158, 140, 182, 0.70),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    ImagesManager.rim,
                    width: 95.w,
                    height: 75.h,
                  ),
                  SizedBox(width: 15.w),
                  Text(
                    'الجنوط',
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeightManager.light,
                      fontFamily: FontConstants.lateefFont,
                    ),
                  ),
                  SizedBox(width: 15.w),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
