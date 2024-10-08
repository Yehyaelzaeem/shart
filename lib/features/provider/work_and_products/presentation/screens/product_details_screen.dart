import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shart/core/localization/appLocale.dart';
import 'package:shart/widgets/custom_app_bar.dart';
import '../../../../../core/resources/assets_menager.dart';
import '../../data/model/get_products_list_model.dart';

class ProviderProductDetailsScreen extends StatelessWidget {
  const ProviderProductDetailsScreen({Key? key, required this.getProductsModelData}) : super(key: key);
  final GetProductsModelData getProductsModelData;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 70.h),
        child: CustomAppBar(
          title: '${getLang(context, 'product_details')}',
          hasBackButton: true,
        ),
      ),
      body: SingleChildScrollView(
          child: Container(
        padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 24.h),
        margin: EdgeInsets.only(top: 24.h),
        decoration: BoxDecoration(
            border: Border.all(color: Color(0xffD0D5DD)),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              '${getLang(context, 'type')}',
              style: TextStyle(
                  fontSize: 14.sp,
                  fontFamily: 'Lateef',
                  fontWeight: FontWeight.w500),
            ),
            TextField(
                decoration:
                    InputDecoration(hintText: '${
                        getLang(context, '${getProductsModelData.type}')}', enabled: false)),
            SizedBox(height: 25.h),
            Text(
              '${getLang(context, 'product_name')}',
              style: TextStyle(
                  fontSize: 14.sp,
                  fontFamily: 'Lateef',
                  fontWeight: FontWeight.w500),
            ),
            TextField(
                decoration: InputDecoration(hintText: '${getProductsModelData.title}', enabled: false)),
            SizedBox(height: 25.h),
            getProductsModelData.brand!=null?
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${getLang(context, 'brand')}',
                  style: TextStyle(
                      fontSize: 14.sp,
                      fontFamily: 'Lateef',
                      fontWeight: FontWeight.w500),
                ),
                TextField(
                    decoration: InputDecoration(hintText: '${getProductsModelData.brand!=null?getProductsModelData.brand!.name!:""}', enabled: false)),
                SizedBox(height: 25.h),
              ],
            ):SizedBox.shrink(),
            getProductsModelData.type!='spare_parts'?
           Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               Text(
                 '${getLang(context, 'width')}',
                 style: TextStyle(
                     fontSize: 14.sp,
                     fontFamily: 'Lateef',
                     fontWeight: FontWeight.w500),
               ),
               TextField(
                   decoration: InputDecoration(hintText: '${getProductsModelData.width!.name}', enabled: false)),
               SizedBox(height: 25.h),
               Text(
                 '${getLang(context, 'height')}',
                 style: TextStyle(
                     fontSize: 14.sp,
                     fontFamily: 'Lateef',
                     fontWeight: FontWeight.w500),
               ),
               TextField(
                   decoration: InputDecoration(hintText: '${getProductsModelData.height!.name}', enabled: false)),
               SizedBox(height: 25.h),
               Text(
                 '${getLang(context, 'size')}',
                 style: TextStyle(
                     fontSize: 14.sp,
                     fontFamily: 'Lateef',
                     fontWeight: FontWeight.w500),
               ),
               TextField(
                   decoration:
                   InputDecoration(hintText: '${getProductsModelData.size!.name}', enabled: false)),
             ],
           ):SizedBox.shrink(),
            SizedBox(height: 25.h),
            Text(
              '${getLang(context, 'status')}',
              style: TextStyle(
                  fontSize: 14.sp,
                  fontFamily: 'Lateef',
                  fontWeight: FontWeight.w500),
            ),
            TextField(
                decoration:
                    InputDecoration(hintText: '${getProductsModelData.productStatus}', enabled: false)),
            Padding(
              padding: EdgeInsets.only(top: 25.h, bottom: 10.h),
              child: Text(
                '${getLang(context, 'des')}',
                style: TextStyle(
                    fontSize: 14.sp,
                    fontFamily: 'Lateef',
                    fontWeight: FontWeight.w500),
              ),
            ),
            Text(
             '${getProductsModelData.description}',
              style: TextStyle(
                color: Color(0xff4B4B4B),
                fontSize: 16.sp,
              ),
            ),
            SizedBox(height: 25.h),
            Text(
              '${getLang(context, 'rim_image')}',
              style: TextStyle(
                  fontSize: 14.sp,
                  fontFamily: 'Lateef',
                  fontWeight: FontWeight.w500),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                  itemCount: getProductsModelData.images!.length,
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    mainAxisSpacing: 5,
                  ),
                  itemBuilder: (context, index) {
                    return Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: index != 0 ? 4 : 0),
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: Image.network('${getProductsModelData.images![index].image}',
                        errorBuilder: (context,error,v){
                          return Image.asset(ImagesManager.holder,fit: BoxFit.cover,);
                        },
                      ),
                    );
                  }),
            ),
            Padding(
              padding: EdgeInsets.only(top: 25.h, bottom: 10.h),
              child: Text(
                '${getLang(context, 'rim_price')}',
                style: TextStyle(
                    fontSize: 14.sp,
                    fontFamily: 'Lateef',
                    fontWeight: FontWeight.w500),
              ),
            ),
            Text(
              '${getProductsModelData.price} ${getLang(context, 'rs')}',
              style: TextStyle(fontSize: 16.sp),
            ),
            SizedBox(height: 50,)
          ],
        ),
      )),
    );
  }
}
