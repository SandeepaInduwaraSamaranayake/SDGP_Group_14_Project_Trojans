import 'dart:io';
import 'package:barkmeow/Breed_Identifier/widgets/camera_action_btn.dart';
import 'package:barkmeow/Breed_Identifier/widgets/action_text.dart';
import 'package:barkmeow/Breed_Identifier/widgets/gallary_action_button.dart';
import 'package:flutter/material.dart';
import 'package:barkmeow/size_configs.dart';
import 'package:barkmeow/Bottom_Nav_Bar/nav_bar.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';
import 'package:barkmeow/Breed_Identifier/widgets/circular_percentage_indicator.dart';

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
  late List _percentLabels = []; // to hold label and the percentage.
  final List _colors = const [
    // hold colors for circular percentage indicator.
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.orange,
    Colors.purple,
    Colors.brown,
  ];
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
    final List? recognitions = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 6,
      threshold: 0.00005, // 0.005
      imageMean: 0,
      imageStd: 255,
    );
    setState(() {
      _results = recognitions!;
      _image = image;
      imageSelect = true;
      _labels = [];
      _percentages = [];
      _percentLabels = [];

      if (_results != null) {
        for (final recognition in recognitions) {
          recognition['confidence'] = recognition['confidence'] * 100;
          _percentages.add(recognition['confidence']);
          _labels.add(recognition['label']);

          _percentLabels.add(recognition['label'] +
              " -" +
              recognition['confidence'].toStringAsFixed(2) +
              "%");
        }
        //print(_percentLabels.toString());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]); // <-- This line will block screen rotation

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
                  SizedBox(
                    height: screenHeight * 0.04, // 20
                  ),
                  Text(
                    "Prediction",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: screenWidth * 0.08, // 40
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.02, // 10
                  ),
                  Text(
                    _percentages.isEmpty
                        ? ""
                        : _percentages[0].toStringAsFixed(2) +
                            " % " +
                            _labels[0].toString(),
                    style: TextStyle(
                      fontSize: screenWidth * 0.04, //20
                      color: Colors.green,
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.02, //50
                  ),
                  Padding(
                    padding: EdgeInsets.all(screenWidth * 0.03), //10
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        PercentageIndicator(
                          percentages: _percentages,
                          colors: _colors,
                          size: screenWidth * 0.3, //165
                        ),
                        SizedBox(
                          height: screenHeight * 0.23, //200
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              for (int i = 0; i < _labels.length; i++)
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: screenWidth * 0.01, //10
                                    vertical: screenHeight * 0.002, //3
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: screenWidth * 0.03, //15
                                        height: screenWidth * 0.03, //15
                                        decoration: BoxDecoration(
                                          color: _colors[i],
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      SizedBox(
                                        width: screenWidth * 0.01, //10
                                      ),
                                      SizedBox(
                                        width: screenWidth * 0.5,
                                        child: Text(
                                          _percentLabels[i],
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 3,
                                          softWrap: false,
                                          style: TextStyle(
                                            color: _colors[i],
                                            fontSize: screenWidth * 0.032, //16
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.01, // 40
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          InkWell(
                            onTap: pickCameraImage,
                            child: const CameraActionButton(),
                          ),
                          const ActionText(
                            text: "Take Photo",
                          ),
                        ],
                      ),
                      SizedBox(
                        width: screenWidth * 0.3, // 90
                      ),
                      Column(
                        children: [
                          InkWell(
                              onTap: pickGalleryImage,
                              child: const GallaryActionButton()),
                          const ActionText(
                            text: "Gallary",
                          )
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
