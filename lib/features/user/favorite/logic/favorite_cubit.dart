import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shart/features/user/auth/logic/auth_cubit.dart';

import '../data/data_base/data_base.dart';
import '../data/model/favorite_model.dart';
part 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit() : super(FavoriteInitial());
  static FavoriteCubit get(BuildContext context)=>BlocProvider.of(context);
  FavoriteRemoteDataSource favoriteRemoteDataSource =FavoriteRemoteDataSource();
  bool isFav=true;
  FavoriteProductsUser? favoriteProductsUser;
  Future getFavoriteProducts(String token,BuildContext context)async{
    favoriteRemoteDataSource.getFavoriteProducts(token, context).then((value) {
      favoriteProductsUser=value!;
      emit(GetFavoritesState());
    });
  }
  Future addAndRemoveFavoriteProducts(String id ,String token,BuildContext context)async{
    favoriteRemoteDataSource.addAndRemoveFavoriteProducts( id,token, context);
    emit(AddAndRemoveFavoritesState());
  }
  void changeFav(bool x){
    isFav=x;
    emit(ChangeIconFavoritesState());

  }
}