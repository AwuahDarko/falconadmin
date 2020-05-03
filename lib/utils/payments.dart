import 'dart:convert';

import 'package:falconadmin/models/store_payment.dart';
import 'package:falconadmin/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:progress_dialog/progress_dialog.dart';

class Payment extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return PaymentState();
  }
}

class PaymentState extends State<Payment> {
  Future<List<StorePayment>> _paymentList;
  ProgressDialog _progressDialog;

  @override
  void initState() {
    super.initState();
    _paymentList = _getPaymentList();
  }

  @override
  Widget build(BuildContext context) {
    _progressDialog = Utils.initializeProgressDialog(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Payments"),
      ),
      body: FutureBuilder(
        future: _paymentList,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Center(
                  child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.blue)));
            case ConnectionState.waiting:
              return Center(
                  child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.blue)));

            case ConnectionState.active:
              return Center(
                  child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.blue)));
              break;
            case ConnectionState.done:
              if (snapshot.hasError)
                return Center(
                    child: Text(
                  'Error:\n\n Network Error${snapshot.error}',
                  textAlign: TextAlign.center,
                  style:
                      TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                ));

              ///task is complete with some data
              return _drawListView(snapshot.data);
          }
          return null;
        },
      ),
    );
  }

  Widget _drawListView(data) {
    return Container(
        height: MediaQuery.of(context).size.height,
        child: ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              return Container(
                  padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 5.0),
                  child: Card(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 100,
                      child: Stack(
                        children: <Widget>[
                          Positioned(
                            top: 20,
                            left: 5,
                            child: CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.grey,
                              backgroundImage: NetworkImage(
                                  '${Utils.url}/api/images?url=${data[index].logo}'),
                            ),
                          ),
                          Positioned(
                            top: 15,
                            left: 70,
                            child: Text(
                              '${data[index].storeName}',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18.0),
                            ),
                          ),
                          Positioned(
                            top: 35,
                            left: 75,
                            child: Text('${data[index].street}'),
                          ),
                          Positioned(
                            top: 50,
                            left: 75,
                            child: Text('${data[index].email}'),
                          ),
                          Positioned(
                            top: 68,
                            left: 75,
                            child: Text('${data[index].cell}'),
                          ),
                          Positioned(
                            top: 68,
                            right: 75,
                            child: Text(
                              'GH\u20B5 ${data[index].amount.toStringAsFixed(2)}',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  fontStyle: FontStyle.italic),
                            ),
                          ),
                          Positioned(
                            top: 10,
                            right: 35,
                            child: Switch(
                              value: data[index].state,
                              onChanged: (value) async {
                                _progressDialog.show();

                                var body = {
                                  'earning_id': data[index].earningId,
                                  'status': value ? 'paid' : 'pending'
                                };
                                bool status = await _setPaymentStatus(body);
                                Future.delayed(Duration(seconds: 1))
                                    .then((value) {
                                  _progressDialog.hide().whenComplete(() {
                                    Utils.showStatus(context, status, "Done");
                                  });
                                });
                                setState(() {
                                  data[index].state = value;
                                });
                              },
                              activeColor: Colors.greenAccent[400],
                            ),
                          )
                        ],
                      ),
                    ),
                  ));
            }));
  }

  Future<List<StorePayment>> _getPaymentList() async {
    String url = Utils.url + "/api/store-payment";

    var res = await http.get(url, headers: {'Authorization': Utils.token});

    List<StorePayment> mList = [];
    if (res.statusCode == 200) {
      List<dynamic> list = jsonDecode(res.body);

      list.forEach((oneList) {
        mList.add(new StorePayment(
            earningId: oneList['earning_id'],
            amount: oneList['amount'].toDouble(),
            storeId: oneList['store_id'],
            payment: oneList['payment'],
            storeName: oneList['name'],
            email: oneList['email'],
            logo: oneList['image_url'],
            date: oneList['created_at'].split('T')[0],
            street: oneList['street_name'],
            cell: oneList['cell_number']));
      });
    }
    return mList;
  }

  Future<bool> _setPaymentStatus(Map<String, dynamic> body) async {
    String url = Utils.url + "/api/store-payment";

    String json = jsonEncode(body);

    var res = await http.put(url,
        headers: {
          'Authorization': Utils.token,
          'Content-Type': 'application/json'
        },
        body: json);

    if (res.statusCode == 200 || res.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }
}
