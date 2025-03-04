import '../../../../core/Models/character_model.dart';
import 'info_model.dart';

class CharacterResponse {
  final Info info;
  final List<Character> results;

  CharacterResponse({required this.info, required this.results});

  factory CharacterResponse.fromJson(Map<String, dynamic> json) {
    return CharacterResponse(
      info: Info.fromJson(json['info']),
      results: List<Character>.from(json['results'].map((x) => Character.fromJson(x))),
    );
  }
}
