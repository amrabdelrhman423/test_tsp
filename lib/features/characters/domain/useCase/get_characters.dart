import '../../../../core/Models/character_model.dart';
import '../repository/character_repository.dart';

class GetCharacters {
  final CharacterRepository repository;

  GetCharacters(this.repository);

  Future<List<Character>> call(int page) async {
    return await repository.fetchCharacters(page);
  }
}