import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HalamanToko extends StatefulWidget {
  const HalamanToko({super.key});

  @override
  State<HalamanToko> createState() => _HalamanTokoState();
}

class _HalamanTokoState extends State<HalamanToko> {

  List _listdata = [];
  bool _loading = true;

  Future _getdata()async{
    try {
      final respon =
          await http.get(Uri.parse('http://192.168.100.6/api_pam/read.php'));
          if (respon.statusCode == 200) {
        final data = jsonDecode(respon.body);
        setState(() {
          _listdata = data;
          _loading = false;
        });
      }

    } catch (e) {
      print(e);
    }
  }
  void initState() {
    _getdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Halaman Toko'),
        backgroundColor: Colors.deepOrange,
      ),
    );
  }
}
