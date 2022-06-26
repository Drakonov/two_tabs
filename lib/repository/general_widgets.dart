import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

showWaiterAlertDialog(context) {
  showDialog(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
          content: Container(
        width: 50,
        height: 50,
        child: Center(child: CircularProgressIndicator()),
      ));
    },
  );
}

Widget loadData() {
  return Container(
      height: 140,
      color: Colors.white,
      child: Center(
          child: CircularProgressIndicator(
        semanticsLabel: 'Загрузка данных',
      )));
}

ButtonStyle buttonStyleBordered = TextButton.styleFrom(
    backgroundColor: Colors.white,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
    side: BorderSide(width: 2.0, color: Color.fromARGB(255, 245, 130, 32)));

ButtonStyle buttonStyleFulled = TextButton.styleFrom(
    backgroundColor: Color.fromARGB(255, 245, 130, 32),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
    primary: Colors.white);

showAlertDialog({
  required BuildContext context,
  required funcYes(),
  required funcNo(),
  required String title,
  required String content,
  required String btnTextYes,
  required String btnTextNo,
  double? fontSizeButton,
}) {
  // set up the buttons
  Widget cancelButton = TextButton(
    style: buttonStyleBordered,
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 5),
      child: Center(
        child: Text(
          '$btnTextNo',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Color.fromARGB(255, 245, 130, 32),
            fontSize: fontSizeButton ?? 15,
          ),
        ),
      ),
    ),
    onPressed: () async {
      await funcNo();
    },
  );
  Widget continueButton = TextButton(
    style: buttonStyleFulled,
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 5),
      child: Center(
        child: Text(
          '$btnTextYes',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.white,
            fontSize: fontSizeButton ?? 15,
          ),
        ),
      ),
    ),
    onPressed: () async {
      await funcYes();
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text('$title'),
    content: Text('$content'),
    actions: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          cancelButton,
          continueButton,
        ],
      ),
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
