import 'package:flutter/material.dart';
import 'package:thcMobile/helpers/sizeCalculator.dart';
import 'package:thcMobile/helpers/store.dart';

class BlackMenuTextfield extends StatefulWidget {
  BlackMenuTextfield({Key key, @required this.hintText, this.onPressed})
      : super(key: key);
  final String hintText;
  final GestureTapCallback onPressed;

  @override
  _BlackMenuTextfieldState createState() => _BlackMenuTextfieldState();
}

class _BlackMenuTextfieldState extends State<BlackMenuTextfield> {
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
        borderRadius: BorderRadius.circular(10),
        color: Color(0xff0C1941),
        child: GestureDetector(
          onTap: widget.onPressed,
          child: Container(
            margin: EdgeInsets.only(bottom: sizer(false, 15, context)),
            padding: EdgeInsets.symmetric(vertical: 22, horizontal: 20),
            decoration: BoxDecoration(
              color: Color(0xff0C1941),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: TextFormField(
              textCapitalization: TextCapitalization.sentences,
              maxLines: 4,
              minLines: 4,
              style: TextStyle(color: Colors.white, fontWeight: moderate),
              decoration: InputDecoration(
                hintText: widget.hintText,
                hintStyle: TextStyle(color: Colors.white),
                contentPadding: EdgeInsets.symmetric(vertical: 0),
                border: UnderlineInputBorder(
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
