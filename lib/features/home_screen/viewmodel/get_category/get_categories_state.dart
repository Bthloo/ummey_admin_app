part of 'get_categories_cubit.dart';

@immutable
sealed class GetCategoriesState {}

final class GetCategoriesInitial extends GetCategoriesState {}
final class GetCategoriesLoading extends GetCategoriesState {}
final class GetCategoriesSuccess extends GetCategoriesState {
 final List<QueryDocumentSnapshot<CategoryModel>> categories;
 GetCategoriesSuccess(this.categories);
}
final class GetCategoriesFailure extends GetCategoriesState {
 final String message;
  GetCategoriesFailure(this.message);
}
