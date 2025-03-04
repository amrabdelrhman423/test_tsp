import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/Models/character_model.dart';
import '../../domain/useCase/get_characters.dart';

part 'character_bloc_state.dart';

class CharacterCubit extends Cubit<CharacterState> {
  final GetCharacters getCharacters;
  List<Character> characters = [];
  int currentPage = 1;
  bool isFetching = false;

  CharacterCubit(this.getCharacters) : super(CharacterInitial());

  void fetchCharacters() async {
    if (isFetching) return;
    isFetching = true;
    if (currentPage == 1) emit(CharacterLoading());
    try {
      final newCharacters = await getCharacters(currentPage);
      characters.addAll(newCharacters);
      currentPage++;
      emit(CharacterLoaded(characters));
    } catch (e) {
      emit(CharacterError(e.toString()));
    } finally {
      isFetching = false;
    }
  }
}