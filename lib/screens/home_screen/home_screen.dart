import 'package:eskalate_interview/providers/country_provider.dart';
import 'package:eskalate_interview/screens/favourites_screen/favourites_screen.dart';
import 'package:eskalate_interview/screens/home_screen/widgets/country_widget.dart';
import 'package:eskalate_interview/screens/search_screen/search_screen.dart';
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
  int _index = 0;
  List screens = [const Home(), const FavouritesScreen()];
  final TextEditingController _searchController = TextEditingController();
  late CountryProvider countryProvider;

  @override
  void initState() {
    super.initState();
    countryProvider = Provider.of<CountryProvider>(context, listen: false);
    Future.microtask(() => countryProvider.fetchCountries());
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFB0C4DE),
      appBar: _index == 0
          ? AppBar(
              backgroundColor: const Color(0xFFB0C4DE),
              leading: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return const SearchScreen();
                      },
                    ),
                  );
                },
                child: const Padding(
                  padding: EdgeInsets.only(left: 15),
                  child: CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.search,
                      color: Colors.grey,
                      size: 25,
                    ),
                  ),
                ),
              ),
            )
          : AppBar(
              backgroundColor: const Color(0xFFB0C4DE),
              centerTitle: true,
              title: Text(
                'Favourites',
                style: GoogleFonts.inter(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
      body: screens[_index],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFFB0C4DE),
        selectedItemColor: const Color(0xFF2A5D9F),
        currentIndex: _index,
        iconSize: 35,
        onTap: (index) {
          setState(() {
            _index = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
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

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Consumer<CountryProvider>(
        builder: (context, countryProvider, child) {
          if (countryProvider.isLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: Color(0xFF2A5D9F),
              ),
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
    );
  }
}
