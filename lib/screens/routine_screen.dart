import 'dart:io';

import 'package:flutter/material.dart';
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
                _image = await getImage().then((value) {
                  print(value);
                  if (value != null) {
                    setState(() {
                      data['isSelected'] = true;
                    });
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
