part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}
class HomeCategoryLoading extends HomeState{}
class HomeCategorySuccess extends HomeState{}
class HomeCategoryError extends HomeState{
  final String messageError;

  HomeCategoryError(this.messageError);
}
class HomeProductLoading extends HomeState{}
class HomeProductSuccess extends HomeState{}
class HomeProductError extends HomeState{
  final String messageError;

  HomeProductError(this.messageError);

}
class HomeProductOfCategoryLoading extends HomeState{}
class HomeProductOfCategorySuccess extends HomeState{}
class HomeProductOfCategoryError extends HomeState{
  final String messageError;

  HomeProductOfCategoryError(this.messageError);

}