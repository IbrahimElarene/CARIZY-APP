import 'package:bloc/bloc.dart';
import 'package:cartzy_app/core/model/response/category_response.dart';
import 'package:cartzy_app/core/model/response/product_response.dart';
import 'package:meta/meta.dart';

import '../../../core/data/remote_data/home_api.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  List<CategoryResponse> categories =[];
  List<ProductResponse> products =[];
  List<ProductResponse> productOfCategory =[];
  Future<void> getCategories()async{
    //Loading
    emit(HomeCategoryLoading());


    try{
      //Success
      categories=await HomeApi.getCategories();
      emit(HomeCategorySuccess());
    }catch(e){
      //Error
      emit(HomeCategoryError("Something went wrong"));
    }


  }

  Future<void> getProducts()async{
    //Loading
    emit(HomeProductLoading());

    try{
      //Success
      products=await HomeApi.getProduct();
      emit(HomeProductSuccess());
    }catch(e){
      //Error
      emit(HomeProductError("Something went wrong"));
    }

  }
  Future<void> getProductOfCategory(String id)async{
    //Loading
    emit(HomeProductOfCategoryLoading());

    try{
      //Success
      productOfCategory=await HomeApi.getProductOfCategory(id);
      emit(HomeProductOfCategorySuccess());
    }catch(e){
      //Error
      emit(HomeProductOfCategoryError("Something went wrong"));
    }

  }

}
