import 'package:flutter/material.dart';
import 'package:thcMobile/helpers/store.dart';
import '../components/messageListItem.dart';
import 'package:thcMobile/helpers/sizeCalculator.dart';
import 'package:thcMobile/components/plusButton.dart';
import 'package:thcMobile/components/searchTextInput.dart';
import 'joinForum.dart';

class ForumIndex extends StatefulWidget {
  ForumIndex({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _ForumIndexState createState() => _ForumIndexState();
}

class _ForumIndexState extends State<ForumIndex> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: new SingleChildScrollView(
                    child: Padding(
                        padding: EdgeInsets.only(
                            top: sizer(false, 50, context),
                            left: sizer(true, 20, context),
                            right: sizer(true, 20, context)),
                        child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      'Forums',
                                      style: TextStyle(
                                        color: black,
                                        fontSize: pixel28,
                                        fontWeight: bold,
                                      ),
                                    ),
                                    Spacer(),
                                    PlusButton(onPressed: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (_) => JoinForum()),
                                      );
                                    }),
                                  ]),
                              SizedBox(height: 25),
                              SearchTextInput(
                                hintText: 'Search',
                                onChanged: (text) {},
                              ),
                              SizedBox(height: 35),
                              ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: 4,
                                  itemBuilder: (BuildContext context,
                                          int index) =>
                                      MessageListItem(
                                          name: 'Health and Wealth Forum',
                                          message:
                                              'Hi Kalu, I just reviewed your health records and I have a few questions...',
                                          unread: 2,
                                          time: '1:02 PM')),
                            ]))))));
  }
}
