import 'package:flutter/material.dart';
import 'package:thcMobile/helpers/sizeCalculator.dart';
import 'package:thcMobile/components/backButtonWhite.dart';
import 'package:thcMobile/components/searchTextInput.dart';
import 'package:thcMobile/helpers/store.dart';
import 'forumDetails.dart';

class JoinForum extends StatefulWidget {
  JoinForum({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _JoinForumState createState() => _JoinForumState();
}

class _JoinForumState extends State<JoinForum> {
  @override
  void initState() {
    super.initState();
  }

  List<ForumWidget> forums = [
    ForumWidget(name: 'Mental health 101', membersNo: '200'),
    ForumWidget(name: 'Mental health 101', membersNo: '200'),
    ForumWidget(name: 'Mental health 101', membersNo: '200'),
    ForumWidget(name: 'Mental health 101', membersNo: '200'),
  ];
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        resizeToAvoidBottomPadding: false,
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
                        Row(children: <Widget>[
                          BackButtonWhite(
                            onPressed: () {},
                          ),
                        ]),
                        SizedBox(height: 25),
                        Text(
                          'Discover forums',
                          style: TextStyle(
                            color: black,
                            fontSize: pixel24,
                            fontWeight: bold,
                          ),
                        ),
                        SizedBox(height: 30),
                        SearchTextInput(
                          hintText: 'Search',
                          onChanged: (text) {},
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                            width: double.infinity,
                            child: GridView.builder(
                                padding: EdgeInsets.all(0),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        childAspectRatio:
                                            (MediaQuery.of(context).size.width *
                                                0.40 /
                                                200),
                                        mainAxisSpacing: 20,
                                        crossAxisSpacing: 15,
                                        crossAxisCount: 2),
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemCount: forums.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return forumBox(forums[index].name,
                                      forums[index].membersNo);
                                })),
                        SizedBox(height: 20),
                      ]),
                )))));
  }

  Widget forumBox(String name, String membersNo) {
    return GestureDetector(
        onTap: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => ForumDetails(
                  title: name,
                ))),
        child: Container(
            width: MediaQuery.of(context).size.width * 0.28,
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                    height: 160,
                    width: double.infinity,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          'assets/images/forumImage.png',
                          fit: BoxFit.cover,
                        ))),
                SizedBox(height: 10),
                Text(
                  name,
                  style: TextStyle(color: Color(0xff2254D3), fontSize: 17),
                ),
                SizedBox(height: 3),
                Text(
                  membersNo + ' members',
                  style: TextStyle(color: Color(0xff071232), fontSize: 15),
                ),
              ],
            )));
  }
}

class ForumWidget {
  String name;
  String membersNo;
  ForumWidget({@required this.name, @required this.membersNo});
}
