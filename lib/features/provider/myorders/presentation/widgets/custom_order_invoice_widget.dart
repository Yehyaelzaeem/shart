import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shart/core/localization/appLocale.dart';

import '../../../../../core/resources/assets_menager.dart';
import '../../../../../core/resources/color.dart';
import '../../../../../core/resources/font_manager.dart';
import '../../../../../core/routing/navigation_services.dart';
import '../../../../../core/routing/routes.dart';
import '../../../../user/auth/logic/auth_cubit.dart';
import '../../../../user/myorders/data/model/check_car_model.dart';
import '../../../../user/myorders/data/model/myorder_model.dart';
import '../../../../user/myorders/presentation/screens/invoice_screen.dart';
import '../../../../user/myorders/presentation/screens/report_screen.dart';

class CustomOrderWithInvoiceAndReportWidget extends StatelessWidget {
  const CustomOrderWithInvoiceAndReportWidget({super.key, required this.getCheckCarsModelData});
  final GetCheckCarsModelData getCheckCarsModelData;

  @override
  Widget build(BuildContext context) {
    return  Container(
      // height: 135.h,
      margin: EdgeInsets.only(left: 16.w, right: 16.w, top: 16.h),
      decoration: BoxDecoration(
        border: Border.all(color: greyColor),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        children: <Widget>[
          ClipRRect(
            borderRadius:AuthCubit.get(context).localeLanguage==Locale('en')?
            BorderRadius.only(topLeft: Radius.circular(10.r), bottomLeft: Radius.circular(10.r)):
            BorderRadius.only(topRight: Radius.circular(10.r), bottomRight: Radius.circular(10.r)),
            child: Container(
              padding: const EdgeInsets.all(0.0),
              width: 134.w,
              height: 100.h,
              decoration: BoxDecoration(color: packagesColor),
              child: Image.network(
                getCheckCarsModelData.package!.image!,
                fit: BoxFit.cover,
                errorBuilder: (BuildContext context,Object error,StackTrace? v){
                  return Image.asset(ImagesManager.holder,fit: BoxFit.cover,);
                },
              ),
            ),
          ),
          SizedBox(width: 8.w),
          Container(
            width: 80.w ,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                FittedBox(
                  child: Text(
                    getCheckCarsModelData.package!.title!,
                    style: TextStyle(
                      fontWeight: FontWeightManager.bold,
                      fontSize: 16.sp,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                FittedBox(
                  child: Text(
                    '${getCheckCarsModelData.package!.price!} ${getLang(context, 'rs')}',
                    style: TextStyle(
                      fontWeight: FontWeightManager.regular,
                      fontSize: 16.sp,
                      color: Color(0xffDB3022),
                    ),
                  ),
                )
              ],
            ),
          ),
          Spacer(),
          Container(
            margin: EdgeInsets.only(top: 10.h,bottom: 10.h),
            child: Column(
              children: <Widget>[
                InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>
                        ReportScreen(getCheckCarsModelData: getCheckCarsModelData,)));
                    // NavigationManager.push(Routes.report);
                  },
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.info_outline,
                          size: 15, color: Colors.grey.shade400),
                      SizedBox(width: 2),
                      FittedBox(
                        child: Text('${getLang(context, 'view_inspection')}',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 10)),
                      ),
                    ],
                  ),
                ),
                Container(
                    width: 80.w,
                    height: 1,
                    color: Colors.black,
                    margin: EdgeInsets.only(top: 0, bottom: 5)),

                InkWell(
                  onTap: () {
                    // NavigationManager.push(Routes.invoice);

                    // Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>
                    //     InvoiceScreen( myOrdersModelData: data,)));
                  },
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.remove_red_eye_rounded,
                          size: 15, color: Colors.grey.shade400),
                      SizedBox(width: 1),
                      Text('${getLang(context, 'view_invoice')}', style: TextStyle(fontSize: 9)),
                    ],
                  ),
                ),                  Container(
                    width: 80.w,
                    height: 1,
                    color: Colors.black,
                    margin: EdgeInsets.only(top: 0, bottom: 15)),
                Container(
                  height:24.h ,
                  width:87.w ,
                  margin: EdgeInsets.zero,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50.r),
                    color: Color(0xff136B79),
                  ),
                  child: Center(
                    child: Text(
                      '${getLang(context, 'checked')}',
                      style: TextStyle(
                        color: whiteColor,
                        fontSize: 12.sp,
                        fontWeight: FontWeightManager.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 8.w),
        ],
      ),
    );
  }
}
