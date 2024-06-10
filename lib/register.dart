import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // Controller untuk mengambil nilai dari TextFormField
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String errorMessage = '';

  void initState() {
    ();
    super.initState();
  }
  // Variabel untuk menyimpan pesan error

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: usernameController,
              decoration: const InputDecoration(labelText: 'Username'),
            ),
            TextFormField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextFormField(
              controller: passwordController,
              obscureText: true, // Sembunyikan teks kata sandi
              decoration: const InputDecoration(labelText: 'Password'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                // Proses registrasi di sini
                String username = usernameController.text;
                String email = emailController.text;
                String password = passwordController.text;

                // Panggil fungsi untuk melakukan registrasi
                bool registerSuccess =
                    await _register(username, email, password);

                // Jika registrasi berhasil, navigasi kembali ke halaman login
                if (registerSuccess) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Register berhasil'),
                    ),
                  );
                }
              },
              child: const Text('Register'),
            ),
            if (errorMessage
                .isNotEmpty) // Tampilkan pesan error jika terjadi error
              Text(errorMessage, style: TextStyle(color: Colors.red)),
          ],
        ),
      ),
    );
  }

  // Fungsi untuk melakukan registrasi
  Future<bool> _register(String username, String email, String password) async {
    var url = Uri.parse('http://192.168.0.105/api_pam/register.php');
    var response = await http.post(url, body: {
      'username': username,
      'email': email,
      'password': password,
    });

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      if (jsonResponse['status'] == 'success') {
        // Registrasi berhasil
        return true;
      } else {
        // Registrasi gagal, tampilkan pesan error
        setState(() {
          errorMessage = jsonResponse['message'];
        });
        return false;
      }
    } else {
      // Gagal terhubung ke server
      setState(() {
        errorMessage = 'Gagal terhubung ke server';
      });
      return false;
    }
  }
}
