import 'package:flutter/material.dart';
import 'package:barkmeow/size_configs.dart';

class BreedIdentifier extends StatefulWidget {
  const BreedIdentifier({super.key});

  @override
  State<BreedIdentifier> createState() => _BreedIdentifierState();
}

class _BreedIdentifierState extends State<BreedIdentifier> {
  @override
  Widget build(BuildContext context) {
    //get screen size configuration
    SizeConfig().init(context);
    double screenHeight = SizeConfig.screenHeight!;
    double screenWidth = SizeConfig.screenWidth!;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            height: screenHeight * 0.4,
            width: screenWidth,
            child: Container(),
          ),
          Positioned(
            top: screenHeight * 0.35,
            height: screenHeight * 0.65,
            width: screenWidth,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(36.0),
                  topRight: Radius.circular(36.0),
                ),
              ),
              child: Column(
                children: const [
                  SizedBox(
                    height: 80,
                  ),
                  Text("Prediction"),
                  Text("Golden Retriver"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
