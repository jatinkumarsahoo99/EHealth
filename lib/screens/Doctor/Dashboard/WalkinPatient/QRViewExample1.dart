import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:user/providers/Const.dart';
import 'package:user/providers/api_factory.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:user/widgets/MyWidget.dart';
import 'package:user/widgets/text_field_container.dart';

class QRViewExample1 extends StatefulWidget {
  MainModel model;

  QRViewExample1({
    Key key,
    this.model,
  }) : super(key: key);

  @override
  _QRViewExample1State createState() => _QRViewExample1State();
}

class _QRViewExample1State extends State<QRViewExample1> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode result;
  QRViewController controller;
  TextEditingController _regNo = TextEditingController();
  String regNo;

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller.pauseCamera();
    } else if (Platform.isIOS) {
      controller.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    var scanArea = (MediaQuery.of(context).size.width < 200 ||
            MediaQuery.of(context).size.height < 200)
        ? 150.0
        : 200.0;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: size.height * 0.7,
              child: QRView(
                key: qrKey,
                onQRViewCreated: _onQRViewCreated,
                overlay: QrScannerOverlayShape(
                    borderColor: Colors.red,
                    borderRadius: 10,
                    borderLength: 30,
                    borderWidth: 10,
                    cutOutSize: scanArea),
              ),
            ),
            Container(
              height: size.height * 0.3,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    /*Text(
                      "OR",
                      textAlign: TextAlign.start,
                    ),*/
                    fromField("Reg no"),
                    SizedBox(
                      height: 12,
                    ),
                    MaterialButton(
                      child: Text(
                        "Submit",
                        style: TextStyle(color: Colors.white),
                      ),
                      color: AppData.kPrimaryColor,
                      onPressed: () {
                        if (_regNo.text == null ||
                            _regNo.text == "") {
                          AppData.showInSnackBar(context, "Please scan reg no");
                        } else{
                          controller.dispose();
                          widget.model.regNoValue = _regNo.text.toString();
                          print("regnooooooo"+_regNo.text.toString());
                          Navigator.pushNamed(context, "/docWalkInReg",);
                        }

                        },
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        //Navigator.pop(context,scanData.code.toLowerCase());
        //Navigator.pop
        /*result = scanData;
        _regNo.text = scanData.code;*/
        log("\n\n\n\nval:::"+scanData.code+"\n\n");
        if(scanData.code.contains("REG_UID")) {
          List<String> data=scanData.code.replaceAll("{", "").replaceAll("}", "").split(",");
          result = scanData;
          _regNo.text = data[1].split("=")[1].replaceAll(" ", "");
        }else if(scanData.code.contains("UniqueId")) {
          List<String> data=scanData.code.split("\n");
          log("??LOG DATA??"+data.toString());
          result = scanData;
          _regNo.text = data[0].split(":")[1].replaceAll(" ", "");
        }else{
          result = scanData;
          _regNo.text = scanData.code;
        }
      });
    });
  }

  Widget fromField(String hint) {
    return TextFieldContainer(
      child: TextFormField(
        controller: _regNo,
       /* inputFormatters: [
          UpperCaseTextFormatter(),
          WhitelistingTextInputFormatter(RegExp("[a-zA-Z0-9 ]")),
        ],*/
        enabled: false,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey),
          suffixIcon: Icon(
            Icons.person_rounded,
            color: Colors.transparent,
          ),
        ),
        textAlignVertical: TextAlignVertical.center,
        onChanged: (newValue) {
          setState(() {
            regNo = newValue;
          });
        },
      ),
    );
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
