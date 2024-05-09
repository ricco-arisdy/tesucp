import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tesucp/Halaman_Maps.dart';
import 'package:tesucp/Halaman_Utama.dart';

class UbahToko extends StatefulWidget {
  final Map ListData;
  const UbahToko({super.key, required this.ListData});

  @override
  State<UbahToko> createState() => _UbahTokoState();
}

class _UbahTokoState extends State<UbahToko> {
  final formKey = GlobalKey<FormState>();
  TextEditingController id = TextEditingController();
  TextEditingController nama_toko = TextEditingController();
  TextEditingController alamat = TextEditingController();
  TextEditingController notelp = TextEditingController();
  String? kesanValue;

  Future _ubah() async {
    final respon = await http
        .post(Uri.parse('http://192.168.100.6/api_pam/edit.php'), body: {
      'id': id.text,
      'nama_toko': nama_toko.text,
      'alamat': alamat.text,
      'notelp': notelp.text,
      'kesan': kesanValue ?? '',
    });
    if (respon.statusCode == 200) {
      return true;
    }
    return false;
  }

  @override
  void initState() {
    super.initState();
    // Inisialisasi TextEditingController dengan nilai dari ListData
    id.text = widget.ListData['id'] ?? '';
    nama_toko.text = widget.ListData['nama_toko'] ?? '';
    alamat.text = widget.ListData['alamat'] ?? '';
    notelp.text = widget.ListData['notelp'] ?? '';
    kesanValue = widget.ListData['kesan'] ?? null;
  }

  // Fungsi untuk membuka MapScreen
  _openMapScreen() async {
    final selectedLocation = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => MapScreen(onLocationSelected: (address) {
                // Set alamat yang dipilih ke dalam TextFormField
                setState(() {
                  alamat.text = address;
                });
              })),
    );

    // Jika Anda ingin menangani data yang dipilih dari MapScreen setelah pengguna
    // menyelesaikan pemilihan lokasi, Anda dapat melakukannya di sini
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ubah Toko'),
        backgroundColor: Colors.deepOrange,
      ),
      body: Form(
        key: formKey,
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: nama_toko,
                decoration: InputDecoration(
                  hintText: 'Nama Toko',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Nama toko tidak boleh kosong!";
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: alamat,
                    decoration: InputDecoration(
                      hintText: 'Alamat',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Alamat toko tidak boleh kosong!";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  TextButton(
                    onPressed: _openMapScreen,
                    child: Text(
                      'Pilih Lokasi dari Peta',
                      style: TextStyle(
                        color: Colors.deepOrange,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: notelp,
                decoration: InputDecoration(
                  hintText: 'No Telepon',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "No Telepon toko tidak boleh kosong!";
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              DropdownButtonFormField(
                value: kesanValue,
                onChanged: (newValue) {
                  setState(() {
                    kesanValue = newValue as String?;
                  });
                },
                items: [
                  DropdownMenuItem(
                    value: 'Enak',
                    child: Text('Enak'),
                  ),
                  DropdownMenuItem(
                    value: 'Tidak Enak',
                    child: Text('Tidak Enak'),
                  ),
                ],
                decoration: InputDecoration(
                  hintText: 'Kesan',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Kesan toko tidak boleh kosong!";
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    _ubah().then((value) {
                      final snackBar = SnackBar(
                        content: Text(value
                            ? 'Data berhasil disimpan'
                            : 'Data gagal disimpan'),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      if (value) {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => HalamanToko())),
                          (route) => false,
                        );
                      }
                    });
                  }
                },
                child: Text('Simpan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
