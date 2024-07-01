part of 'get_discounts_cubit.dart';

@immutable
sealed class GetDiscountsState {}

final class GetDiscountsInitial extends GetDiscountsState {}
final class GetDiscountsLoading extends GetDiscountsState {}
final class GetDiscountsError extends GetDiscountsState {
  final String message;
  GetDiscountsError(this.message);
}
final class GetDiscountsSuccess extends GetDiscountsState {
  final  List<QueryDocumentSnapshot<SaleModel>> discountModel;
  GetDiscountsSuccess(this.discountModel);
}
