import 'package:flutter/material.dart';

import '../../../../core/core.dart';

class SortDialogWidget extends StatelessWidget {
  const SortDialogWidget({super.key, required this.onUpward, required this.onDownWard, required this.onById});

  final Function() onUpward;
  final Function() onDownWard;
  final Function() onById;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Ordenar por:',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black),
          ),
          GapWidget(12),
          InkWell(
            onTap: onUpward,
            child: Text('Nombre ascendente', style: TextStyle(fontSize: 18, color: Colors.black)),
          ),
          GapWidget(12),
          InkWell(
            onTap: onDownWard,
            child: Text('Nombre descendente', style: TextStyle(fontSize: 18, color: Colors.black)),
          ),
          GapWidget(12),
          InkWell(
            onTap: onById,
            child: Text('Id', style: TextStyle(fontSize: 18, color: Colors.black)),
          ),
        ],
      ),
    );
  }
}
