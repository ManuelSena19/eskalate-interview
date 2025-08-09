import 'dart:convert';

import 'package:eskalate_interview/models/country.dart';
import 'package:http/http.dart' as http;

class CountryService{
  final String apiUrl = "https://restcountries.com/v3.1/independent?status=true&fields=name,population,flag,area,region,subregion,timezones,flags,capital,languages";

  Future<List<Country>> fetchCountries() async{
    final url = Uri.parse(apiUrl);
    final response = await http.get(url);

    if(response.statusCode == 200){
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Country.fromJson(json)).toList();
    }
    else{
      throw Exception('Failed to fetch data');
    }
  }
}