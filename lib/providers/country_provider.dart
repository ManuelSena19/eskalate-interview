import 'package:eskalate_interview/models/country.dart';
import 'package:eskalate_interview/services/country_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CountryProvider with ChangeNotifier {
  final CountryService countryService = CountryService();

  List<Country> _countries = [];
  List<Country> get countries => _countries;

  List<Country> _filteredCountries = [];
  List<Country> get filteredCountries => _filteredCountries;

  List<String> _favourites = [];
  List<String> get favourites => _favourites;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<void> fetchCountries() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await loadFavourites();
      await Future.delayed(const Duration(seconds: 2));
      final countries = await countryService.fetchCountries();

      _countries = countries;
    } catch (e) {
      _errorMessage = 'Failed to load data';
      debugPrint("Error: ${e.toString()}");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void searchCountries(String query) {
    if (query.isEmpty) {
      _filteredCountries = [];
    } else {
      _filteredCountries = _countries.where((country) {
        return country.name.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }
    notifyListeners();
  }

  Future<void> loadFavourites() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _favourites = prefs.getStringList('favourites') ?? [];
    notifyListeners();
  }

  Future<void> saveFavourites() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('favourites', _favourites);
  }

  void toggleFavourite(String name) {
    if (_favourites.contains(name)) {
      _favourites.remove(name);
    } else {
      _favourites.add(name);
    }
    saveFavourites();
    notifyListeners();
  }

  bool isFavourite(String name) {
    return _favourites.contains(name);
  }

  List<Country> get favouriteCountries {
    return _countries
        .where((country) => _favourites.contains(country.name))
        .toList();
  }
}
