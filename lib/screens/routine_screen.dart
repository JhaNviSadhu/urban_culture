import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:urban_culture/model/model_routine.dart';
import 'package:urban_culture/utils/urban_culture_colors.dart';
import 'package:urban_culture/utils/urban_culture_common.dart';
import 'package:urban_culture/utils/urban_culture_images.dart';
import 'package:urban_culture/utils/urban_culture_textstyles.dart';

class RoutineScreen extends StatefulWidget {
  const RoutineScreen({super.key});

  @override
  State<RoutineScreen> createState() => _RoutineScreenState();
}

class _RoutineScreenState extends State<RoutineScreen> {
  ModelSkinCareRoutines modelSkinCareRoutines = ModelSkinCareRoutines();
  bool isSelected = false;
  File? _image;
  var userData;
  int currentStepIndex = 0;
  List<bool> stepCompletionStatus = List.filled(5, false); // Assuming 5 steps
  bool showLoader = false;

  @override
  void initState() {
    getUserId().then((_) {
      getCurrentStepIndex(); // Retrieve the current step index from Firestore
      fetchSkincareRoutineData(); // Fetch and populate the routine data
      checkAndResetStepsIfNeeded(); // Check if the steps need to be reset for a new day
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      alignment: Alignment.center,
      children: [
        ListView.builder(
          itemCount: dailySkincareStep.length,
          itemBuilder: (context, index) {
            return _buildCard(index: index, data: dailySkincareStep[index]);
          },
        ),
        if (showLoader)
          Positioned(
            bottom: 20,
            child: Container(
              decoration: BoxDecoration(
                color: UrbanCultureColors.containerColor,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                child: Text(
                  "Please wait data uploading to firebase...",
                  style: UrbanCultureTextStyle.subheadW700(
                      color: UrbanCultureColors.primaryColor),
                ),
              ),
            ),
          ),
      ],
    ));
  }

  //card view design
  Widget _buildCard({index, data}) {
    return GestureDetector(
      onTap: () {
        showLoader
            ? showSnackbar(MessageType.warning,
                context: context,
                message: "Please wait data uploading to firebase..")
            : completeSkincareStep(index);
      },
      child: Container(
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              Container(
                height: 48,
                width: 48,
                decoration: BoxDecoration(
                    color: data['isSelected']
                        ? UrbanCultureColors.containerColor
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      width: 3,
                      color: UrbanCultureColors.containerColor,
                    )),
                child: Center(
                  child: data['isSelected']
                      ? Image.asset(
                          ImgConstatnts.icDone,
                          height: 24,
                          width: 24,
                        )
                      : Text(
                          "${index + 1}",
                          style: UrbanCultureTextStyle.callout(
                              color: UrbanCultureColors
                                  .urbanCulturTextColors.textTitleColor),
                        ),
                ),
              ),
              16.width,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    constraints: BoxConstraints(
                        maxWidth: MediaQuery.sizeOf(context).width / 1.8),
                    child: Text(
                      "${data['step']}",
                      style: UrbanCultureTextStyle.callout(
                          color: UrbanCultureColors
                              .urbanCulturTextColors.textTitleColor),
                    ),
                  ),
                  Container(
                    constraints: BoxConstraints(
                        maxWidth: MediaQuery.sizeOf(context).width / 1.85),
                    child: Text(
                      "${data['detail']}",
                      style: UrbanCultureTextStyle.subheadW400(
                          color: UrbanCultureColors.primaryColor),
                    ),
                  )
                ],
              ),
              Spacer(),
              if (data['isSelected'])
                Row(
                  children: [
                    Image.asset(
                      ImgConstatnts.icCamera,
                      width: 27,
                      height: 27,
                    ),
                    4.width,
                    Text(
                      "${data['time']}",
                      style: UrbanCultureTextStyle.subheadW400(
                          color: UrbanCultureColors.primaryColor),
                    ),
                  ],
                )
            ],
          ),
        ),
      ),
    );
  }

  getUserId() async {
    userData = await FirebaseAuth.instance.currentUser;
  }

  // Function to get current step
  Future<void> getCurrentStepIndex() async {
    String userId = userData.uid;
    DocumentReference userDocRef =
        FirebaseFirestore.instance.collection('users').doc(userId);

    DocumentSnapshot userSnapshot = await userDocRef.get();
    Map<String, dynamic>? data = userSnapshot.data() as Map<String, dynamic>?;
    if (userSnapshot.exists &&
        data != null &&
        data.containsKey('currentStepIndex')) {
      setState(() {
        currentStepIndex = data['currentStepIndex'] ??
            0; // Provide a default value in case it's null
      });
    } else {
      // Handle the case where 'currentStepIndex' does not exist, e.g., new user
      setState(() {
        currentStepIndex = 0;
      });
    }
  }

  // Function to fetch skincare Routine data
  Future<void> fetchSkincareRoutineData() async {
    String userId = userData.uid;
    String date = DateTime.now().toIso8601String().split('T')[0];
    DocumentReference routineDocRef = FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('skincareRoutines')
        .doc(date);

    DocumentSnapshot routineSnapshot = await routineDocRef.get();
    if (routineSnapshot.exists) {
      Map<String, dynamic> data =
          routineSnapshot.data() as Map<String, dynamic>;
      Map<String, dynamic> completedSteps = data['completedSteps'] ?? {};
      Map<String, dynamic> timestamps = data['timestamps'] ?? {};

      setState(() {
        for (int i = 0; i < dailySkincareStep.length; i++) {
          String step = dailySkincareStep[i]['step'];
          dailySkincareStep[i]['isSelected'] = completedSteps[step] ?? false;
          stepCompletionStatus[i] = completedSteps[step] ?? false;
          Timestamp? timestamp = timestamps[step];
          if (timestamp != null) {
            DateTime dateTime = timestamp.toDate();

            String formattedTime = DateFormat('HH:mm a').format(dateTime);
            dailySkincareStep[i]['time'] = formattedTime;
          } else {
            dailySkincareStep[i]['time'] = 'Pending';
          }
        }
      });
    } else {
      // Handle the case where there's no routine data for the current date
      // Perhaps reset the dailySkincareStep list to its default state
    }
  }

