part of 'add_meal_cubit.dart';

sealed class AddMealState {}

final class AddMealInitial extends AddMealState {}
final class AddMealLoading extends AddMealState {}
final class AddMealSuccess extends AddMealState {
  final String message;
  AddMealSuccess(this.message);
}
final class AddMealFailed extends AddMealState {
  final String message;
  AddMealFailed(this.message);
}
