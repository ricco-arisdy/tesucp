import 'package:flutter/material.dart';

class DetailToko extends StatefulWidget {
  final Map ListData;
  DetailToko({Key? key, required this.ListData}) : super(key: key);

  //const DetailToko({super.key});

  @override
  State<DetailToko> createState() => _DetailTokoState();
}

class _DetailTokoState extends State<DetailToko> {
  final formKey = GlobalKey<FormState>();
  TextEditingController id = TextEditingController();
  TextEditingController nama_toko = TextEditingController();
  TextEditingController alamat = TextEditingController();
  TextEditingController notelp = TextEditingController();
  TextEditingController kesan = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Inisialisasi TextEditingController dengan nilai dari ListData
    id.text = widget.ListData['id'] ?? '';
    nama_toko.text = widget.ListData['nama_toko'] ?? '';
    alamat.text = widget.ListData['alamat'] ?? '';
    notelp.text = widget.ListData['notelp'] ?? '';
    kesan.text = widget.ListData['kesan'] ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Toko'),
        backgroundColor: Colors.deepOrange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Card(
          elevation: 12,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  title: Text('ID Toko'),
                  subtitle: Text(
                    widget.ListData['id'],
                  ),
                ),
                ListTile(
                  title: Text('Nama Toko'),
                  subtitle: Text(
                    widget.ListData['nama_toko'],
                  ),
                ),
                ListTile(
                  title: Text('Alamat Toko'),
                  subtitle: Text(
                    widget.ListData['alamat'],
                  ),
                ),
                ListTile(
                  title: Text('No Telepon'),
                  subtitle: Text(
                    widget.ListData['notelp'],
                  ),
                ),
                ListTile(
                  title: Text('Kesan'),
                  subtitle: Text(
                    widget.ListData['kesan'],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
