import 'package:eskalate_interview/models/country.dart';
import 'package:eskalate_interview/providers/country_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../home_screen/widgets/country_widget.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xFFB0C4DE),
        title: SizedBox(
          width: MediaQuery.of(context).size.width - 30,
          height: 40,
          child: SearchBar(
            controller: _searchController,
            elevation: const WidgetStatePropertyAll(0),
            leading: const Icon(
              Icons.search,
              size: 25,
              color: Colors.grey,
            ),
            hintText: 'Search countries...',
            hintStyle: WidgetStatePropertyAll(
              GoogleFonts.inter(
                fontWeight: FontWeight.w500,
                fontSize: 18,
                color: Colors.grey,
              ),
            ),
            onChanged: (query) {
              Provider.of<CountryProvider>(context, listen: false)
                  .searchCountries(query);
            },
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Consumer<CountryProvider>(
          builder: (context, countryProvider, child){
            if(_searchController.text.isEmpty){
              return const SizedBox();
            }
            final List<Country> countries = countryProvider.filteredCountries;
            if(countries.isEmpty){
              return const Center(child: Text("No countries matching your search"),);
            }
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
    );
  }
}
