import 'package:eskalate_interview/providers/country_provider.dart';
import 'package:eskalate_interview/screens/home_screen/widgets/country_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../models/country.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index = 0;
  late CountryProvider countryProvider;
  @override
  void initState() {
    super.initState();
    countryProvider = Provider.of<CountryProvider>(context, listen: false);
    Future.microtask(() => countryProvider.fetchCountries());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE6F0FA),
      appBar: AppBar(
        backgroundColor: const Color(0xFFE6F0FA),
        centerTitle: true,
        title: SizedBox(
          height: 40,
          child: SearchBar(
            backgroundColor: const WidgetStatePropertyAll(Colors.white),
            elevation: const WidgetStatePropertyAll(0),
            hintText: "Search countries...",
            hintStyle: WidgetStatePropertyAll(
              GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
            leading: const Icon(
              Icons.search,
              size: 30,
              color: Colors.grey,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Consumer<CountryProvider>(
          builder: (context, countryProvider, child) {
            if (countryProvider.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (countryProvider.errorMessage != null) {
              return Center(
                child: Text(countryProvider.errorMessage!),
              );
            }
            if (countryProvider.countries.isEmpty) {
              return const Center(
                child: Text('No countries located'),
              );
            }
            List<Country> countries = countryProvider.countries;
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 20,
                childAspectRatio: 0.8,
              ),
              itemCount: countries.length,
              itemBuilder: (BuildContext context, index) {
                Country country = countries[index];
                return CountryWidget(
                  country: country,
                );
              },
            );
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFFE6F0FA),
        selectedItemColor: const Color(0xFF2A5D9F),
        currentIndex: index,
        iconSize: 35,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            activeIcon: Icon(Icons.favorite),
            label: 'Favourites',
          ),
        ],
      ),
    );
  }
}
