import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
  bool isSelected = false;
  File? _image;
  var userData;
  ModelSkinCareRoutines modelSkinCareRoutines = ModelSkinCareRoutines();

  @override
  void initState() {
    getUserId();
    super.initState();
  }

  getUserId() async {
    userData = await FirebaseAuth.instance.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(
      itemCount: dailySkincareStep.length,
      itemBuilder: (context, index) {
        return _buildCard(index: index, data: dailySkincareStep[index]);
      },
    ));
  }

  //card view design
  Widget _buildCard({index, data}) {
    return GestureDetector(
      onTap: _image == null
          ? () async {
              if (index == 0
                  ? true
                  : dailySkincareStep[index - 1]['isSelected']) {
                _image = await getImage().then((value) async {
                  print(value);
                  if (value != null) {
                    setState(() {
                      data['isSelected'] = true;
                    });

                    updateData(index);
                  }

                  return value;
                });
              } else {
                showSnackbar(MessageType.warning,
                    context: context,
                    message: "Please do your skincare step by step");
              }
              _image = null;
            }
          : () {},
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
                        maxWidth: MediaQuery.sizeOf(context).width / 1.8),
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

  Future getFirebaseData() async {
    return await FirebaseFirestore.instance
        .collection('user')
        .doc("${userData?.uid}")
        .collection('skincareRoutines')
        .doc("${getCurrentDate()}")
        .get();
  }

  setFirebaseData({data, isupdate = false}) {
    isupdate
        ? FirebaseFirestore.instance
            .collection('user')
            .doc("${userData?.uid}")
            .collection('skincareRoutines')
            .doc("${getCurrentDate()}")
            .update(data)
        : FirebaseFirestore.instance
            .collection('user')
            .doc("${userData?.uid}")
            .collection('skincareRoutines')
            .doc("${getCurrentDate()}")
            .set(data);
  }

  updateData(index) async {
    switch (index) {
      case 0:
        getFirebaseData().then((value) {
          setFirebaseData(
            data: skincareRoutineResponseModelToJson(
              ModelSkinCareRoutines(
                completedSteps: CompletedSteps(
                  moisturizer: false,
                  sunscreen: false,
                  toner: false,
                  cleanser: true,
                  lipBalm: false,
                ),
                images: Images(
                  cleanser: '',
                  lipBalm: '',
                  moisturizer: '',
                  sunscreen: '',
                  toner: '',
                ),
                timestamps: Timestamps(
                  cleanser: Timestamp.fromDate(DateTime.now()),
                ),
              ),
            ),
          );
        });

        break;
      case 1:
        getFirebaseData().then((snapshot) {
          var data = snapshot.data();
          print(data);
          if (data != null) {
            modelSkinCareRoutines = ModelSkinCareRoutines.fromJson(data);
          }
          setFirebaseData(
            isupdate: true,
            data: skincareRoutineResponseModelToJson(
              ModelSkinCareRoutines(
                completedSteps: CompletedSteps(
                  moisturizer: false,
                  sunscreen: false,
                  toner: true,
                  cleanser: modelSkinCareRoutines.completedSteps?.cleanser,
                  lipBalm: false,
                ),
                images: Images(
                  cleanser: '',
                  lipBalm: '',
                  moisturizer: '',
                  sunscreen: '',
                  toner: '',
                ),
                timestamps: Timestamps(
                  cleanser: modelSkinCareRoutines.timestamps?.cleanser,
                  toner: Timestamp.fromDate(DateTime.now()),
                ),
              ),
            ),
          );
        });
        break;
      case 2:
        getFirebaseData().then((snapshot) {
          var data = snapshot.data();
          print(data);
          if (data != null) {
            modelSkinCareRoutines = ModelSkinCareRoutines.fromJson(data);
          }
          setFirebaseData(
            isupdate: true,
            data: skincareRoutineResponseModelToJson(
              ModelSkinCareRoutines(
                completedSteps: CompletedSteps(
                  moisturizer: true,
                  sunscreen: false,
                  toner: modelSkinCareRoutines.completedSteps?.toner,
                  cleanser: modelSkinCareRoutines.completedSteps?.cleanser,
                  lipBalm: false,
                ),
                images: Images(
                  cleanser: '',
                  lipBalm: '',
                  moisturizer: '',
                  sunscreen: '',
                  toner: '',
                ),
                timestamps: Timestamps(
                  moisturizer: Timestamp.fromDate(DateTime.now()),
                  cleanser: modelSkinCareRoutines.timestamps?.cleanser,
                  toner: modelSkinCareRoutines.timestamps?.toner,
                ),
              ),
            ),
          );
        });
        break;
      case 3:
        getFirebaseData().then((snapshot) {
          var data = snapshot.data();
          print(data);
          if (data != null) {
            modelSkinCareRoutines = ModelSkinCareRoutines.fromJson(data);
          }
          setFirebaseData(
            isupdate: true,
            data: skincareRoutineResponseModelToJson(
              ModelSkinCareRoutines(
                completedSteps: CompletedSteps(
                  moisturizer:
                      modelSkinCareRoutines.completedSteps?.moisturizer,
                  sunscreen: true,
                  toner: modelSkinCareRoutines.completedSteps?.toner,
                  cleanser: modelSkinCareRoutines.completedSteps?.cleanser,
                  lipBalm: false,
                ),
                images: Images(
                  cleanser: '',
                  lipBalm: '',
                  moisturizer: '',
                  sunscreen: '',
                  toner: '',
                ),
                timestamps: Timestamps(
                  moisturizer: modelSkinCareRoutines.timestamps?.moisturizer,
                  sunscreen: Timestamp.fromDate(DateTime.now()),
                  cleanser: modelSkinCareRoutines.timestamps?.cleanser,
                  toner: modelSkinCareRoutines.timestamps?.toner,
                ),
              ),
            ),
          );
        });
        break;
      case 4:
        getFirebaseData().then((snapshot) {
          var data = snapshot.data();
          print(data);
          if (data != null) {
            modelSkinCareRoutines = ModelSkinCareRoutines.fromJson(data);
          }
          setFirebaseData(
            isupdate: true,
            data: skincareRoutineResponseModelToJson(
              ModelSkinCareRoutines(
                completedSteps: CompletedSteps(
                  moisturizer:
                      modelSkinCareRoutines.completedSteps?.moisturizer,
                  sunscreen: modelSkinCareRoutines.completedSteps?.sunscreen,
                  toner: modelSkinCareRoutines.completedSteps?.toner,
                  cleanser: modelSkinCareRoutines.completedSteps?.cleanser,
                  lipBalm: true,
                ),
                images: Images(
                  cleanser: '',
                  lipBalm: '',
                  moisturizer: '',
                  sunscreen: '',
                  toner: '',
                ),
                timestamps: Timestamps(
                  moisturizer: modelSkinCareRoutines.timestamps?.moisturizer,
                  sunscreen: modelSkinCareRoutines.timestamps?.sunscreen,
                  cleanser: modelSkinCareRoutines.timestamps?.cleanser,
                  toner: modelSkinCareRoutines.timestamps?.toner,
                  lipBalm: Timestamp.fromDate(DateTime.now()),
                ),
              ),
            ),
          );
        });
        break;
      default:
    }
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
