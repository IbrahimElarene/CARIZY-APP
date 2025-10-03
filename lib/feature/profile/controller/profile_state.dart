part of 'profile_cubit.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}
class GetProfileLoading extends ProfileState{}
class GetProfileSuccess extends ProfileState{}
class GetProfileError extends ProfileState{
  final String massageError;

  GetProfileError(this.massageError);

}
class UpdateProfileLoading extends ProfileState{}
class UpdateProfileSuccess extends ProfileState{}
class UpdateProfileError extends ProfileState{
  final String massageError;

  UpdateProfileError(this.massageError);

}
