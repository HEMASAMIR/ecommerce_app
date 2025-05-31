part of 'favourite_cubit.dart';

@immutable
sealed class FavouriteState {}

final class FavouriteInitial extends FavouriteState {}

class FavoritesInitial extends FavouriteState {}

class FavoritesLoading extends FavouriteState {}

class FavoritesLoaded extends FavouriteState {
  final List<Map<String, dynamic>> favs;

  FavoritesLoaded(this.favs);
}
