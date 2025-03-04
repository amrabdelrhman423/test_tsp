import 'package:get_it/get_it.dart';

import '../features/characters/data/data_source/remote_data_source.dart';
import '../features/characters/data/repository_imp/character_repository_imp.dart';
import '../features/characters/domain/repository/character_repository.dart';
import '../features/characters/domain/useCase/get_characters.dart';

final getIt = GetIt.instance;

void setupLocator() {

  if (!getIt.isRegistered<CharacterRemoteDataSource>()) {
    getIt.registerLazySingleton<CharacterRemoteDataSource>(() =>
        CharacterRemoteDataSource());
  }

  if (!getIt.isRegistered<CharacterRepository>()) {
    getIt.registerLazySingleton<CharacterRepository>(() =>
        CharacterRepositoryImpl(getIt<CharacterRemoteDataSource>()));
  }
  if (!getIt.isRegistered<GetCharacters>()) {
    getIt.registerLazySingleton<GetCharacters>(() =>
        GetCharacters(getIt<CharacterRepository>()));
  }

}