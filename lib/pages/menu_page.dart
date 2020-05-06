import 'dart:convert';

import 'package:falconadmin/pages/new_applicants.dart';
import 'package:falconadmin/utils/payments.dart';
import 'package:falconadmin/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:progress_dialog/progress_dialog.dart';



class MenuPage extends StatelessWidget {

  ProgressDialog _progressDialog;
  String discount = '';
  @override
  Widget build(BuildContext context) {
    _getCharge();
    _progressDialog = Utils.initializeProgressDialog(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('Menu'),
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 10.0,
              ),
              Container(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                width: MediaQuery.of(context).size.width,
                child: RaisedButton(
                  child: Text("New Applicants"),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => NewApplicants()));
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                width: MediaQuery.of(context).size.width,
                child: RaisedButton(
                  child: Text("Payments"),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Payment()));
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                width: MediaQuery.of(context).size.width,
                child: RaisedButton(
                  child: Text("Distributor Charges"),
                  onPressed: () async {
		controller.text = discount;
                   bool value = await _amountDialog(context);
                   if(value == true){
                     _progressDialog.show();
                   bool status =  await _setCharge();
                     Future.delayed(Duration(seconds: 1))
                         .then((value) {
                       _progressDialog.hide().whenComplete(() {
                         Utils.showStatus(context, status, "Done.");
                       });
                     });
                   }
                  },
                ),
              )
            ],
          ),
        ));
  }

  var controller = TextEditingController();

  Future<bool> _amountDialog(
      BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title:Text("Enter charge as percentage"),
            content: TextFormField(
              controller: controller,
              keyboardType: TextInputType.number,
            ),
            actions: <Widget>[
              FlatButton(
                child: Text("Save", style: TextStyle(color: Colors.green),),
                onPressed: () => Navigator.pop(context, true),
              ),
              FlatButton(
                child: Text("Cancel", style: TextStyle(color: Colors.red[300]),),
                onPressed: () => Navigator.pop(context, false),
              ),
            ],
          );
        });
  }

  Future<bool> _setCharge() async {
    String url = Utils.url + "/api/admin/set?d=${controller.text}";

    var res = await http.get(url,
        headers: {
          'Authorization': Utils.token,
          'Content-Type': 'application/json'
        });

    if (res.statusCode == 200 || res.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> _getCharge() async {
    String url = Utils.url + "/api/admin/get";
print('called....');
    var res = await http.get(url,
        headers: {
          'Authorization': Utils.token,
          'Content-Type': 'application/json'
        });

    if (res.statusCode == 200 || res.statusCode == 201) {
      Map<String, dynamic> map = jsonDecode(res.body);
      discount = map['discount'].toStringAsFixed(2);
      return true;
    } else {
      return false;
    }
  }

}
