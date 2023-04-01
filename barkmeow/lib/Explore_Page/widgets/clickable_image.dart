// import 'package:flutter/material.dart';
//
// class ClickableImage extends StatelessWidget {
//   final String imageUrl;
//   final String title;
//   final Function onTap;
//
//   const ClickableImage({super.key,
//     required this.imageUrl,
//     required this.title,
//     required this.onTap,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Column(
//         children: [
//           CachedNetworkImage(
//             imageUrl: imageUrl,
//             fit: BoxFit.cover,
//             height: 100.0,
//             width: double.infinity,
//           ),
//           const SizedBox(height: 8.0),
//           Text(
//             title,
//             style: const TextStyle(
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }