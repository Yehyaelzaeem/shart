
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shart/features/user/menu/data/model/product_model.dart';
import 'package:shart/features/user/menu/presentation/search/widgets/custom_product.dart';
import '../../../../../core/localization/appLocale.dart';
import '../../../../../core/resources/color.dart';
import '../../../../../core/resources/font_manager.dart';
import '../../../../../core/resources/themes/styles/styles.dart';
import '../../../../../widgets/custom_app_bar.dart';
import '../../../../../widgets/custom_text_field.dart';
import '../../../../../widgets/show_toast_widget.dart';
import '../../../auth/logic/auth_cubit.dart';
import '../../../cart/data/model/cart_model.dart';
import '../../../favorite/logic/favorite_cubit.dart';
import '../../../merchants/logic/merchants_cubit.dart';
import '../../../merchants/presentation/screens/merchants_details_screen.dart';
import '../../../products/presentation/screens/product_details_screen.dart';
import '../../logic/menu_cubit.dart';
import '../spare_parts/widgets/spare_part_item.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});
  @override
  Widget build(BuildContext context) {
    MenuCubit cubit = MenuCubit.get(context);
    MerchantsCubit merchantsCubit =MerchantsCubit.get(context);
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(double.infinity, 70.h),
          child: CustomAppBar(title: getLang(context,'search'),hasBackButton: true,),
        ),

        body:
        BlocConsumer<MenuCubit, MenuState>(
          listener: (BuildContext context,MenuState state) {},
          builder: (BuildContext context,MenuState state) {
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 25.h,),
                      Stack(
                        children: [
                          CustomTextField(
                            contentVerticalPadding: 16,
                            borderColor: greyColor,
                            hintText: getLang(context, 'hit_message'),
                            hintStyle: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                                color: greyColor
                            ),
                            textInputAction: TextInputAction.search,
                            onFieldSubmitted: (String v){
                              cubit.searchProducts(name :cubit.searchControllerHome.text,context: context);
                              merchantsCubit.getSearchMerchants(v,context);

                            },
                            prefixIcon: const Icon(Icons.search, color: greyColor,),
                            controller: cubit.searchControllerHome,
                            onChanged: (String value) {
                              if(value.isNotEmpty){
                                cubit.changeSearchStart(true);
                                cubit.searchProducts(name :value,context: context);
                                merchantsCubit.getSearchMerchants(value,context);
                              }else{
                                cubit.changeSearchStart(false);
                              }
                            },
                          ),
                          cubit.isSearchStart==true?
                          Positioned(
                              left: 5,
                              top: 3,
                              bottom: 3,
                              child:
                              Container(
                                width: 30.w,
                                color: Colors.white,
                                child: Center(
                                  child: IconButton(
                                    onPressed: (){
                                      cubit.searchControllerHome.text='';
                                      cubit.changeSearchStart(false);
                                    },
                                    icon: Icon(Icons.clear,
                                      color: blueColor,
                                    ),
                                  ),
                                ),
                              ),
                          ):SizedBox.shrink(),
                        ],
                      ),
                      SizedBox(height: 20.h,),
                      cubit.isSearchStart?
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            height: 145.h,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text('${getLang(context, 'merchants')}',
                                  style: TextStyles.font16BlackColor500WeightTajawal.copyWith(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 24,
                                    fontFamily: FontConstants.lateefFont,
                                    color:Colors.black,
                                  ),),
                                SizedBox(height: 16.h,),
                                BlocConsumer<MerchantsCubit, MerchantsState>(
                                  listener: (BuildContext context,MerchantsState state) {},
                                  builder: (BuildContext context,MerchantsState state) {
                                    if(merchantsCubit.merchantsSearchModel!=null){
                                      if(merchantsCubit.merchantsSearchModel!.data!.length==0){
                                        return  Center(child: Text('${getLang(context, 'no_data_mer')}',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold
                                        ),),);
                                      }
                                      else{
                                        return Expanded(child:
                                        ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount: merchantsCubit.merchantsSearchModel!.data!.length,
                                            itemBuilder: (BuildContext context,int index){
                                              return InkWell(
                                                onTap: (){
                                                  merchantsCubit.reStart();
                                                  merchantsCubit.getProductsMerchants(merchantsCubit.merchantsSearchModel!.data![index].id!, context);
                                                  merchantsCubit.getWorksMerchants(merchantsCubit.merchantsSearchModel!.data![index].id!, context);
                                                  merchantsCubit.getAddressMerchants(merchantsCubit.merchantsSearchModel!.data![index].id!, context);
                                                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>
                                                      MerchantsDetailsScreen(merchantsModelData:merchantsCubit.merchantsSearchModel!.data![index],)));
                                                },
                                                child: Container(
                                                  width: 100.w,
                                                  height: 70.h,
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: <Widget>[
                                                      Container(
                                                        width:60.w,
                                                        height: 60.h,
                                                        child: ClipRRect(
                                                          borderRadius: BorderRadius.circular(10),
                                                          child: Image.network(merchantsCubit.merchantsSearchModel!.data![index].logo!,
                                                          fit: BoxFit.cover,
                                                          errorBuilder: (BuildContext context,Object error,StackTrace? v){
                                                            return Center(child: CircularProgressIndicator(),);
                                                          },),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Text(merchantsCubit.merchantsSearchModel!.data![index].name!,
                                                          style: TextStyles.font16BlackColor500WeightTajawal.copyWith(
                                                            fontWeight: FontWeight.w500,
                                                            fontSize: 18,
                                                            fontFamily: FontConstants.lateefFont,
                                                            color:Colors.black,
                                                          ),
                                                          maxLines: 2,
                                                          textAlign: TextAlign.center,
                                                          overflow: TextOverflow.ellipsis,
                                                        ),
                                                      ),

                                                    ],
                                                  ),
                                                ),
                                              );
                                            }),
                                        );
                                      }
                                    }else{

                                      return Center(child: CircularProgressIndicator(),);                                    }

                                  },
                                )

                              ],
                            ),
                          ),
                          SizedBox(height: 10.h,),
                          Text('${getLang(context, 'products')}',
                            style: TextStyles.font16BlackColor500WeightTajawal.copyWith(
                              fontWeight: FontWeight.w500,
                              fontSize: 24,
                              fontFamily: FontConstants.lateefFont,
                              color:Colors.black,
                            ),),
                          SizedBox(height: 15.h,),
                          cubit.searchProductModel!=null?
                          cubit.searchProductModel!.data!.length!=0?
                          GridView.builder(
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 9.w,
                                mainAxisSpacing: 15.h,
                                mainAxisExtent: 180.h,
                              ),
                              itemBuilder: (BuildContext context, int index) {
                                ProductModelData data2 = cubit.searchProductModel!.data![index];
                                return Stack(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        ProductModelData data = cubit.searchProductModel!.data![index];
                                        List<String> list= [];
                                        for(Images a in data.images!){
                                          list.add(a.image.toString());
                                        }
                                        Navigator.push(context, MaterialPageRoute(builder:
                                            (BuildContext context)=>ProductDetailsScreen(
                                              id: data.id!,
                                              isFav: data.isFav,
                                          title: data.title,
                                          price: data.price.toString() ,
                                          brandName:data.brand!=null?data.brand!.name:'',
                                          width:'${data.width!=null?data.width!.name:''}',
                                          height:'${data.height!=null?data.height!.name:''}',
                                          images: list,
                                          size:'${data.size!=null?data.size!.name:''}',
                                          productStatus: data.productStatus,
                                          description:data.description ,
                                          cartProduct: Cart(
                                              id: data2.id,
                                              productId: data2.id.toString(),
                                              productName: data2.title,
                                              productPrice: data2.price,
                                              description: data2.description,
                                              image: data2.images![0].image,
                                              type: data2.type,
                                              productState: data2.productStatus,
                                              providerId: data2.provider!=null?data2.provider!.id!.toString():'',
                                              count: 1,
                                              productBrand: data2.brand!=null?data2.brand!.name:''),

                                        )));
                                        // NavigationManager.push(Routes.productDetails);
                                      },
                                      child:
                                      CustomProductItemSearch(productModelData: cubit.searchProductModel!.data![index] ,)
                                    ),
                                    Positioned(
                                        top: 8.h,
                                        right: 16.w,
                                        child:
                                        StatefulBuilder(builder: (BuildContext context,void Function(void Function()) setState){
                                          return  data2.isFav==true?
                                          InkWell(
                                            onTap: (){
                                              if(AuthCubit.get(context).token.isNotEmpty){
                                                setState(() {
                                                  data2.isFav=false;
                                                });
                                                FavoriteCubit.get(context).addAndRemoveFavoriteProducts(data2.id.toString(),AuthCubit.get(context).token,context);

                                              }else{
                                                showToast(text: getLang(context, 'Log_in_first'), state: ToastStates.error, context: context);
                                              }
                                            },
                                            child: CircleAvatar(
                                                minRadius: 12.sp,
                                                backgroundColor: whiteColor,
                                                child:
                                                Icon(
                                                  Icons.favorite,
                                                  color: Colors.red,
                                                  size: 15.sp,
                                                )
                                            ),
                                          ) :
                                          InkWell(
                                            onTap: (){
                                              if(AuthCubit.get(context).token.isNotEmpty){
                                                setState(() {
                                                  data2.isFav=true;
                                                });
                                                FavoriteCubit.get(context).addAndRemoveFavoriteProducts(data2.id.toString(),AuthCubit.get(context).token,context);
                                              }else{
                                                showToast(text: getLang(context, 'Log_in_first'), state: ToastStates.error, context: context);
                                              }
                                            },
                                            child: CircleAvatar(
                                              minRadius: 12.sp,
                                              backgroundColor: whiteColor,
                                              child:
                                              Icon(
                                                Icons.favorite_border_rounded,
                                                color: Colors.grey,
                                                size: 15.sp,
                                              ),
                                            ),
                                          );
                                        })
                                    ),
                                  ],
                                );
                              },
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: cubit.searchProductModel!.data!.length,
                              padding: EdgeInsets.symmetric(horizontal: 16.w)):
                          Padding(
                            padding:  EdgeInsets.only(top:MediaQuery.of(context).size.height*0.3),
                            child: Center(child: Text(getLang(context, 'no_product_found'),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold
                              ),),),
                          ) :
                          Padding(
                            padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height*0.32),
                            child: Center(child: CircularProgressIndicator()),
                          ),
                        ],
                      ):
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: 120.h,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('${getLang(context, 'merchants')}',
                                style: TextStyles.font16BlackColor500WeightTajawal.copyWith(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 24,
                                  fontFamily: FontConstants.lateefFont,
                                  color:Colors.black,
                                ),),
                                Expanded(
                                  child: Center(
                                    child: Text(getLang(context, 'search_no_mer'),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 17.sp,
                                            fontWeight: FontWeight.w400,
                                            color: geryTextColor.withOpacity(0.4),
                                            fontFamily: 'Lateef'
                                        )
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                         SizedBox(height: 30.h,),
                          Text('${getLang(context, 'products')}',
                            style: TextStyles.font16BlackColor500WeightTajawal.copyWith(
                              fontWeight: FontWeight.w500,
                              fontSize: 24,
                              fontFamily: FontConstants.lateefFont,
                              color:Colors.black,
                            ),),
                          SizedBox(height: 100.h,),
                          Center(
                            child: Text(getLang(context, 'search_no'),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 17.sp,
                                    fontWeight: FontWeight.w400,
                                    color: geryTextColor.withOpacity(0.4),
                                    fontFamily: 'Lateef'
                                )
                            ),
                          ),


                        ],
                      ),


                    ],
                  ),
                ),
              ),
            );
          },
        )
    );
  }
}
