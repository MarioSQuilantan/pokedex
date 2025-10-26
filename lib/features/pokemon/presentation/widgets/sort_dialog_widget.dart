// import 'package:flutter/material.dart';

// import '../../../../core/core.dart';

// class SortDialogWidget extends StatelessWidget {
//   const SortDialogWidget({super.key, required this.onUpward, required this.onDownWard, required this.onById});

//   final Function() onUpward;
//   final Function() onDownWard;
//   final Function() onById;

//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//       contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
//       content: Column(
//         mainAxisSize: MainAxisSize.min,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           const Text(
//             'Ordenar por:',
//             style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black),
//           ),
//           Gap(12),
//           TextButton(
//             onPressed: onUpward,
//             child: Text('Nombre ascendente', style: TextStyle(fontSize: 18, color: Colors.black)),
//           ),
//           Gap(12),
//           TextButton(
//             onPressed: onDownWard,
//             child: Text('Nombre descendente', style: TextStyle(fontSize: 18, color: Colors.black)),
//           ),
//           Gap(12),
//           TextButton(
//             onPressed: onById,
//             child: Text('Id', style: TextStyle(fontSize: 18, color: Colors.black)),
//           ),
//         ],
//       ),
//     );
//   }
// }
