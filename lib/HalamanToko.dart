import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TambahToko extends StatefulWidget {
  const TambahToko({super.key});

  @override
  State<TambahToko> createState() => _TambahTokoState();
}

class _TambahTokoState extends State<TambahToko> {
  final formKey = GlobalKey<FormState>();
  TextEditingController nama_toko = TextEditingController();

  Future _simpan() async {
    final respon = await http
        .post(Uri.parse('http://192.168.100.6/api_pam/create.php'), body: {
      'nama_toko': nama_toko.text,
    });
    if (respon.statusCode == 200) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Toko'),
        backgroundColor: Colors.deepOrange,
      ),
      body: Form(
        key: formKey,
        child: Container(
            padding: EdgeInsets.all(20),
            child: Column(children: [
              TextFormField(
                controller: nama_toko,
                decoration: InputDecoration(
                  hintText: 'Nama Toko',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Nama toko tidak boleh kosong!";
                  }
                },
              )
            ])),
      ),
    );
  }
}
