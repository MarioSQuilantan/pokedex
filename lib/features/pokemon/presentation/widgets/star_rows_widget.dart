import 'package:flutter/material.dart';

class StarRowsWidget extends StatelessWidget {
  const StarRowsWidget({super.key, required this.keyLabel, required this.color, required this.value});

  final int keyLabel;
  final Color color;
  final num value;

  String _statLabel(int idx) {
    switch (idx) {
      case 0:
        return 'HP';
      case 1:
        return 'ATK';
      case 2:
        return 'DEF';
      case 3:
        return 'SATK';
      case 4:
        return 'SDEF';
      case 5:
        return 'SPD';
      default:
        return 'STAT$idx';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(
            width: 60,
            child: Text(
              _statLabel(keyLabel),
              style: TextStyle(color: color, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(width: 30, child: Text(value.toString())),
          Expanded(
            child: LinearProgressIndicator(
              value: value / 100,
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(color),
            ),
          ),
        ],
      ),
    );
  }
}
