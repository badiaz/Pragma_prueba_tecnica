import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:catbreeds/domain/entities/entities.dart';

abstract class ICatApiRepository {
  Future<List<BreedEntity>> getBreeds({required int page});
  Future<List<BreedEntity>> searchBreeds({required String query});
}

class CatApiRepository implements ICatApiRepository {
  final String _apiKey =
      'live_99Qe4Ppj34NdplyLW67xCV7Ds0oSLKGgcWWYnSzMJY9C0QOu0HUR4azYxWkyW2nr';
  final String _baseUrl = 'https://api.thecatapi.com/v1';

  @override
  Future<List<BreedEntity>> getBreeds({required int page}) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/breeds?limit=10&page=$page'),
      headers: {
        'x-api-key': _apiKey,
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((json) => BreedEntity.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load breeds');
    }
  }

  @override
  Future<List<BreedEntity>> searchBreeds({required String query}) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/breeds/search?q=$query'),
      headers: {'x-api-key': _apiKey},
    );

    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((json) => BreedEntity.fromJson(json)).toList();
    } else {
      throw Exception('Failed to search breeds');
    }
  }
}
