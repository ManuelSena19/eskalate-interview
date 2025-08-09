import 'package:eskalate_interview/models/country.dart';
import 'package:eskalate_interview/services/country_service.dart';
import 'package:flutter/material.dart';

class CountryProvider with ChangeNotifier{
  final CountryService countryService = CountryService();

  List<Country> _countries = [];
  List<Country> get countries => _countries;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<void> fetchCountries() async{
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try{
      final countries = await countryService.fetchCountries();

      _countries = countries;
    }
    catch (e){
      _errorMessage = 'Failed to load data';
      debugPrint("Error: ${e.toString()}");
    }
    finally{
      _isLoading = false;
      notifyListeners();
    }
  }

  List<Country> searchCountries(String query){
    if(query.isEmpty){
      return _countries;
    }
    return _countries.where((country){
      return country.name.toLowerCase().contains(query.toLowerCase());
    }).toList();
  }
}