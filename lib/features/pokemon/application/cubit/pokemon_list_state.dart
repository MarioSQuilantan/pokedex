import 'package:equatable/equatable.dart';

import '../../domain/domain.dart';

abstract class PokemonItemsState extends Equatable {
  const PokemonItemsState();

  @override
  List<Object> get props => [];
}

class PokemonItemsInitial extends PokemonItemsState {}

class PokemonItemsLoading extends PokemonItemsState {}

class PokemonItemsLoaded extends PokemonItemsState {
  final List<PokemonEntity> items;
  final bool hasMore;
  final bool isLoadingMore;

  const PokemonItemsLoaded(this.items, {this.hasMore = true, this.isLoadingMore = false});

  @override
  List<Object> get props => [items, hasMore, isLoadingMore];
}

class PokemonItemsFailure extends PokemonItemsState {
  final String message;

  const PokemonItemsFailure(this.message);

  @override
  List<Object> get props => [message];
}