// Function to check and reset the step
  Future<void> checkAndResetStepsIfNeeded() async {
    String userId = userData!.uid;
    DocumentReference userDocRef =
        FirebaseFirestore.instance.collection('users').doc(userId);

    DocumentSnapshot userSnapshot = await userDocRef.get();
    if (userSnapshot.exists) {
      Map<String, dynamic> data =
          userSnapshot.data() as Map<String, dynamic>? ?? {};
      String lastCompletedDate = data['lastCompletedDate'] ?? '';
      String currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

      if (lastCompletedDate != currentDate) {
        // It's a new day; reset steps and update the Firestore accordingly
        await updateCurrentStepIndex(
            userId, 0); // Reset the step index for the next day
        resetSteps(); // This function should also reset the UI elements

        // Optionally, update 'lastCompletedDate' in Firestore to the current date
        userDocRef.update({'lastCompletedDate': currentDate});
      }
    }
  }

// Function to update current step
  Future<void> updateCurrentStepIndex(String userId, int index) async {
    DocumentReference userDocRef =
        FirebaseFirestore.instance.collection('users').doc(userId);

    // Attempt to fetch the document first to check if it exists
    DocumentSnapshot snapshot = await userDocRef.get();

    if (!snapshot.exists) {
      // If the document does not exist, use `set()` to create it and initialize fields
      await userDocRef.set({
        'currentStepIndex': index,
      });
    } else {
      // If the document exists, proceed to update it
      await userDocRef.update({'currentStepIndex': index});
    }

    getCurrentStepIndex();
  }

  // Function to reset steps for the next day
  void resetSteps() {
    for (var step in dailySkincareStep) {
      step['isSelected'] = false;
    }
    stepCompletionStatus = List.filled(dailySkincareStep.length, false);
  }

  // Function to complete skincare step
  Future<void> completeSkincareStep(int index) async {
    // Check if the step is not already completed and is the next step in sequence
    if (index < currentStepIndex) {
      showSnackbar(MessageType.warning,
          context: context,
          message: "This step is already been performed earliar");
      return;
    } else if (index > currentStepIndex) {
      showSnackbar(MessageType.warning,
          context: context, message: "Please follow steps");
      return;
    }

    File? imageFile = await getImage();
    if (imageFile == null) {
      // showAlert("No image selected.");
      return;
    }
    setState(() {
      showLoader = true;
    });
    String imageUrl = await uploadImageToFirebase(
        imageFile, userData.uid, dailySkincareStep[index]['step']);
    Timestamp timestamp = Timestamp.fromDate(DateTime.now());

    await updateSkincareRoutine(
        userData.uid, dailySkincareStep[index]['step'], imageUrl, timestamp);

    // If it's the last step, reset currentStepIndex and possibly update streak
    if (index == dailySkincareStep.length - 1) {
      // await updateCurrentStepIndex(
      //     userData.uid, 0); // Reset the step index for the next day
      await updateCurrentStepIndex(userData.uid, index + 1);
      updateStreak(userData.uid);
      fetchSkincareRoutineData();
      // Reset local step completion status
      // setState(() {
      // stepCompletionStatus = List.filled(dailySkincareStep.length, false);
      // for (var step in dailySkincareStep) {
      //   step['isSelected'] = false;
      // }
      // });
    } else {
      // Not the last step, increment currentStepIndex
      await updateCurrentStepIndex(userData.uid, index + 1);
      fetchSkincareRoutineData();
    }

    setState(() {
      showLoader = false;
    });

    // Update local state to mark step as complete and move to next step
    setState(() {
      stepCompletionStatus[index] = true;
      dailySkincareStep[index]['isSelected'] = true;
      currentStepIndex = index + 1;
    });
  }

  Future<String> uploadImageToFirebase(
      File imageFile, String userId, String step) async {
    String fileName =
        'skincareRoutines/$userId/${DateTime.now().toIso8601String()}_$step';
    Reference ref = FirebaseStorage.instance.ref().child(fileName);
    UploadTask uploadTask = ref.putFile(File(imageFile.path));
    TaskSnapshot taskSnapshot = await uploadTask;
    return await taskSnapshot.ref.getDownloadURL();
  }

  Future<void> updateSkincareRoutine(
      String userId, String step, String imageUrl, Timestamp timestamp) async {
    DocumentReference userDocRef =
        FirebaseFirestore.instance.collection('users').doc(userId);
    String date = DateTime.now().toIso8601String().split('T')[0];
    DocumentReference routineDocRef =
        userDocRef.collection('skincareRoutines').doc(date);

    return FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentSnapshot routineSnapshot = await transaction.get(routineDocRef);

      if (!routineSnapshot.exists) {
        transaction.set(routineDocRef, {
          'date': date,
          'completedSteps': {step: true},
          'timestamps': {step: timestamp},
          'images': {step: imageUrl},
        });
      } else {
        transaction.update(routineDocRef, {
          'completedSteps.$step': true,
          'timestamps.$step': timestamp,
          'images.$step': imageUrl,
        });
      }
    });
  }

  Future<void> updateStreak(String userId) async {
    DocumentReference userDocRef =
        FirebaseFirestore.instance.collection('users').doc(userId);
    FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentSnapshot userSnapshot = await transaction.get(userDocRef);
      if (!userSnapshot.exists) return;

      Map<String, dynamic> userData =
          userSnapshot.data() as Map<String, dynamic>? ?? {};
      int currentStreak = userData['currentStreak'] ?? 0;

      // Check if all steps are completed for the current day before incrementing the streak
      if (stepCompletionStatus.every((completed) => completed)) {
        transaction.update(userDocRef, {
          'currentStreak': currentStreak + 1,
          'lastCompletedDate': DateFormat('yyyy-MM-dd').format(DateTime.now()),
        });
      }
    });
  }
}

List dailySkincareStep = [
  {
    'step': 'Cleanser',
    'detail': 'Cetaphil Gentle Skin Cleanser',
    'time': '8:00 PM',
    'isSelected': false,
  },
  {
    'step': 'Toner',
    'detail': 'Thayers Witch Hazel Toner',
    'time': '8:02 PM',
    'isSelected': false,
  },
  {
    'step': 'Moisturizer',
    'detail': 'Kiehl\'s Ultra Facial Cream',
    'time': '8:04 PM',
    'isSelected': false,
  },
  {
    'step': 'Sunscreen',
    'detail': 'Supergoop Unseen Sunscreen SPF 40',
    'time': '8:06 PM',
    'isSelected': false,
  },
  {
    'step': 'Lip Balm',
    'detail': 'Glossier Birthday Balm Dotcom',
    'time': '8:08 PM',
    'isSelected': false,
  }
];
