part of 'add_ingredient_cubit.dart';

@immutable
sealed class AddIngredientState {}

final class AddIngredientInitial extends AddIngredientState {}
final class AddIngredientLoading extends AddIngredientState {}
final class AddIngredientSuccess extends AddIngredientState {}
final class AddIngredientFailure extends AddIngredientState {
  final String message;
  AddIngredientFailure(this.message);
}
