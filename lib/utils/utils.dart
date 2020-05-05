import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';

class Utils {
  static String url = "http://api.piuniversal.com:4000"; // http://192.168.43.111:4000 'http://10.0.2.2:4000' http://api.piuniversal.com:4000
  static String token = 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7InVzZXJfaWQiOjMsImVtYWlsIjoiZmFsY29uQGdtYWlsLmNvbSIsInVzZXJuYW1lIjoia2F6YWFuIEdyYW50Iiwic3RvcmVfaWQiOjF9LCJpYXQiOjE1ODg3MDY5MjZ9.xPp1d0DHMRCgHHrYq9qGJsCQMGR2AfE3trx7ckp2dys';

  static Future<bool> showStatusAndWaitForAction(
      BuildContext context, bool status, String message) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: status ? Text("Success") : Text("Error"),
            content: Text(message),
            actions: <Widget>[
              FlatButton(
                child: Text("Ok", style: TextStyle(color: Colors.blue),),
                onPressed: () => Navigator.pop(context, true),
              ),
            ],
          );
        });
  }

  static Future<bool> requestAndWaitForAction(
      BuildContext context, String message) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
//            title:Text("Confirm"),
            content: Text(message),
            actions: <Widget>[
              FlatButton(
                child: Text("Yes", style: TextStyle(color: Colors.green),),
                onPressed: () => Navigator.pop(context, true),
              ),
              FlatButton(
                child: Text("No", style: TextStyle(color: Colors.red[300]),),
                onPressed: () => Navigator.pop(context, false),
              )
            ],
          );
        });
  }


  static ProgressDialog initializeProgressDialog(BuildContext context) {
    var progressDialog =
    new ProgressDialog(context, type: ProgressDialogType.Normal);
    progressDialog.style(message: 'progress...');
    progressDialog.style(
      message: 'Please wait...',
      borderRadius: 10.0,
      backgroundColor: Colors.white,
      progressWidget: CircularProgressIndicator(),
      elevation: 10.0,
      insetAnimCurve: Curves.easeInOut,
      progressTextStyle: TextStyle(
          color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
      messageTextStyle: TextStyle(
          color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600),
    );

    return progressDialog;
  }

  static void showStatus(BuildContext context, bool status, String message) {
    var alertDialog = AlertDialog(
      title: status ? Text("Success", style: TextStyle(
          fontSize: 20,
          color: Colors.green
      ),) : Text("Error", style: TextStyle(
          fontSize: 20,
          color: Colors.red
      ),),
      content: status ? Text(message) : Text("An Error Occurred"),
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alertDialog;
        });
  }
}
