part of 'seat_cubit.dart';

@immutable
sealed class SeatState {}

final class SeatInitial extends SeatState {}
final class SeatLoading extends SeatState{}
final class SeatSuccess extends SeatState{}
final class SeatError extends SeatState{
  final String message;
  SeatError(this.message);
}

