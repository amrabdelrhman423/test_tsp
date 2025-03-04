// Repository
import '../../../../core/Models/character_model.dart';

abstract class CharacterRepository {
  Future<List<Character>> fetchCharacters(int page);
}
