import 'dart:convert';

import 'package:falconadmin/models/stores.dart';
import 'package:falconadmin/pages/show_image.dart';
import 'package:falconadmin/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:progress_dialog/progress_dialog.dart';

class NewApplicants extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return NewApplicantsState();
  }
}

class NewApplicantsState extends State<NewApplicants> {
  Future<List<Store>> _paymentList;
  ProgressDialog _progressDialog;

  @override
  void initState() {
    super.initState();
    _paymentList = _getApplicantList();
  }

  @override
  Widget build(BuildContext context) {
    _progressDialog = Utils.initializeProgressDialog(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("New Applicants"),
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
        height: MediaQuery
            .of(context)
            .size
            .height,
        child: ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              return Container(
                  height: 530,
                  color: Colors.blueAccent,
                  padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 5.0),
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        top: 98,
                        left: 20,
                        right: 20,
                        child: Card(
                          child: Container(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Text('Applicant name:',
                                      style: TextStyle(fontSize: 17),),
                                    SizedBox(width: 30,),
                                    Text('${data[index].fullName}')
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Text('Director name 1:',
                                      style: TextStyle(fontSize: 17),),
                                    SizedBox(width: 30,),
                                    Text('${data[index].direct1}')
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Text('Director name 2:',
                                      style: TextStyle(fontSize: 17),),
                                    SizedBox(width: 30,),
                                    Text('${data[index].direct2}')
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Text('Country:',
                                      style: TextStyle(fontSize: 17),),
                                    SizedBox(width: 90,),
                                    Text('${data[index].country}')
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Text(
                                      'City:', style: TextStyle(fontSize: 17),),
                                    SizedBox(width: 120,),
                                    Text('${data[index].city}')
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Text(
                                      'Area:', style: TextStyle(fontSize: 17),),
                                    SizedBox(width: 116,),
                                    Text('${data[index].area}')
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Text('Mobile:',
                                      style: TextStyle(fontSize: 17),),
                                    SizedBox(width: 120,),
                                    Text('${data[index].mobile}')
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Text('Landline:',
                                      style: TextStyle(fontSize: 17),),
                                    SizedBox(width: 120,),
                                    Text('${data[index].land}')
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Text('ZAMRA licence no.:',
                                      style: TextStyle(fontSize: 17),),
                                    SizedBox(width: 5,),
                                    Text('${data[index].zamraNo}')
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Text('HPCZ certificate no.:',
                                      style: TextStyle(fontSize: 17),),
                                    SizedBox(width: 5,),
                                    Text('${data[index].hpczNo}')
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Text('Cert. of Inc.',
                                      style: TextStyle(fontSize: 17),),
                                    SizedBox(width: 40,),
                                    RaisedButton(
                                        color: Colors.green,
                                        child: Text('View', style: TextStyle(
                                            color: Colors.white),),
                                        onPressed: () =>
                                            Navigator.push(context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ShowImage('Cert. of Inc', data[index].certIncImage))) ,
                                    )
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Text('ZAMRA cert.',
                                      style: TextStyle(fontSize: 17),),
                                    SizedBox(width: 30,),
                                    RaisedButton(
                                        color: Colors.green,
                                        child: Text('View', style: TextStyle(
                                            color: Colors.white),),
                                        onPressed: () =>
                                            Navigator.push(context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ShowImage('ZAMRA cert', data[index].zamraCertImage))),
                                    )
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Text('HPCZ Full reg.',
                                      style: TextStyle(fontSize: 17),),
                                    SizedBox(width: 20,),
                                    RaisedButton(
                                        color: Colors.green,
                                        child: Text('View', style: TextStyle(
                                            color: Colors.white),),
                                        onPressed: () =>
                                            Navigator.push(context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ShowImage('HPCZ Full reg', data[index].hpczFullImage))),
                                    )
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Text('HPCZ annual.',
                                      style: TextStyle(fontSize: 17),),
                                    SizedBox(width: 25,),
                                    RaisedButton(
                                      color: Colors.green,
                                      child: Text('View',
                                        style: TextStyle(color: Colors.white),),
                                      onPressed: () =>
                                          Navigator.push(context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ShowImage('HPCZ annual', data[index].hpczAnnualImage))),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Card(
                        child: Container(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width,
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
                                      '${Utils.url}/api/images?url=${data[index]
                                          .logo}'),
                                ),
                              ),
                              Positioned(
                                top: 15,
                                left: 70,
                                child: Text(
                                  '${data[index].name}',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0),
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
                                top: 10,
                                right: 35,
                                child: Switch(
                                  value: data[index].state,
                                  onChanged: (value) async {
                                   bool res = await Utils.requestAndWaitForAction(context, 'Approve Application ?');
                                   if(res){
                                     _progressDialog.show();
                                     Map<String, dynamic> body = {
                                       "state": "approved",
                                       "store_id": data[index].storeId
                                     };

                                     bool status = await _setApproval(body);
                                     Future.delayed(Duration(seconds: 1))
                                         .then((value) {
                                       _progressDialog.hide().whenComplete(() {
                                         Utils.showStatus(context, status, "Approved");
                                       });
                                     });

                                     if(status) {
                                       setState(() {
                                         data[index].state = value;
                                       });
                                     }
                                   }

                                  },
                                  activeColor: Colors.greenAccent[400],
                                ),
                              )

                            ],

                          ),
                        ),
                      ),
                    ],
                  )
              );
            }));
  }

  Future<List<Store>> _getApplicantList() async {
    String url = Utils.url + "/api/new-store";

    var res = await http.get(url, headers: {'Authorization': Utils.token});

    List<Store> mList = [];
    if (res.statusCode == 200) {
      List<dynamic> list = jsonDecode(res.body);

      list.forEach((oneList) {
        mList.add(new Store(
            storeId: oneList['store_id'],
            name: oneList['name'],
            street: oneList['street_name'],
            email: oneList['email'],
            status: oneList['status'],
            customerId: oneList['customer_id'],
            direct1: oneList['director_name1'],
            direct2: oneList['director_name2'],
            cell: oneList['cell_number'],
            mobile: oneList['mobile_number'],
            land: oneList['landline'],
            area: oneList['area'],
            city: oneList['city'],
            country: oneList['country'],
            zamraNo: oneList['zamra_licence_number'],
            hpczNo: oneList['hpcz_certificate_number'],
            certIncImage: oneList['cert_of_incoporation'],
            zamraCertImage: oneList['zamra_certificate'],
            hpczFullImage: oneList['hpcz_full_reg'],
            hpczAnnualImage: oneList['hpcz_annual'],
            logo: oneList['image_url'],
            fullName: "${oneList['first_name']} ${oneList['last_name']}"
        ));
      });
    }
    return mList;
  }

  Future<bool> _setApproval(Map<String, dynamic> body) async {
    String url = Utils.url + "/api/store/status";

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
