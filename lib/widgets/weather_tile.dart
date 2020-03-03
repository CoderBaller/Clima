import 'package:flutter/material.dart';

class WeatherTile extends StatelessWidget {
  final String label;
  final String value;
  WeatherTile(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          this.label,
          style: TextStyle(
              fontWeight: FontWeight.w500, letterSpacing: 5, fontSize: 15),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          this.value,
          style: TextStyle(
            fontSize: 25.0,
            fontWeight: FontWeight.w300,
          ),
        ),
      ],
    );
  }
}
