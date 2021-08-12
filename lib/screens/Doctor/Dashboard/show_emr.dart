import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:user/scoped-models/MainModel.dart';

class ShowEmr extends StatefulWidget {

  MainModel model;


  ShowEmr({Key key, this.model}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _ShowEmr();
}

class _ShowEmr extends State<ShowEmr> {
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
    return MaterialApp(
      home: DefaultTabController(
        length: 9,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(130.0), // here the desired height

            child: AppBar(
              backgroundColor: Color(0xFF0F6CE1),
              title: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Text(
                      "SHOW EMR",
                      style: TextStyle(color: Colors.white, fontSize: 16.0),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Center(
                    child: Text(
                      " Visit On Aug 09,2021",
                      style: TextStyle(color: Colors.white, fontSize: 14.0),
                    ),
                  )
                ],
              ),
              leading: new Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        SizedBox(width: 10,),
                        GestureDetector(
                          child: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                            size: 25,
                          ),
                          onTap: () async {
                            /*Navigator.push(
                                context,
                                new MaterialPageRoute(
                                    builder: (context) => new WalkPatient()));*/
                            Navigator.pushNamed(context, "/docWalkInReg");
                          },
                        ),
                        SizedBox(
                          width: 7,
                        ),
                        // Container(
                        //   height: 20,
                        //   width: 1,
                        //   child: VerticalDivider(
                        //     thickness: 2,
                        //     color: Colors.white,
                        //   ),
                        // ),
                      ],
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                Column(
                  children: [
                    SizedBox(
                      height: 25,
                    ),
                    Row(children: <Widget>[
                      Icon(
                        Icons.print,
                        color: Colors.white,
                        size: 25,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Icon(
                        Icons.event_note_sharp,
                        color: Colors.white,
                        size: 25,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Icon(
                        Icons.more_vert,
                        color: Colors.white,
                        size: 25,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                    ]),
                  ],
                )
              ],
              bottom: new PreferredSize(
                preferredSize: new Size(200.0, 50.0),
                child: Column(
                  children: [

                    new Container(
                      // width: 200.0,

                      child: TabBar(
                        isScrollable: true,
                        labelColor: Colors.white,
                        indicatorColor: Color(0xFF0F6CE1),
                        labelStyle: TextStyle(fontSize: 15),
                        tabs: [
                          new Container(
                              //  width: 70,
                              height: 50.0,
                              child: new Tab(
                                text: 'PATIENTDETAILS',
                              )),
                          new Container(
                            // width: 100,
                            height: 50.0,
                            child: new Tab(text: 'PATIENTHISTORY'),
                          ),
                          new Container(
                            // width: 80,
                            height: 50.0,
                            child: new Tab(text: 'MEDICATION'),
                          ),
                          new Container(
                            //  width: 100,
                            height: 50.0,
                            child: new Tab(text: 'TESTREPORT'),
                          ),
                          new Container(
                            //  width: 100,
                            height: 50.0,
                            child: new Tab(text: 'LIFESTYLEHISTORY'),
                          ),
                          new Container(
                            //  width: 100,
                            height: 50.0,
                            child: new Tab(text: 'FAMILYDETAILS'),
                          ),
                          new Container(
                            //  width: 100,
                            height: 50.0,
                            child: new Tab(text: 'IMMUNIZATION'),
                          ),
                          new Container(
                            //  width: 100,
                            height: 50.0,
                            child: new Tab(text: 'TREATMENTTRACKER'),
                          ),
                          new Container(
                            //  width: 100,
                            height: 50.0,
                            child: new Tab(text: 'MEDICALDATAUPLOAD'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          body: TabBarView(
            children: [
              PatientDetails(),
              patientHistory(),
              medication(),
              testReport(),
              lifestyleHistory(),
              familyDetails(),
              immunization(),
              treatmentTracker(),
              medicaldataUpload(),
              // SecondScreen(),
            ],
          ),
        ),
      ),
    );
  }

  Widget PatientDetails() {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 0.0, bottom: 0.0, left: 0.0, right: 0.0),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Colors.blue[400], Colors.blue[200]]),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey[200]),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, right: 20, top: 10, bottom: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(55),
                                child: Container(
                                    height: 50,
                                    width: 50,
                                    child: Image.asset(
                                        'assets/images/profile.png',
                                        fit: BoxFit.cover))
                                // height: 95,
                                )),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Ipsita Sahoo",
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 5),
              Center(
                child: Text(
                  "PERSONAL INFORMATION",
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 5),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 100,
                          child: Text(
                            "First Name",
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          ),
                        ),
                        Text(
                          "   :   ",
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                        Text(
                          "Ipsita",
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Container(
                          width: 100,
                          child: Text(
                            "Last Name",
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          ),
                        ),
                        Text(
                          "   :   ",
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                        Text(
                          "Sahoo",
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Container(
                          width: 100,
                          child: Text(
                            "UHID Card No",
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          ),
                        ),
                        Text(
                          "   :   ",
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                        Text(
                          "123456098",
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          width: 100,
                          child: Text(
                            "Blood Group",
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          ),
                        ),
                        Text(
                          "   :   ",
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                        Text(
                          "O+",
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          width: 100,
                          child: Text(
                            "DOB",
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          ),
                        ),
                        Text(
                          "   :   ",
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                        Text(
                          "2021-07-08",
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          width: 100,
                          child: Text(
                            "Age",
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          ),
                        ),
                        Text(
                          "   :   ",
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                        Text(
                          "24",
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          width: 100,
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
                    Row(
                      children: [
                        Container(
                          width: 100,
                          child: Text(
                            "Maritial Status",
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          ),
                        ),
                        Text(
                          "   :   ",
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                        Text(
                          "Single",
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          width: 100,
                          child: Text(
                            "Occupation",
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
                  ],
                ),
              ),
              //personal information
              SizedBox(height: 10),
              Center(
                child: Text(
                  "Address",
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 5),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 100,
                          child: Text(
                            "At",
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          ),
                        ),
                        Text(
                          "   :   ",
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                        Text(
                          "Banguari",
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Container(
                          width: 100,
                          child: Text(
                            "Post ",
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          ),
                        ),
                        Text(
                          "   :   ",
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                        Text(
                          "Banguari",
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Container(
                          width: 100,
                          child: Text(
                            "Pin",
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          ),
                        ),
                        Text(
                          "   :   ",
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                        Text(
                          "752101",
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          width: 100,
                          child: Text(
                            "Dist",
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          ),
                        ),
                        Text(
                          "   :   ",
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                        Text(
                          "O+",
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          width: 100,
                          child: Text(
                            "Khurda",
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          ),
                        ),
                        Text(
                          "   :   ",
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                        Text(
                          "2021-07-08",
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          width: 100,
                          child: Text(
                            "city",
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          ),
                        ),
                        Text(
                          "   :   ",
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                        Text(
                          "Bhubaneswar",
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          width: 100,
                          child: Text(
                            "State",
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          ),
                        ),
                        Text(
                          "   :   ",
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                        Text(
                          "Odisha",
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          width: 100,
                          child: Text(
                            "Country",
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          ),
                        ),
                        Text(
                          "   :   ",
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                        Text(
                          "India",
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              //Address
              SizedBox(height: 10),
              Center(
                child: Text(
                  "EMERGENCY CONTACT",
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 5),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 100,
                          child: Text(
                            "Name",
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          ),
                        ),
                        Text(
                          "   :   ",
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                        Text(
                          "Birabar Sahoo",
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Container(
                          width: 100,
                          child: Text(
                            "Relation ",
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          ),
                        ),
                        Text(
                          "   :   ",
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                        Text(
                          "Father",
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Container(
                          width: 100,
                          child: Text(
                            "Mobile no",
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          ),
                        ),
                        Text(
                          "   :   ",
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                        Text(
                          "9338017204",
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              //emergency contact
              SizedBox(height: 10),
              Center(
                child: Text(
                  "FAMILY DOCTOR",
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 5),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 100,
                          child: Text(
                            "Name",
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          ),
                        ),
                        Text(
                          "   :   ",
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                        Text(
                          "Saswat Jena",
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Container(
                          width: 100,
                          child: Text(
                            "Speciality ",
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          ),
                        ),
                        Text(
                          "   :   ",
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                        Text(
                          "Medicine",
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Container(
                          width: 100,
                          child: Text(
                            "Mobile no",
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          ),
                        ),
                        Text(
                          "   :   ",
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                        Text(
                          "7205456672",
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
//family doctor
              SizedBox(height: 10),
              Center(
                child: Text(
                  "VITAL SIGN",
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 5),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 200,
                          child: Text(
                            "Height (cm)",
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          ),
                        ),
                        Text(
                          "   :   ",
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                        Text(
                          "5'3",
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Container(
                          width: 200,
                          child: Text(
                            "Weight (kg) ",
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          ),
                        ),
                        Text(
                          "   :   ",
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                        Text(
                          "70",
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Container(
                          width: 200,
                          child: Text(
                            "BMI kg/m2s",
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          ),
                        ),
                        Text(
                          "   :   ",
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                        Text(
                          "100",
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),

                    Row(
                      children: [
                        Container(
                          width: 200,
                          child: Text(
                            "Temperature in celsius",
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          ),
                        ),
                        Text(
                          "   :   ",
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                        Text(
                          "92",
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),

                    Row(
                      children: [
                        Container(
                          width: 200,
                          child: Text(
                            "Temperature in Fahrenheit",
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          ),
                        ),
                        Text(
                          "   :   ",
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                        Text(
                          "124",
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),

                    Row(
                      children: [
                        Container(
                          width: 200,
                          child: Text(
                            "Blood Pressure in mmHg",
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          ),
                        ),
                        Text(
                          "   :   ",
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                        Text(
                          "65",
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),

                    Row(
                      children: [
                        Container(
                          width: 200,
                          child: Text(
                            "Systolic / Diastolic",
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          ),
                        ),
                        Text(
                          "   :   ",
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                        Text(
                          "93",
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),

                    Row(
                      children: [
                        Container(
                          width: 200,
                          child: Text(
                            "Pulse per minute",
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          ),
                        ),
                        Text(
                          "   :   ",
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                        Text(
                          "25",
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),

                    Row(
                      children: [
                        Container(
                          width: 200,
                          child: Text(
                            "Respiration bpm",
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          ),
                        ),
                        Text(
                          "   :   ",
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                        Text(
                          "45",
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),

                    Row(
                      children: [
                        Container(
                          width: 200,
                          child: Text(
                            "Oxygen Saturation percentage",
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          ),
                        ),
                        Text(
                          "   :   ",
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                        Text(
                          "160",
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),

                  ],
                ),
              ),
              //vital sign
              SizedBox(height: 5),
              Center(
                child: Text(
                  "ALLERGIES",
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(children: [
                  Container(
                    width: 80,
                    child: Text(
                      "Name",
                      style: TextStyle(color: Colors.black, fontSize: 15),
                    ),
                  ),
                  SizedBox(width: 5,),
                  Container(
                    width: 80,
                    child: Text(
                      "Allergies ",
                      style: TextStyle(color: Colors.black, fontSize: 15),
                    ),
                  ),
                  SizedBox(width: 5,),

                  Container(
                    width: 80,
                    child: Text(
                      "Sevirity",
                      style: TextStyle(color: Colors.black, fontSize: 15),
                    ),
                  ),
                  SizedBox(width: 5,),

                  Container(
                    width: 80,
                    child: Text(
                      "Reaction",
                      style: TextStyle(color: Colors.black, fontSize: 15),
                    ),
                  ),
                ]),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    // scrollDirection: Axis.horizontal,
                    itemCount: 2,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 80,
                                  child: Text(
                                    "Food",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 15),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(width: 5,),
                            Container(
                              width: 80,
                              child: Text(
                                "Panir ",
                                style:
                                    TextStyle(color: Colors.black, fontSize: 15),
                              ),
                            ),
                            SizedBox(width: 5,),
                            Container(
                              width: 80,
                              child: Text(
                                "High",
                                style:
                                    TextStyle(color: Colors.black, fontSize: 15),
                              ),
                            ),
                            Container(
                              width: 80,
                              child: Text(
                                "Food elergy",
                                style:
                                    TextStyle(color: Colors.black, fontSize: 15),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
              //alergic
              SizedBox(height: 10),
              Center(
                child: Text(
                  "BIO MEDICAL IMPLANTS",
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(children: [
                  Container(
                    width: 100,
                    child: Text(
                      "Name",
                      style: TextStyle(color: Colors.black, fontSize: 15),
                    ),
                  ),
                  SizedBox(width:5),
                  Container(
                    width: 100,
                    child: Text(
                      "Reason ",
                      style: TextStyle(color: Colors.black, fontSize: 15),
                    ),
                  ),
                  SizedBox(width:5),

                  Container(
                    width: 120,
                    child: Text(
                      "Implanted Date",
                      style: TextStyle(color: Colors.black, fontSize: 15),
                    ),
                  ),
                ]),
              ),
              ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: 2,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Container(
                          width: 100,
                          child: Text(
                            "PaceMaker",
                            style: TextStyle(
                                color: Colors.black, fontSize: 15),
                          ),
                        ),
                        SizedBox(width:5),
                        Container(
                          width: 100,
                          child: Text(
                            "Reaction ",
                            style:
                                TextStyle(color: Colors.black, fontSize: 15),
                          ),
                        ),
                        SizedBox(width:5),
                        Container(
                          width: 100,
                          child: Text(
                            "11-08-2021",
                            style:
                                TextStyle(color: Colors.black, fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              SizedBox(height:10),

            ],
          ),
        ),
      ),
    );
  }

  Widget patientHistory() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          child: Column(children: [
            SizedBox(height: 5),
            Center(
              child: Text(
                "MEDICAL CONDITION",
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(children: [
                Center(
                  child: Container(
                    width: 200,
                    child: Text(
                      "Medical Condition",
                      style: TextStyle(color: Colors.black, fontSize: 15),
                    ),
                  ),
                ),

                SizedBox(width: 5,),
              ]),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: 2,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 100,
                                child: Text(
                                  "Thyroid",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 15),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(width: 5,),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
            SizedBox(height: 5),
            Center(
              child: Text(
                "MAJOR ILLNESS",
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(children: [
                Container(
                  width: 110,
                  child: Text(
                    "Name",
                    style: TextStyle(color: Colors.black, fontSize: 15),
                  ),
                ),
                SizedBox(width: 5,),
                Container(
                  width: 110,
                  child: Text(
                    "Date ",
                    style: TextStyle(color: Colors.black, fontSize: 15),
                  ),
                ),
                SizedBox(width: 5,),

                Container(
                  width: 110,
                  child: Text(
                    "Doctor",
                    style: TextStyle(color: Colors.black, fontSize: 15),
                  ),
                ),
                SizedBox(width: 5,),

              ]),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  // scrollDirection: Axis.horizontal,
                  itemCount: 2,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 110,
                                child: Text(
                                  "Ipsita",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 15),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(width: 5,),
                          Container(
                            width: 110,
                            child: Text(
                              "11-08-2021 ",
                              style:
                              TextStyle(color: Colors.black, fontSize: 15),
                            ),
                          ),
                          SizedBox(width: 5,),
                          Container(
                            width: 110,
                            child: Text(
                              "sarat",
                              style:
                              TextStyle(color: Colors.black, fontSize: 15),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
            SizedBox(height: 5),
            Center(
              child: Text(
                "MAJOR SURGERY",
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(children: [
                Container(
                  width: 130,
                  child: Text(
                    "Major Surgery Id",
                    style: TextStyle(color: Colors.black, fontSize: 15),
                  ),
                ),
                SizedBox(width: 5,),
                Container(
                  width: 100,
                  child: Text(
                    "Name ",
                    style: TextStyle(color: Colors.black, fontSize: 15),
                  ),
                ),
                SizedBox(width: 5,),

                Container(
                  width: 100,
                  child: Text(
                    "Date",
                    style: TextStyle(color: Colors.black, fontSize: 15),
                  ),
                ),
                SizedBox(width: 5,),
              ]),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  // scrollDirection: Axis.horizontal,
                  itemCount: 2,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 100,
                                child: Text(
                                  "1001",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 15),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            width: 130,
                            child: Text(
                              "Major Surgery ",
                              style:
                              TextStyle(color: Colors.black, fontSize: 15),
                            ),
                          ),
                          Container(
                            width: 100,
                            child: Text(
                              "11-08-2021",
                              style:
                              TextStyle(color: Colors.black, fontSize: 15),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
            SizedBox(height: 5),
            Center(
              child: Text(
                "TRANSCRIPTED MAJOR SURGERY",
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(children: [
                Container(
                  width: 200,
                  child: Center(
                    child: Text(
                      "Transcripted Major Surgery",
                      style: TextStyle(color: Colors.black, fontSize: 15),
                    ),
                  ),
                ),
                SizedBox(width: 5,),

              ]),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  // scrollDirection: Axis.horizontal,
                  itemCount: 2,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 200,
                                child: Text(
                                  "no records found",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 15),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(width: 5,),
                          
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),

          ]),
        ),
      ),
    );
  }

  Widget medication() {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: 0.0, bottom: 0.0, left: 0.0, right: 0.0),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.blue[400], Colors.blue[200]]),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey[200]),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 20.0, right: 20, top: 10, bottom: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 25,
                      ),
                      Container(
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(55),
                              child: Container(
                                  height: size.height * 0.12,
                                  width: size.width * 0.22,
                                  child: Image.asset(
                                      'assets/images/appointment.png',
                                      fit: BoxFit.cover))
                              // height: 95,

                              )),
                      SizedBox(
                        height: size.height * 0.04,
                      ),
                      Text(
                        "Ipsita Sahoo",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: size.height * 0.04,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  Widget testReport() {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: 0.0, bottom: 0.0, left: 0.0, right: 0.0),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.blue[400], Colors.blue[200]]),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey[200]),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 20.0, right: 20, top: 10, bottom: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 25,
                      ),
                      Container(
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(55),
                              child: Container(
                                  height: size.height * 0.12,
                                  width: size.width * 0.22,
                                  child: Image.asset(
                                      'assets/images/appointment.png',
                                      fit: BoxFit.cover))
                              // height: 95,

                              )),
                      SizedBox(
                        height: size.height * 0.04,
                      ),
                      Text(
                        "Ipsita Sahoo",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: size.height * 0.04,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  Widget lifestyleHistory() {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: 0.0, bottom: 0.0, left: 0.0, right: 0.0),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.blue[400], Colors.blue[200]]),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey[200]),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 20.0, right: 20, top: 10, bottom: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 25,
                      ),
                      Container(
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(55),
                              child: Container(
                                  height: size.height * 0.12,
                                  width: size.width * 0.22,
                                  child: Image.asset(
                                      'assets/images/appointment.png',
                                      fit: BoxFit.cover))
                              // height: 95,

                              )),
                      SizedBox(
                        height: size.height * 0.04,
                      ),
                      Text(
                        "Ipsita Sahoo",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: size.height * 0.04,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  Widget familyDetails() {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: 0.0, bottom: 0.0, left: 0.0, right: 0.0),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.blue[400], Colors.blue[200]]),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey[200]),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 20.0, right: 20, top: 10, bottom: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 25,
                      ),
                      Container(
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(55),
                              child: Container(
                                  height: size.height * 0.12,
                                  width: size.width * 0.22,
                                  child: Image.asset(
                                      'assets/images/appointment.png',
                                      fit: BoxFit.cover))
                              // height: 95,

                              )),
                      SizedBox(
                        height: size.height * 0.04,
                      ),
                      Text(
                        "Ipsita Sahoo",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: size.height * 0.04,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  Widget immunization() {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: 0.0, bottom: 0.0, left: 0.0, right: 0.0),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.blue[400], Colors.blue[200]]),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey[200]),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 20.0, right: 20, top: 10, bottom: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 25,
                      ),
                      Container(
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(55),
                              child: Container(
                                  height: size.height * 0.12,
                                  width: size.width * 0.22,
                                  child: Image.asset(
                                      'assets/images/appointment.png',
                                      fit: BoxFit.cover))
                              // height: 95,

                              )),
                      SizedBox(
                        height: size.height * 0.04,
                      ),
                      Text(
                        "Ipsita Sahoo",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: size.height * 0.04,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  Widget treatmentTracker() {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: 0.0, bottom: 0.0, left: 0.0, right: 0.0),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.blue[400], Colors.blue[200]]),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey[200]),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 20.0, right: 20, top: 10, bottom: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 25,
                      ),
                      Container(
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(55),
                              child: Container(
                                  height: size.height * 0.12,
                                  width: size.width * 0.22,
                                  child: Image.asset(
                                      'assets/images/appointment.png',
                                      fit: BoxFit.cover))
                              // height: 95,

                              )),
                      SizedBox(
                        height: size.height * 0.04,
                      ),
                      Text(
                        "Ipsita Sahoo",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: size.height * 0.04,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  Widget medicaldataUpload() {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: 0.0, bottom: 0.0, left: 0.0, right: 0.0),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.blue[400], Colors.blue[200]]),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey[200]),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 20.0, right: 20, top: 10, bottom: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 25,
                      ),
                      Container(
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(55),
                              child: Container(
                                  height: size.height * 0.12,
                                  width: size.width * 0.22,
                                  child: Image.asset(
                                      'assets/images/appointment.png',
                                      fit: BoxFit.cover))
                              // height: 95,

                              )),
                      SizedBox(
                        height: size.height * 0.04,
                      ),
                      Text(
                        "Ipsita Sahoo",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: size.height * 0.04,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
