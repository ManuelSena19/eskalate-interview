import 'package:eskalate_interview/models/country.dart';
import 'package:eskalate_interview/providers/country_provider.dart';
import 'package:eskalate_interview/screens/home_screen/widgets/country_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavouritesScreen extends StatefulWidget {
  const FavouritesScreen({super.key});

  @override
  State<FavouritesScreen> createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends State<FavouritesScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Consumer<CountryProvider>(
        builder: (context, countryProvider, child) {
          if (countryProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          final favourites = countryProvider.favouriteCountries;
          if (favourites.isEmpty) {
            return const Center(
              child: Text(
                'No favourite countries added yet. Add them from the home screen',
                textAlign: TextAlign.center,
              ),
            );
          }
          return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 20,
                crossAxisSpacing: 10,
                childAspectRatio: 0.8,
              ),
              itemCount: favourites.length,
              itemBuilder: (context, index) {
                Country country = favourites[index];
                return CountryWidget(
                  country: country,
                );
              });
        },
      ),
    );
  }
}
