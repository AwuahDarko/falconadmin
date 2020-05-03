import 'package:falconadmin/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';



class ShowImage extends StatelessWidget{

  ShowImage(this.title, this.link);
  final title;
  final link;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: PhotoView(
          imageProvider: NetworkImage('${Utils.url}/api/images?url=$link'),
        ),
      ),
    );
  }

}