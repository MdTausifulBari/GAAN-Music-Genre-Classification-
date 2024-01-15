import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:gaan/screens/services/auth.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:file_picker/file_picker.dart';
import 'package:gaan/shared/loading.dart';

import 'package:gaan/screens/home/result.dart';

class Home extends StatefulWidget {
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String label = '';

  bool loading = false;

  final AuthService _auth = AuthService();

  List<PlatformFile>? _files;

  // void _addMusic() async {
  //
  //   // Add the file Path
  //
  //   _files = (await FilePicker.platform.pickFiles(
  //       type: FileType.any,
  //       allowMultiple: false,
  //       allowedExtensions: null
  //   ))!.files;
  //
  //   print('Loaded file path is : ${_files!.first.path}');
  //
  //   // Sent the Music file to the Model for Processing
  //
  //   var uri = Uri.parse('http://192.168.31.151/api/upload.php');
  //   var request = http.MultipartRequest('POST', uri);
  //   request.files.add(await http.MultipartFile.fromPath('file', _files!.first.path.toString()));
  //   var response = await request.send();
  //   if(response.statusCode == 200) {
  //     print('Loaded ...');
  //
  //     final response = await http.get(Uri.parse('http://192.168.31.151:5000/genra')); //getting the response from our backend server script
  //
  //     final decoded = json.decode(response.body) as Map<String, dynamic>; //converting it from json to key value pair
  //
  //     setState(() {
  //       level = decoded['level']; //changing the state of our widget on data update
  //     });
  //
  //     print(level);
  //
  //         child: Column(
  //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //           children: [
  //             Text(level, //Text that will be displayed on the screen
  //                 style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
  //           ],
  //         );
  //
  //
  //   } else {
  //     print('Something went wrong!');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              title: Text('Gaan'),
              backgroundColor: Colors.blue,
              elevation: 0.0,
              actions: <Widget>[
                FlatButton.icon(
                  icon: Icon(Icons.person),
                  label: Text('logout'),
                  onPressed: () async {
                    await _auth.signOut();
                  },
                )
              ],
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Center(
                      child: Container(
                    width: 150,
                    height: 60,
                    child: FlatButton(
                      color: Colors.blue,
                      onPressed: () async {
                        // Add the file Path

                        _files = (await FilePicker.platform.pickFiles(
                                type: FileType.any,
                                allowMultiple: false,
                                allowedExtensions: null))!
                            .files;

                        print('Loaded file path is : ${_files!.first.path}');

                        // Sent the Music file to the Model for Processing
                        // default ip: 192.168.31.151

                        var uri =
                            Uri.parse('http://172.20.27.157/api/upload.php');
                        var request = http.MultipartRequest('POST', uri);
                        request.files.add(await http.MultipartFile.fromPath(
                            'file', _files!.first.path.toString()));
                        var response = await request.send();
                        if (response.statusCode == 200) {
                          print('Loaded ...');

                          final response = await http.get(Uri.parse(
                              'http://172.20.27.157:5000/genra')); //getting the response from our backend server script

                          final decoded = json.decode(response.body) as Map<
                              String,
                              dynamic>; //converting it from json to key value pair

                          setState(() {
                            label = decoded[
                                'label']; //changing the state of our widget on data update
                          });

                          label = "Genre : " + label;

                          print(label);

                          setState(() => loading = true);

                          await Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => Result(label: label)));

                          Future.delayed(const Duration(seconds: 2), () {
                            setState(() {
                              loading = false;
                            });
                          });
                        } else {
                          print('Something went wrong!');
                        }
                      },
                      child: Text(
                        'Add Music',
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                  ))
                  // ElevatedButton(onPressed: _addMusic, child: Text('Add Music'))
                ],
              ),
            ),
          );
  }
}
