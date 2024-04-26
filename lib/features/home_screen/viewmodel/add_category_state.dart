part of 'add_category_cubit.dart';

@immutable
sealed class AddCategoryState {}

final class AddCategoryInitial extends AddCategoryState {}
final class AddCategoryLoading extends AddCategoryState{}
final class AddCategorySuccess extends AddCategoryState{
  final String? message;
  AddCategorySuccess(this.message);
}
final class AddCategoryFailed extends AddCategoryState{
  final String? message;
  AddCategoryFailed(this.message);
}

