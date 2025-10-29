part of 'delete_favorite_pokemon_cubit.dart';

class DeleteFavoritePokemonState extends Equatable {
  const DeleteFavoritePokemonState({this.status, this.errorMessage = ''});

  final NetworkStatusEnum? status;
  final String errorMessage;

  DeleteFavoritePokemonState copyWith({NetworkStatusEnum? status, String? errorMessage}) =>
      DeleteFavoritePokemonState(status: status ?? this.status, errorMessage: errorMessage ?? this.errorMessage);

  @override
  List<Object?> get props => [status, errorMessage];
}
