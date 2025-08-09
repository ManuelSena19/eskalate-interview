import 'package:eskalate_interview/models/country.dart';
import 'package:eskalate_interview/screens/details_screen/widgets/timezone_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key, required this.country});

  final Country country;

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  bool isFavourite = false;
  final NumberFormat formatter = NumberFormat.decimalPattern();
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          'Country Details',
          style: GoogleFonts.inter(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back,
            size: 30,
            color: Color(0xFF2A5D9F),
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              setState(() {
                isFavourite = !isFavourite;
              });
            },
            child: Icon(
              isFavourite ? Icons.favorite : Icons.favorite_border,
              size: 30,
              color: const Color(0xFF2A5D9F),
            ),
          ),
          const SizedBox(width: 15),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: SizedBox(
                  width: 300,
                  height: 150,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      widget.country.flagUrl,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 60,
              ),
              Text(
                widget.country.name,
                style: GoogleFonts.inter(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                height: 250,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CountryInfoWidget(
                      leading: 'Capital',
                      trailing: widget.country.capital,
                    ),
                    CountryInfoWidget(
                      leading: 'Region',
                      trailing: widget.country.region,
                    ),
                    CountryInfoWidget(
                      leading: 'Sub-region',
                      trailing: widget.country.subregion,
                    ),
                    CountryInfoWidget(
                      leading: 'Population',
                      trailing: formatter.format(widget.country.population),
                    ),
                    CountryInfoWidget(
                      leading: 'Area',
                      trailing: '${widget.country.area} sq km',
                    ),
                    CountryInfoWidget(
                      leading: 'Languages',
                      trailing: widget.country.languages.join(', '),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Timezone',
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                height: 1000,
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 15,
                    childAspectRatio: 2,
                  ),
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: widget.country.timezones.length,
                  itemBuilder: (context, index) {
                    List timezones = widget.country.timezones;
                    return TimezoneCard(label: timezones[index]);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CountryInfoWidget extends StatefulWidget {
  const CountryInfoWidget(
      {super.key, required this.leading, required this.trailing});

  final String leading;
  final String trailing;

  @override
  State<CountryInfoWidget> createState() => _CountryInfoWidgetState();
}

class _CountryInfoWidgetState extends State<CountryInfoWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '${widget.leading}:',
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w500,
            color: Colors.grey,
            fontSize: 15,
          ),
        ),
        Text(
          widget.trailing,
          style: GoogleFonts.inter(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 15,
          ),
        )
      ],
    );
  }
}



