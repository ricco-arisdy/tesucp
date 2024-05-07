import 'package:flutter/material.dart';

class TambahToko extends StatefulWidget {
  const TambahToko({super.key});

  @override
  State<TambahToko> createState() => _TambahTokoState();
}

class _TambahTokoState extends State<TambahToko> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Toko'),
        backgroundColor: Colors.deepOrange,
      ),
    );
  }
}
