import 'dart:math';
import 'package:chat_app_firebase/shared/styles/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../modules/login/login_screen.dart';
import '../components/constants.dart';
import '../network/local/cache_helper.dart';

navigateTo(context, screen, bool isFinish) {
  if (isFinish) {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => screen,
        ),
        result: (route) => isFinish);
  } else {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => screen,
        ));
  }
}

flutterToast({required String msg, Color? textColor}) {
  return Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: textColor,
      textColor: Colors.white,
      fontSize: 16.0);
}

snakeBar({required String text, required context, required Color color}) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
      backgroundColor: color,
      duration: Duration(seconds: 2),
    ),
  );
}

Color randomColor() {
  return Colors.primaries[Random().nextInt(Colors.primaries.length)];
}

showPopup({
  required BuildContext context,
  Widget? title,
  String? text,
  List<Widget>? action
}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        title: title,
        content: Text(
          text!,
          style: TextStyle(
              color: Colors.red,
            fontSize: 20.0,
            fontWeight: FontWeight.bold
          ),
          textAlign: TextAlign.center,
        ),
        actions: action,
      );
    },
  );
}


// void showModalBottomSheet({required context,   dynamic Function(BuildContext) ?builder,}) {
//   showModalBottomSheet(
//     context: context,
//     builder: (BuildContext context) {
//       return Container(
//         height: 200,
//         color: Colors.white,
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             mainAxisSize: MainAxisSize.min,
//             children: <Widget>[
//               const Text('Modal Bottom Sheet'),
//               ElevatedButton(
//                 child: const Text('Close Bottom Sheet'),
//                 onPressed: () => Navigator.pop(context),
//               )
//             ],
//           ),
//         ),
//       );
//     },
//   );
// }


