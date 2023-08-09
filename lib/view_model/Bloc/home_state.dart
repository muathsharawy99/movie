part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class GetMoviesLoading extends HomeState{}
class GetMoviesSuccess extends HomeState{}
class GetMoviesError extends HomeState{}

class GetDetailsLoading extends HomeState{}
class GetDetailsSuccess extends HomeState{}
class GetDetailsError extends HomeState{}