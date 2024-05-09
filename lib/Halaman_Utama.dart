import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tesucp/Detail_Toko.dart';
import 'package:tesucp/Edit_Toko.dart';
import 'package:tesucp/AddToko.dart';

class HalamanToko extends StatefulWidget {
  const HalamanToko({super.key});

  @override
  State<HalamanToko> createState() => _HalamanTokoState();
}

class _HalamanTokoState extends State<HalamanToko> {
  List _listdata = [];
  bool _loading = true;

  Future _getdata() async {
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

  Future _hapus(String id) async {
    try {
      final respon = await http
          .post(Uri.parse('http://192.168.100.6/api_pam/delete.php'), body: {
        "id": id,
      });
      if (respon.statusCode == 200) {
        return true;
      } else {
        return false;
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
        title: Text('Halaman Data Wisata Kuliner'),
        backgroundColor: Colors.deepOrange,
      ),
      body: _loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: _listdata.length,
              itemBuilder: ((context, index) {
                return Card(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailToko(ListData: {
                                    'id': _listdata[index]['id'],
                                    'nama_toko': _listdata[index]['nama_toko'],
                                    'alamat': _listdata[index]['alamat'],
                                    'notelp': _listdata[index]['notelp'],
                                    'kesan': _listdata[index]['kesan'],
                                  })));
                    },
                    child: ListTile(
                      title: Text(_listdata[index]['nama_toko']),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => UbahToko(
                                            ListData: {
                                              'id': _listdata[index]['id'],
                                              'nama_toko': _listdata[index]
                                                  ['nama_toko'],
                                              'alamat': _listdata[index]
                                                  ['alamat'],
                                              'notelp': _listdata[index]
                                                  ['notelp'],
                                              'kesan': _listdata[index]
                                                  ['kesan'],
                                            },
                                          )));
                            },
                            icon: Icon(Icons.edit),
                          ),
                          IconButton(
                              onPressed: () {
                                showDialog(
                                    barrierDismissible:
                                        false, //untuk mencegah klik sembarangan dan keluar
                                    context: context,
                                    builder: ((context) {
                                      return AlertDialog(
                                        content: Text('Hapus data ini ?'),
                                        actions: [
                                          ElevatedButton(
                                              onPressed: () {
                                                _hapus(_listdata[index]['id'])
                                                    .then((value) {
                                                  Navigator.pushAndRemoveUntil(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: ((context) =>
                                                              HalamanToko())),
                                                      (route) => false);
                                                });
                                              },
                                              child: Text('Hapus')),
                                          ElevatedButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Text('Batal')),
                                        ],
                                      );
                                    }));
                              },
                              icon: Icon(Icons.delete))
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),
      floatingActionButton: FloatingActionButton(
          child: Text(
            '+',
            style: TextStyle(fontSize: 24),
          ),
          backgroundColor: Colors.deepOrange,
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => TambahToko()));
          }),
    );
  }
}
