import 'package:flutter/material.dart';

class HalamanToko extends StatefulWidget {
  const HalamanToko({super.key});

  @override
  State<HalamanToko> createState() => _HalamanTokoState();
}

class _HalamanTokoState extends State<HalamanToko> {
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
