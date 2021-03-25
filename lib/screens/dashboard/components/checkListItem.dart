import 'package:flutter/material.dart';

class CheckListItem extends StatefulWidget {
  final String title;
  final ValueChanged<bool> onChanged;
  final bool value;
  CheckListItem({Key key, @required this.title, this.onChanged, this.value})
      : super(key: key);
  @override
  _CheckListItemState createState() => _CheckListItemState();
}

class _CheckListItemState extends State<CheckListItem> {
  bool value = false;
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
    return Center(
      child: Material(
        color: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: GestureDetector(
          onTap: () {},
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Color(0xffF3F4F8), width: 1.0),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Text(
                    widget.title,
                    style: TextStyle(color: Color(0xff071232), fontSize: 16),
                  ),
                ),
                Theme(
                  data: ThemeData(
                    unselectedWidgetColor: Color(0xffDFE8FC),
                  ),
                  child: Checkbox(
                    onChanged: widget.onChanged,
                    value: widget.value != null ? widget.value : value,
                    activeColor: Color(0xff2254D3),
                    checkColor: Colors.white,
                  ),
                ),
                //    Material(
                //   color: Color(0xffF3F4F8),
                //   shape: RoundedRectangleBorder(
                //     borderRadius: BorderRadius.circular(10.0),
                //   ),
                //   child: GestureDetector(
                //     onTap: () {},
                //     child: Container(
                //       width: 40,
                //       height: 40,
                //       decoration: BoxDecoration(
                //         color: Color(0xffF3F4F8),
                //         borderRadius: BorderRadius.circular(10.0),
                //       ),
                //       child: Center(
                //           child: Icon(Icons.chevron_right,
                //               size: 17, color: Color(0xff091118))),
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
