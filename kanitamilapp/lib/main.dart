import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(BrailleToTamilConverterApp());
}

class BrailleToTamilConverterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Braille to Tamil Converter',
      debugShowCheckedModeBanner: false, 
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BrailleToTamilConverterPage(),
    );
  }
}

class BrailleToTamilConverterPage extends StatefulWidget {
  @override
  _BrailleToTamilConverterPageState createState() =>
      _BrailleToTamilConverterPageState();
}

class _BrailleToTamilConverterPageState
    extends State<BrailleToTamilConverterPage> {
  stt.SpeechToText _speech = stt.SpeechToText();
  TextEditingController _brailleController = TextEditingController();
  String _tamilOutput = '';
  AudioPlayer audioPlayer = AudioPlayer();

  Future<void> _pickAudioFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.audio,
      allowedExtensions: ['mp3', 'wav'], 
    );
    if (result != null) {
      File file = File(result.files.single.path!);
      playAudioFile(file);
      convertAudioToText(file);
    }
  }

  Future<void> playAudioFile(File file) async {
    int result = await audioPlayer.play(file.path, isLocal: true);
    if (result == 1) {
     
    } else {
      
    }
  }

  Future<void> convertAudioToText(File file) async {
    
    String extractedText = 'Some extracted text from audio';
    setState(() {
      _brailleController.text = extractedText;
    });
  }

  void _convertToTamil() {
    
    setState(() {
      _tamilOutput = _brailleController.text;
    });
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    _speech.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Braille to Tamil Converter'),
      ),
      drawer: Drawer( 
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('Settings'),
              onTap: () {
             
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('About'),
              onTap: () {
                
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Column(
                children: <Widget>[
                  Text(
                    'Convert Spoken Text to Braille',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: _pickAudioFile,
                    child: Text('Select Audio File'),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              flex: 2,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text(
                      'Spoken Text:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      controller: _brailleController,
                      decoration: InputDecoration(
                        hintText: 'Extracted Text',
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 5,
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _convertToTamil,
                      child: Text('Convert to Braille'),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Braille Output:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      _tamilOutput,
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
