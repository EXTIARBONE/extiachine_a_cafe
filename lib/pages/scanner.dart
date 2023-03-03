import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_extiachine_a_cafe/pages/shop.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Scanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NFC Scanner',
      home: NfcScanner(),
    );
  }
}

class NfcScanner extends StatefulWidget {
  @override
  _NfcScannerState createState() => _NfcScannerState();
}

class _NfcScannerState extends State<NfcScanner> {
  StreamSubscription<NfcTag>? _stream;
  bool _isScanning = false;
  late NfcTag tag;
  List tag_id = [0];
  

  @override
  void initState() {
    super.initState();
    _startScanning();
    
  }

  

  @override
  void dispose() {
    _stopScanning();
    super.dispose();
  }


  Future<void> _startScanning() async {
    if (!_isScanning) {
      try {
        await NfcManager.instance.startSession(
          onDiscovered: _onTagDiscovered,
          onError: _onTagError,
        );
        setState(() {
          _isScanning = true;
        });
      } catch (e) {
        print('Error starting NFC session: $e');
      }
    }
  }

  Future<void> _stopScanning() async {
    if (_isScanning) {
      try {
        await NfcManager.instance.stopSession();
        setState(() {
          _isScanning = false;
        });
      } catch (e) {
        print('Error stopping NFC session: $e');
      }
    }
  }

  Future<void> _onTagDiscovered(NfcTag tag) async {
    //print('Tag discovered: ${tag.data}');
    Ndef? ndef = Ndef.from(tag);
    if (ndef == null) {
      print('Tag is not compatible with NDEF');
      return;
    } else {
      print(tag.data["nfca"]["identifier"]);
    }
    setState(() {
      tag_id = tag.data["nfca"]["identifier"];
    });

    sleep(Duration(milliseconds: 500));
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Shop()),
    );

    // Do something with the scanned data
  }

  Future<void> _onTagError(Object error) async {
    print('Tag error: $error');
    // Handle error here if necessary
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 203, 251, 228),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("EXTIACHINE A CAFE",
            style: GoogleFonts.montserrat(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 200,),
            Text("Veuillez scanner",
            style: GoogleFonts.montserrat(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text("votre badge",
            style: GoogleFonts.montserrat(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20,),
            Image.asset("assets/loading.gif")
          ],
        ),
      ),
    );
  }
}
