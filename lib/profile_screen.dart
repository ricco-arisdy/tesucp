import 'package:flutter/material.dart';
import 'package:tesucp/Halaman_Utama.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 100,
              backgroundColor: Colors.white,
              child: Icon(Icons.warning, size: 100),
            ),
            SizedBox(height: 20),
            Text('Nama Anda', style: TextStyle(color: Colors.teal)),
            SizedBox(height: 10),
            Text('Ricco', style: TextStyle(fontSize: 20)),
            SizedBox(height: 20),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.edit),
            ),
          ],
        ),
      ),
    );
  }
}
