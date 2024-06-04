import 'dart:convert';
import 'package:covid_tracker_app/Models/world_state_models.dart';
import 'package:http/http.dart' as http;

class StateServices {
  Future<WorldStateModel> fetchWorldStateRecords() async {
    final response =
        await http.get(Uri.parse('https://disease.sh/v3/covid-19/all'));

    if (response.statusCode == 200) {
      try {
        return WorldStateModel.fromJson(jsonDecode(response.body));
      } catch (e) {
        throw Exception('Failed to parse world state data: $e');
      }
    } else {
      throw Exception('Failed to load world state data');
    }
  }

  Future<List<dynamic>> countriesListApi() async {
    final response =
        await http.get(Uri.parse('https://disease.sh/v3/covid-19/countries'));

    if (response.statusCode == 200) {
      try {
        return jsonDecode(response.body) as List<dynamic>;
      } catch (e) {
        throw Exception('Failed to parse countries list: $e');
      }
    } else {
      throw Exception('Failed to load countries list');
    }
  }
}
