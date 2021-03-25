import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:thcMobile/components/messageInput.dart';
import 'package:thcMobile/components/searchTextInput.dart';
import 'package:thcMobile/helpers/store.dart';
import 'package:thcMobile/helpers/store.dart';
import 'package:thcMobile/utils/utilities.dart';

class ForumChat extends StatefulWidget {
  ForumChat({@required this.title});
  final String title;

  @override
  _ForumChatState createState() => _ForumChatState();
}

class _ForumChatState extends State<ForumChat> {
  TextEditingController _inputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 90,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/forumBackground.png'),
                fit: BoxFit.fill,
              ),
            ),
          ),
          vertical(25, false),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                widget.title,
                style: TextStyle(
                  color: black,
                  fontSize: pixel28,
                  fontWeight: bold,
                ),
              )),
          vertical(20, false),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: SearchTextInput(
                hintText: 'Search',
              )),
          vertical(5, false),
          Container(
              height: height(58, true, context),
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                  child: Column(children: [
                textMessage(
                    'Brenda A',
                    'My child is having issues with congitive recognition. Anyone with some tips or experience',
                    '2 Nov 2020 13:26'),
                textMessage(
                    'Brenda A',
                    'My child is having issues with congitive recognition. Anyone with some tips or experience',
                    '2 Nov 2020 13:26'),
                imageMessage(
                    'Brenda A',
                    'I am having the same issue he by with a bit more difficulty. I have tried xxxxxxxxx in the past but it didnt works. Meditation seemed to work better and specific yoga positions like this',
                    '2 Nov 2020 13:26',
                    'assets/images/sentImage.png',
                    'assets/images/sentImage.png'),
              ]))),
          MessageInput(
              hintText: 'Enter a message',
              controller: _inputController,
              onMessagePressed: (){
               _inputController.clear();
              },
              onImagePressed: () => Utils.pickImage(source: ImageSource.gallery),
              onMicPressed: (details) => {},
              onMicReleased: (details) => {},
              onCameraPressed: () =>Utils.pickImage(source: ImageSource.camera)),
          SizedBox(height: 5),
        ],
      ),
    ));
  }

  Widget textMessage(String name, String message, String timeAndDate) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 15),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 8),
                  child: Text(
                    name,
                    style: TextStyle(
                      color: inputGrey,
                      fontSize: pixel16,
                      fontWeight: normal,
                    ),
                  )),
              Container(
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.only(right: 8),
                  child: Text(
                    timeAndDate,
                    style: TextStyle(
                      color: inputGrey,
                      fontSize: pixel16,
                      fontWeight: normal,
                    ),
                  )),
            ],
          ),
          vertical(7, false),
          Container(
            alignment: Alignment.topLeft,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: blue.withOpacity(0.2),
            ),
            padding: EdgeInsets.fromLTRB(15, 10, 30, 30),
            child: Text(
              message,
              style: TextStyle(
                color: black,
                height: 1.5,
                fontSize: pixel14,
                fontWeight: normal,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget imageMessage(String name, String message, String timeAndDate,
      String image, String profilePhoto) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 15),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 8),
                  child: Text(
                    name,
                    style: TextStyle(
                      color: inputGrey,
                      fontSize: pixel16,
                      fontWeight: normal,
                    ),
                  )),
              Container(
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.only(right: 8),
                  child: Text(
                    timeAndDate,
                    style: TextStyle(
                      color: inputGrey,
                      fontSize: pixel16,
                      fontWeight: normal,
                    ),
                  )),
            ],
          ),
          vertical(7, false),
          Container(
            alignment: Alignment.topLeft,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: blue.withOpacity(0.2),
            ),
            padding: EdgeInsets.fromLTRB(15, 10, 30, 10),
            child: Column(children: [
              Text(
                message,
                style: TextStyle(
                  color: black,
                  height: 1.5,
                  fontSize: pixel14,
                  fontWeight: normal,
                ),
              ),
              SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(width: 5),
                  Container(
                    height: 80,
                    width: 81,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Container(
                                height: 80,
                                width: 70.5,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(image),
                                        fit: BoxFit.cover)))),
                        Container(
                          height: 9,
                          width: 9,
                          margin: EdgeInsets.only(top: 70),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.asset(
                              profilePhoto,
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
