import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'cubit/dates_cubit.dart';
import 'cubit/dates_state.dart';

class UploadFileScreen extends StatefulWidget {
  const UploadFileScreen({super.key});

  @override
  _UploadFileScreenState createState() => _UploadFileScreenState();
}

class _UploadFileScreenState extends State<UploadFileScreen> {
  static const double paddingSize = 20.0;
  static const double imageContainerHeightFactor = 0.25;
  static const Color buttonColor = Color(0xff503C3C);

  File? _filePath;

  void _showResultModal(BuildContext context, String dateVariety, String cultivationLocation, String description) {
    double screenHeight = MediaQuery.of(context).size.height;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      backgroundColor: Colors.white,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.all(paddingSize),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: screenHeight * 0.02),
              Text(
                "Date Variety: $dateVariety",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff3C3D37),
                ),              ),
              SizedBox(height: screenHeight * 0.02),
              Text(
                "Cultivation Location: $cultivationLocation",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff3C3D37),
                ),              ),
              SizedBox(height: screenHeight * 0.02),
              Text(
                "Description: $description",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff3C3D37),
                ),              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: paddingSize),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: screenHeight * 0.05),
                BlocBuilder<DatesCubit, DatesState>(
                  builder: (context, state) {
                    return GestureDetector(
                      onTap: () => showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                        ),
                        backgroundColor: Colors.white,
                        builder: (context) {
                          return Padding(
                            padding: EdgeInsets.all(paddingSize),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: 80,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextButton(
                                    onPressed: () async {
                                      final XFile? photo = await ImagePicker().pickImage(
                                        source: ImageSource.camera,
                                      );

                                      if (photo != null) {
                                        setState(() {
                                          _filePath = File(photo.path);
                                        });
                                      }
                                      Navigator.pop(context);
                                    },
                                    child: Text("Camera" ,style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xff3C3D37),
                                    ),             ),
                                  ),
                                  SizedBox(width: 50),

                                  TextButton(
                                    onPressed: () async {
                                      final XFile? photo = await ImagePicker().pickImage(
                                        source: ImageSource.gallery,
                                      );

                                      if (photo != null) {
                                        setState(() {
                                          _filePath = File(photo.path);
                                        });
                                      }
                                      Navigator.pop(context);
                                    },
                                    child: Text("Gallery", style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xff3C3D37),
                                    ),             ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                      child: Container(
                        width: MediaQuery.of(context).size.width * .80,
                        height: screenHeight * imageContainerHeightFactor,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 1.5),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: _filePath == null
                            ? Semantics(
                          label: "Click to choose an Image",
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.cloud_upload,
                                size: 40,
                                color: Colors.grey,
                              ),
                              SizedBox(height: 10),
                              Text(
                                "Click to choose an Image",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        )
                            : Image.file(
                          _filePath!,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(height: screenHeight * 0.03),

                ElevatedButton(
                  onPressed: () {
                    if (_filePath != null) {
                      BlocProvider.of<DatesCubit>(context).dates(_filePath!);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: buttonColor,
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    "RESULT",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
                SizedBox(height: screenHeight * 0.03),

                BlocListener<DatesCubit, DatesState>(
                  listener: (context, state) {
                    if (state is DatesSuccess) {
                      _showResultModal(
                        context,
                        state.prediction.dateVariety ?? 'Unknown',
                        state.prediction.cultivationLocation ?? 'Location not found',
                        state.prediction.description ?? 'No description available',
                      );
                    } else if (state is DatesError) {
                      _showResultModal(
                        context,
                        'Error',
                        'N/A',
                        state.message,
                      );
                    }
                  },
                  child: Container(), // Empty container since listener does not return a widget
                ),

                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _filePath = null;
                    });
                    BlocProvider.of<DatesCubit>(context).emit(DatesInitial());
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: buttonColor,
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    "CLEAR",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
