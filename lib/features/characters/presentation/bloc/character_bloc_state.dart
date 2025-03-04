part of 'character_bloc_cubit.dart';

sealed class CharacterState extends Equatable {
  const CharacterState();
}

final class CharacterInitial extends CharacterState {
  @override
  List<Object> get props => [];
}
class CharacterLoading extends CharacterState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class CharacterLoaded extends CharacterState {
  final List<Character> characters;

  const CharacterLoaded(this.characters);

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class CharacterError extends CharacterState {
  final String message;

  const CharacterError(this.message);

  @override
  // TODO: implement props
  List<Object?> get props => [];
}
