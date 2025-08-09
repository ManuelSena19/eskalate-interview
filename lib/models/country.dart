class Country {
  final String name;
  final String flagUrl;
  final double area;
  final String region;
  final String subregion;
  final int population;
  final List<String> timezones;
  final String capital;
  final List<String> languages;

  Country({
    required this.name,
    required this.flagUrl,
    required this.area,
    required this.region,
    required this.subregion,
    required this.population,
    required this.timezones,
    required this.capital,
    required this.languages,
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    final name = json['name'] as Map<String, dynamic>;
    final commonName = name['common'] as String;

    final flags = json["flags"] as Map<String, dynamic>;
    final flagUrl = flags["png"] as String;

    final List<dynamic> timezones = json['timezones'] as List<dynamic>;
    final List<String> formattedTimezones = timezones.map((tz) {
      final String tzString = tz as String;
      return tzString.split(':').first;
    }).toList();

    final capitals = json["capital"] as List;
    final capital = capitals.first;

    List<String> languages = [];
    if (json['languages'] != null) {
      final Map<String, dynamic> languagesMap =
          json['languages'] as Map<String, dynamic>;
      languages = languagesMap.values.map((value) => value as String).toList();
    }

    return Country(
      name: commonName,
      flagUrl: flagUrl,
      area: json['area'] as double,
      region: json['region'] as String,
      subregion: json['subregion'] as String,
      population: json['population'] as int,
      timezones: formattedTimezones,
      capital: capital,
      languages: languages,
    );
  }
}
