import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:user/scoped-models/MainModel.dart';

class DocMyProfile extends StatefulWidget {

  MainModel model;

  DocMyProfile({Key key, this.model}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _MyProfile();
}

class _MyProfile extends State<DocMyProfile> {
  FocusNode _descriptionFocus, _focusNode;
  final _titleController = TextEditingController();
  String _ratingController;

  @override
  void initState() {
    super.initState();
    _descriptionFocus = FocusNode();
    _focusNode = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xfff3f4f4),
        // resizeToAvoidBottomPadding: true,
        appBar: AppBar(
          backgroundColor: Color(0xFF0F6CE1),
          centerTitle: true,
          title: Text('MyProfile'),
        ),
        body:
        Container(
          color: Colors.white,
          child: ListView(children: <Widget>[
            SizedBox(
              height: 20,
            ),
            myProfile(),
            SizedBox(height:15.00),

            myIndentification(),

          ]
          ),
        )
    );
  }

  Widget  myProfile() {
    return  Container(
      //color: Color(0xFFD43236),
      height: 350,
      color: Color(0xFFF5FAFE),
      child: Padding(
        padding: const EdgeInsets.only(left: 10.00,right: 10.00),
        child: Card(
          // clipBehavior: Clip.antiAliasWithSaveLayer,
           color: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5),
                topRight: Radius.circular(5),
                bottomRight: Radius.circular(5),
                bottomLeft: Radius.circular(5),
              ),
              side: BorderSide(width: 1, color: Color(0xFF2372B6))),
          child: Container(
            color: Color(0xFFD2E4FC),

            child: Column(
              // mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Text(
                          "Ipsita Sahoo",
                          style: TextStyle(color: Colors.blue, fontSize: 20),
                        ),
                        Spacer(),
                        Icon(
                          Icons.edit,
                          color: Color(0xFF2372B6),
                          size: 40,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Container(
                          width:100,
                          child: Text(

                            "Birth Date",
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          ),
                        ),
                        Text(
                          "   :   ",
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                        Text(
                          "01-06-1997",
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Container(
                          width:100,
                          child: Text(
                            "Gender",
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          ),
                        ),
                        Text(
                          "   :   ",
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                        Text(
                          "Female",
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),

                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Container(
                          width:100,
                          child: Text(
                            "Education",
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          ),
                        ),
                        Text(
                          "   :   ",
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                        Text(
                          "MCA",
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Container(
                          width:100,
                          child: Text(
                            "Specialty",
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          ),
                        ),
                        Text(
                          "   :   ",
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                        Text(
                          "Software Developer",
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Container(
                          width:100,
                          child: Text(
                            "Organization",
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          ),
                        ),
                        Text(
                          "   :   ",
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                        Text(
                          "Nirmaly lab",
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                ]),
          ),
        ),
      ),

    );

  }

  Widget  myIndentification() {
    return  Container(
      height: 355,
      // color: Color(0xFFFEF7F8),
      child: Padding(
        padding: const EdgeInsets.only(left: 10.00,right: 10.00),
        child: Card(
          // clipBehavior: Clip.antiAliasWithSaveLayer,
           color: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5),
                topRight: Radius.circular(5),
                bottomRight: Radius.circular(5),
                bottomLeft: Radius.circular(5),
              ),
              side: BorderSide(width: 1, color: Color(0xFFCF3564))),
          child: Container(
            color: Color(0xFFFEF7F8),
            child: Column(
              // mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child:
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          SizedBox(width: 100,),
                          Text(
                            "My Identification",
                            style: TextStyle(color: Colors.blue, fontSize: 20),
                          ),
                          Spacer(),
                          Icon(
                            Icons.edit,
                            color: Color(0xFFCF3564),
                            size: 40,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Container(
                          width:100,
                          child: Text(
                            "IMA no",
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          ),
                        ),
                        Text(
                          "   :   ",
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                        Text(
                          "01-06-1997",
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Container(
                          width:100,
                          child: Text(
                            "Pan Card No",
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          ),
                        ),
                        Text(
                          "   :   ",
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                        Text(
                          "Female",
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Container(
                          width:100,
                          child: Text(
                            "Passport no",
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          ),
                        ),
                        Text(
                          "   :   ",
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                        Text(
                          "MCA",
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Container(
                          width:100,
                          child: Text(
                            "Aadhar Card No",
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          ),
                        ),
                        Text(
                          "   :   ",
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                        Text(
                          "Software Developer",
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Container(
                          width:100,
                          child: Text(
                            "Voter Card No",
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          ),
                        ),
                        Text(
                          "   :   ",
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                        Text(
                          "Nirmaly lab",
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Container(
                          width:100,
                          child: Text(
                            "License No",
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          ),
                        ),
                        Text(
                          "   :   ",
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                        Text(
                          "Nirmaly lab",
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                ]),
          ),
        ),
      ),

    );

  }
}
