import 'package:flutter/material.dart';
import 'package:uts_neo/daftar_activity.dart';
import 'package:uts_neo/menu_activity.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _showPassword = false;
  bool _rememberMe = false;

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Fungsi untuk menampilkan pesan
  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.redAccent,
      ),
    );
  }
  void _login() {
    String username = _usernameController.text.trim();
    String password = _passwordController.text.trim();
    if (username.isEmpty || password.isEmpty) {
      _showMessage("Username dan Password tidak boleh kosong!");
    } else if (password.length < 8) {
      _showMessage("Password minimal 8 karakter!");
    } else {
      // Jika berhasil login → navigasi ke MenuActivity
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MenuActivity()),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Column(
                    children: [
                      Image.asset(
                        "Gambar/Logo.png",
                        width: 100,
                        height: 100,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(Icons.store,
                              size: 100, color: Colors.blueAccent);
                        },
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "LKS MART",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                const Text(
                  "Sign In",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                const Text(
                  "Masukkan username dan password untuk masuk!",
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Username",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    hintText: "Masukkan username",
                    prefixIcon: const Icon(Icons.person),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                const Text(
                  "Password*",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextField(
                  controller: _passwordController,
                  obscureText: !_showPassword,
                  decoration: InputDecoration(
                    hintText: "Min. 8 characters",
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _showPassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _showPassword = !_showPassword;
                        });
                      },
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Checkbox(
                      value: _rememberMe,
                      onChanged: (value) {
                        setState(() {
                          _rememberMe = value ?? false;
                        });
                      },
                    ),
                    const Text("Ingat saya"),
                  ],
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: _login,
                    child: const Text(
                      "Login",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      // Balik ke halaman daftar
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RegisterPage()),
                      );
                    },
                    child: const Text.rich(
                      TextSpan(
                        text: "Belum punya akun? ",
                        style: TextStyle(color: Colors.black54),
                        children: [
                          TextSpan(
                            text: "Daftar di sini",
                            style: TextStyle(
                              color: Colors.blueAccent,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
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
