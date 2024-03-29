import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shart/core/localization/appLocale.dart';
import '../../../../../core/resources/color.dart';
import '../../../../../core/resources/font_manager.dart';
import '../../../../user/products/presentation/screens/product_details_screen.dart';
import '../../data/models/provider_order_model.dart';

class CustomProductProviderWidgetOrder extends StatelessWidget {
 final ItemsProvider items;
 final String status;
  const CustomProductProviderWidgetOrder({super.key, required this.items, required this.status});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        List<String> list= [];
        for(var a in items.providerProduct!.images!){
          list.add(a.image.toString());
        }
        Navigator.push(context, MaterialPageRoute(builder:
            (BuildContext context)=>ProductDetailsScreen(
          title: items.providerProduct!.title!,
          price: items.providerProduct!.price.toString() ,
          brandName:items.providerProduct!.brand!=null?items.providerProduct!.brand!.name:'',
          width:'${items.providerProduct!.width!=null?items.providerProduct!.width!:''}',
          height:'${items.providerProduct!.height!=null?items.providerProduct!.height!:''}',
          images:list,
          modelName: items.providerProduct!.modal!=null?items.providerProduct!.modal!.name:'',
          size:'${items.providerProduct!.size!=null?items.providerProduct!.size!:''}',
          productStatus: items.providerProduct!.productStatus,
          description:items.providerProduct!.description,
              id: items.providerProduct!.id! ,
              isFav: items.providerProduct!.isFav,
        )));
      },
      child: Container(
        height: 115.h,
        margin: EdgeInsets.only(top: 16.h),
        decoration: BoxDecoration(
          border: Border.all(color: greyColor),
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Row(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width*0.35,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10.r),
                    bottomRight: Radius.circular(10.r)),
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  height: 115.h,
                  decoration: BoxDecoration(color: packagesColor),
                  child: Image.network(
                    items.providerProduct!.images![0].image!,
                    fit: BoxFit.fill,
                    errorBuilder: (BuildContext context,Object error ,StackTrace? v){
                      return Center(child: CircularProgressIndicator(),);
                    },
                  ),
                ),
              ),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SizedBox(height: 5,),
                  Text(
                    items.providerProduct!.brand!=null?items.providerProduct!.brand!.name!:'',
                    style: TextStyle(
                      fontWeight: FontWeightManager.light,
                      fontSize: 12.sp,
                      color: Colors.grey.shade700,
                    ),
                  ),
                  FittedBox(
                    child: Text(
                      items.providerProduct!.title!,
                      style: TextStyle(
                        fontWeight: FontWeightManager.bold,
                        fontSize: 16.sp,
                      ),
                    ),
                  ),
                  Text(
                    // items.provider!.name!,
                    '${getLang(context, 'qty')} : ${items.qty.toString()}',
                    style: TextStyle(
                      fontWeight: FontWeightManager.regular,
                      fontSize: 16.sp,
                    ),
                  ),
                  Text(
                    '${items.providerProduct!.price} ${getLang(context, 'rs')}',
                    style: TextStyle(
                      fontWeight: FontWeightManager.regular,
                      fontSize: 16.sp,
                      color: Color(0xffDB3022),
                    ),
                  ),

                ],
              ),
            ),
            SizedBox(width: 5.w),
            // Container(
            //   height: 33,
            //   width: 80.w,
            //   margin: EdgeInsets.zero,
            //   decoration: BoxDecoration(
            //       color: Color(0xff136B79),
            //       borderRadius: BorderRadius.all(Radius.circular(20.r))
            //   ),
            //   child: Center(
            //     child: Text(
            //       '${getLang(context, '${status}')}',
            //       style: TextStyle(
            //         color: whiteColor,
            //         fontSize: 12.sp,
            //         fontWeight: FontWeightManager.bold,
            //       ),
            //     ),
            //   ),
            // ) ,
            // SizedBox(width: 15.w,)
          ],
        ),
      ),
    );
  }
}
