import 'package:flutter/material.dart';
import 'menu_exploration.dart';

class MainMenuExploration extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade800,
      child: Center(
        child: MenuExploration(
          options: ['Easy', 'Normal', 'Hard', 'Expert'],
          selectedValue: 'Expert',
          height: MediaQuery.of(context).size.height * 0.1,
          width: MediaQuery.of(context).size.width / 2,
          onChanged: (val) {
            print("Current Value: $val");
          },
        ),
      ),
    );
  }
}
