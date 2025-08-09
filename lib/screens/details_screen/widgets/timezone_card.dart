import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TimezoneCard extends StatefulWidget {
  const TimezoneCard({super.key, required this.label});

  final String label;

  @override
  State<TimezoneCard> createState() => _TimezoneCardState();
}

class _TimezoneCardState extends State<TimezoneCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 60,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.grey,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        widget.label,
        style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
}