import 'dart:convert';

import '../../../../core/constants/app_constants.dart';
import '../models/CharacterResponse.dart';
import 'package:http/http.dart' as http;

class CharacterRemoteDataSource {
  Future<CharacterResponse> getCharacters(int page) async {
    final response = await http.get(Uri.parse('${AppConstants.baseUrl}character/?page=$page'));

    if (response.statusCode == 200) {
      return CharacterResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load characters');
    }
  }
}
