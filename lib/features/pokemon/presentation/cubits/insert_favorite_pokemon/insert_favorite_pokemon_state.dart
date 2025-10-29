part of 'insert_favorite_pokemon_cubit.dart';

class InsertFavoritePokemonState extends Equatable {
  const InsertFavoritePokemonState({this.status, this.errorMessage = ''});

  final NetworkStatusEnum? status;
  final String errorMessage;

  InsertFavoritePokemonState copyWith({NetworkStatusEnum? status, String? errorMessage}) =>
      InsertFavoritePokemonState(status: status ?? this.status, errorMessage: errorMessage ?? this.errorMessage);

  @override
  List<Object?> get props => [status, errorMessage];
}
