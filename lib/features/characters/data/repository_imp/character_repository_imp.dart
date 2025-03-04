import '../../../../core/Models/character_model.dart';
import '../../domain/repository/character_repository.dart';
import '../data_source/remote_data_source.dart';

class CharacterRepositoryImpl implements CharacterRepository {
  final CharacterRemoteDataSource remoteDataSource;

  CharacterRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Character>> fetchCharacters(int page) async {
    final response = await remoteDataSource.getCharacters(page);
    return response.results;
  }
}