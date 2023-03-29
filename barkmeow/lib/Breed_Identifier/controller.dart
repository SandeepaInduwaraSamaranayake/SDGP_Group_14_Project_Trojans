import 'dart:io';
import 'package:flutter/material.dart';
import 'package:barkmeow/size_configs.dart';
import 'package:barkmeow/Bottom_Nav_Bar/nav_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:tflite/tflite.dart';

import 'circular_percentage_indicator.dart';

class BreedIdentifier extends StatefulWidget {
  const BreedIdentifier({super.key});

  @override
  State<BreedIdentifier> createState() => _BreedIdentifierState();
}

class _BreedIdentifierState extends State<BreedIdentifier> {
  late File _image; // to hold the image user select.
  late List _results; // to hold the output of CNN Model.
  late List _percentages = []; // to hold the percentages only.
  late List _labels = []; // to hold the labels only
  bool imageSelect = false; // to hold boolean whether image is selected or not.
  final ImagePicker _picker =
      ImagePicker(); // to hold the image picker() object.

  @override
  void initState() {
    super.initState();
    loadModel();
  }

  Future loadModel() async {
    Tflite.close();
    String res;
    res = (await Tflite.loadModel(
        model: "assets/ml_model/mymodel.tflite",
        labels: "assets/ml_model/mylabels.txt"))!;
    print("Models loading status: $res");
  }

  Future pickCameraImage() async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 100,
    );
    if (pickedFile != null) {
      File image = File(pickedFile.path);
      imageClassification(image);
    }
  }

  Future pickGalleryImage() async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 100,
    );
    if (pickedFile != null) {
      File image = File(pickedFile.path);
      imageClassification(image);
    }
  }

  Future imageClassification(File image) async {
    _labels = [];
    _percentages = [];
    final List? recognitions = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 6,
      threshold: 0.005,
      imageMean: 0,
      imageStd: 255,
    );
    setState(() {
      _results = recognitions!;
      _image = image;
      imageSelect = true;

      if (_results != null) {
        for (final recognition in recognitions) {
          print('Index: ${recognition['index']}');
          print('Label: ${recognition['label']}');
          print('Confidence: ${recognition['confidence']}');

          recognition['confidence'] = recognition['confidence'] * 100;
        }

        for (final recognition in recognitions) {
          _labels.add(recognition['label'] +
              " \n" +
              recognition['confidence'].toStringAsFixed(2) +
              "%");
          _percentages.add(recognition['confidence']);
        }

        print(_labels.toString());
        print(_percentages.toString());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    //get screen size configuration.
    SizeConfig().init(context);
    double screenHeight = SizeConfig.screenHeight!;
    double screenWidth = SizeConfig.screenWidth!;
    int currentIndex = 4;

    return Scaffold(
      backgroundColor: Colors.white,
      //Navigator Bar
      bottomNavigationBar: BottomNavigation(
        currentIndex: currentIndex,
      ),
      body: Stack(
        children: [
          Positioned(
            height: screenHeight * 0.4,
            width: screenWidth,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: imageSelect
                      ? FileImage(_image) as ImageProvider
                      : const AssetImage(
                          "assets/images/identifier/identify.jpg"),
                ),
              ),
            ),
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
                children: [
                  const SizedBox(
                    height: 80,
                  ),
                  const Text(
                    "Prediction",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 40,
                      //fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "80% Golden Retriver",
                    style: TextStyle(fontSize: 20, color: Colors.green),
                  ),
                  const SizedBox(
                    height: 90,
                  ),
                  PercentageIndicator(
                      percentages: _percentages,
                      colors: const [
                        Colors.red,
                        Colors.green,
                        Colors.blue,
                        Colors.orange,
                        Colors.purple,
                        Colors.brown,
                      ],
                      size: 150.0,
                      labels: _labels),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          InkWell(
                            onTap: pickCameraImage,
                            child: const CircleAvatar(
                              radius: 50.0,
                              backgroundColor: Colors.blue,
                              child: Icon(
                                Icons.photo_camera,
                                color: Colors.white,
                                size: 40,
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(20.0),
                            child: Text(
                              "Take Photo",
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 90,
                      ),
                      Column(
                        children: [
                          InkWell(
                            onTap: pickGalleryImage,
                            child: const CircleAvatar(
                              radius: 50.0,
                              backgroundColor: Colors.blue,
                              child: Icon(
                                Icons.photo_library,
                                color: Colors.white,
                                size: 40,
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(20.0),
                            child: Text(
                              "Gallary",
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// class BreedIdentifier extends StatefulWidget {
//   const BreedIdentifier({Key? key}) : super(key: key);

//   @override
//   _TfliteModelState createState() => _TfliteModelState();
// }

// class _TfliteModelState extends State<BreedIdentifier> {
//   late File _image;
//   late List _results;
//   bool imageSelect = false;
//   @override
//   void initState() {
//     super.initState();
//     loadModel();
//   }

//   Future loadModel() async {
//     Tflite.close();
//     String res;
//     res = (await Tflite.loadModel(
//         model: "assets/ml_model/mymodel.tflite",
//         labels: "assets/ml_model/mylabels.txt"))!;
//     print("Models loading status: $res");
//   }

//   Future imageClassification(File image) async {
//     final List? recognitions = await Tflite.runModelOnImage(
//       path: image.path,
//       numResults: 6,
//       threshold: 0.005,
//       imageMean: 0,
//       imageStd: 255,
//     );
//     setState(() {
//       _results = recognitions!;
//       _image = image;
//       imageSelect = true;

//       if (_results != null) {
//         for (final recognition in recognitions) {
//           print('Index: ${recognition['index']}');
//           print('Label: ${recognition['label']}');
//           print('Confidence: ${recognition['confidence']}');

//           recognition['confidence'] = recognition['confidence'] * 100;
//         }
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Image Classification"),
//       ),
//       body: ListView(
//         children: [
//           (imageSelect)
//               ? Container(
//                   margin: const EdgeInsets.all(10),
//                   child: Image.file(_image),
//                 )
//               : Container(
//                   margin: const EdgeInsets.all(10),
//                   child: const Opacity(
//                     opacity: 0.8,
//                     child: Center(
//                       child: Text("No image selected"),
//                     ),
//                   ),
//                 ),
//           SingleChildScrollView(
//             child: Column(
//               children: (imageSelect)
//                   ? _results.map((result) {
//                       return Card(
//                         child: Container(
//                           margin: EdgeInsets.all(10),
//                           child: Text(
//                             "${result['label']} - ${result['confidence'].toStringAsFixed(0)}%",
//                             style: const TextStyle(
//                                 color: Colors.red, fontSize: 20),
//                           ),
//                         ),
//                       );
//                     }).toList()
//                   : [],
//             ),
//           )
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: pickImage,
//         tooltip: "Pick Image",
//         child: const Icon(Icons.image),
//       ),
//     );
//   }

//   Future pickImage() async {
//     final ImagePicker _picker = ImagePicker();
//     final XFile? pickedFile = await _picker.pickImage(
//       source: ImageSource.gallery,
//       imageQuality: 100,
//     );
//     File image = File(pickedFile!.path);
//     imageClassification(image);
//   }
// }
