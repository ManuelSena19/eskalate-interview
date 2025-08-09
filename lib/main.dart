import 'package:eskalate_interview/providers/country_provider.dart';
import 'package:eskalate_interview/screens/home_screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CountryProvider>(
          create: (context) => CountryProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          scaffoldBackgroundColor: const Color(0xFFB0C4DE),
          useMaterial3: true,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
