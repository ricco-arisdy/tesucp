import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:tesucp/Halaman_Utama.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  File? _image;
  String _name = 'Ricco'; // Nama awal
  TextEditingController _phoneNumberController =
      TextEditingController(text: '08287326363');
  TextEditingController _passwordController =
      TextEditingController(text: '123456789');

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  // Fungsi untuk menampilkan dialog dan mengubah nama
  Future<void> _changeName() async {
    String? newName = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        TextEditingController controller = TextEditingController();
        return AlertDialog(
          title: Text('Ganti Nama'),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(hintText: 'Masukkan Nama Baru'),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, controller.text);
              },
              child: Text('Simpan'),
            ),
          ],
        );
      },
    );

    // Jika pengguna menyimpan nama baru, perbarui tampilan
    if (newName != null && newName.isNotEmpty) {
      setState(() {
        _name = newName;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HalamanToko()),
            );
          },
        ),
        title: Text('Profil'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.blueAccent,
                        width: 4.0,
                      ),
                    ),
                    child: CircleAvatar(
                      radius: 75,
                      backgroundColor: Colors.white,
                      backgroundImage:
                          _image != null ? FileImage(_image!) : null,
                      child: _image == null
                          ? Icon(Icons.warning_amber_rounded,
                              size: 50, color: Colors.black)
                          : null,
                    ),
                  ),
                  Positioned(
                    right: -8,
                    bottom: -8,
                    child: IconButton(
                      icon:
                          Icon(Icons.add_circle, color: Colors.blue, size: 30),
                      onPressed: _pickImage,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              ListTile(
                leading: Icon(Icons.person, color: Colors.white),
                title: Text('Nama'),
                trailing: IconButton(
                  icon: Icon(Icons.edit, color: Colors.green),
                  onPressed: _changeName, // Panggil fungsi untuk mengubah nama
                ),
                subtitle: Text(_name, style: TextStyle(color: Colors.black)),
              ),
              SizedBox(height: 20),
              ListTile(
                leading: Icon(Icons.info, color: Colors.white),
                title: Text('Email'),
                subtitle: Text('ricco@gmail.com',
                    style: TextStyle(color: Colors.black)),
              ),
              SizedBox(height: 20),
              ListTile(
                leading: Icon(Icons.phone, color: Colors.white),
                title: Text('Telepon'),
                subtitle: Text('+62 822-4766-3493',
                    style: TextStyle(color: Colors.black)),
              ),
              SizedBox(height: 20),
              Text('bergabung', style: TextStyle(color: Colors.teal)),
              SizedBox(height: 10),
              Text('24/05/2024', style: TextStyle(fontSize: 20)),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}
