import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import 'package:thcMobile/components/authTextInput.dart';
import 'package:thcMobile/components/authUploadInput.dart';
import 'package:thcMobile/components/backButtonWhite.dart';
import 'package:thcMobile/components/buttonBlue.dart';
import 'package:thcMobile/components/dropdownWidget.dart';
import 'package:thcMobile/helpers/sizeCalculator.dart';
import 'package:thcMobile/helpers/store.dart';
import 'package:thcMobile/provider/user.dart';

class EConsulattion extends StatefulWidget {
  @override
  _EConsulattionState createState() => _EConsulattionState();
}

class _EConsulattionState extends State<EConsulattion> {
  File _image;
  final picker = ImagePicker();
  bool loading = false;
  TextEditingController patientComplaint = new TextEditingController();
  TextEditingController reasonForSession = new TextEditingController();
  TextEditingController levelOfSeverity = new TextEditingController();
  TextEditingController priorMedications = new TextEditingController();
  TextEditingController currentTreatment = new TextEditingController();
  TextEditingController doctorPreference = new TextEditingController();
  TextEditingController symptoms = new TextEditingController();
  TextEditingController durationOfIssue = new TextEditingController();
  TextEditingController feverOrCold = new TextEditingController();
  TextEditingController physicalSymptoms = new TextEditingController();
  TextEditingController recentSurgeries = new TextEditingController();
  TextEditingController medicalConditions = new TextEditingController();
  TextEditingController medicationsForConditions = new TextEditingController();
  TextEditingController treatmentsLikePhysiotherapy =
      new TextEditingController();
  TextEditingController familyHistory = new TextEditingController();
  TextEditingController alcoholConsumption = new TextEditingController();
  TextEditingController smoking = new TextEditingController();
  TextEditingController allergies = new TextEditingController();
  TextEditingController additionalInfo = new TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  void pickImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  void handleSubmit() async {
    setState(() => loading = true);
    String url = Provider.of<UserModel>(context, listen: false).baseUrl;
    String token = Provider.of<UserModel>(context, listen: false).token;
    String id = Provider.of<UserModel>(context, listen: false).id;

    var response = await http.post(url + 'e-consultation/', headers: {
      "Connection": 'keep-alive',
      "Authorization": "Bearer " + token
    }, body: {
      "doctor": null,
      "hospital": null,
      "patient": id,
      "patient_complaint": patientComplaint,
      "reason_for_session": reasonForSession,
      "level_of_severity": levelOfSeverity,
      "prior_medications": priorMedications,
      "current_treatment": currentTreatment,
      "doctor_preference": doctorPreference,
      "symptoms": symptoms,
      "duration_of_issue": durationOfIssue,
      "fever_or_cold": feverOrCold,
      "physical_symptoms": physicalSymptoms,
      "recent_Surgeries": recentSurgeries,
      "medical_conditions": medicalConditions,
      "medications_for_conditions": medicationsForConditions,
      "treatments_like_physiotherapy": treatmentsLikePhysiotherapy,
      "family_history": familyHistory,
      "alcohol_consumption": alcoholConsumption,
      "smoking": smoking,
      "allergies": allergies,
      "additional_info": additionalInfo,
      "picture": _image,
    });

    print(response.body);
    Navigator.pop(context);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: LoadingOverlay(
          isLoading: loading,
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 40,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BackButtonWhite(onPressed: () => {}),
                      SizedBox(width: 10),
                    ]),
                SizedBox(height: 25),
                Text(
                  "E-Consultation",
                  style: TextStyle(
                    color: black,
                    fontSize: pixel28,
                    fontWeight: bold,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Fill out consultation form and a doctor will respond',
                  style: TextStyle(
                    color: inputGrey,
                    fontSize: pixel16,
                    fontWeight: normal,
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Text(
                  "What is the problem?",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                DropdownWidget(
                  store: ["A", "B"],
                  title: "-- Select --",
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "What would you like to achieve from this E-consultation? e.g prescription or advise",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                AuthTextInput(
                  hintText: '',
                  controller: reasonForSession,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "How much is this problem bothering you? e.g affecting your daily life",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                AuthTextInput(
                  hintText: '',
                  controller: levelOfSeverity,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Any previous medication for this problem",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                AuthTextInput(
                  hintText: '',
                  controller: priorMedications,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Are you taking any medication now for this problem",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                AuthTextInput(
                  hintText: '',
                  controller: currentTreatment,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Do you want to consult with a particular doctor",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                AuthTextInput(
                  hintText: '',
                  controller: doctorPreference,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Describe your Symptoms",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                AuthTextInput(
                  hintText: '',
                  controller: symptoms,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "How long have you had this problem",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                AuthTextInput(
                  hintText: '',
                  controller: durationOfIssue,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Do you have a fever, cough or cold",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                AuthTextInput(
                  hintText: '',
                  controller: feverOrCold,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Any physical symptoms - swelling etc ",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                AuthTextInput(
                  hintText: '',
                  controller: physicalSymptoms,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Any recent surgeries/operations",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                AuthTextInput(
                  hintText: '',
                  controller: recentSurgeries,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Any medical conditions - ulcer asthma, diabetes etc",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                AuthTextInput(
                  hintText: '',
                  controller: medicalConditions,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Are you taking any medication for the medical condition",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                AuthTextInput(
                  hintText: '',
                  controller: medicationsForConditions,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Are you receiving any treatment like physiotherapy",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                AuthTextInput(
                  hintText: '',
                  controller: treatmentsLikePhysiotherapy,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Any family history of this condition",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                AuthTextInput(
                  hintText: '',
                  controller: familyHistory,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Alcohol consumption",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                AuthTextInput(
                  hintText: '',
                  controller: alcoholConsumption,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Smoking?",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                AuthTextInput(
                  hintText: '',
                  controller: smoking,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Any allergies",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                AuthTextInput(
                  hintText: '',
                  controller: allergies,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Any additional information",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                AuthTextInput(
                  hintText: '',
                  controller: additionalInfo,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Upload Picture if any",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  margin: EdgeInsets.only(bottom: sizer(false, 16, context)),
                  child: AuthUploadInput(
                      hintText: _image == null
                          ? 'Upload Image'
                          : Image.file(_image).toString(),
                      onPressed: pickImage),
                ),
                Text(
                  "Select hospital to submit to",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                DropdownWidget(
                  store: ["IFEDOC", "ELONA"],
                  title: "-- Select --",
                ),
                SizedBox(
                  height: 30,
                ),
                ButtonBlue(title: "SUBMIT", onPressed: handleSubmit),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          )),
    ));
  }
}
