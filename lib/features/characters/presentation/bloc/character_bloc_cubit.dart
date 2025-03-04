import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/Models/character_model.dart';
import '../../domain/useCase/get_characters.dart';

part 'character_bloc_state.dart';

class CharacterBloc extends Cubit<CharacterState> {
  final GetCharacters getCharacters;

  CharacterBloc(this.getCharacters) : super(CharacterInitial());

  Future<void> fetchCharacters(int page) async {
    try {
      emit(CharacterLoading());
      final characters = await getCharacters(page);
      emit(CharacterLoaded(characters));
    } catch (e) {
      emit(CharacterError(e.toString()));
    }
  }
}