import 'package:flutter/material.dart';
import 'package:uts_neo/login_activity.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _showPassword = false;
  bool _showConfirmPassword = false;

  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _alamatController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _konfirmasiPasswordController =
      TextEditingController();

  void _showMessage(String message, {bool success = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: success ? Colors.green : Colors.redAccent,
      ),
    );
  }

  void _register() {
    String nama = _namaController.text.trim();
    String alamat = _alamatController.text.trim();
    String username = _usernameController.text.trim();
    String password = _passwordController.text.trim();
    String confirm = _konfirmasiPasswordController.text.trim();

    // Validasi input
    if (nama.isEmpty ||
        alamat.isEmpty ||
        username.isEmpty ||
        password.isEmpty ||
        confirm.isEmpty) {
      _showMessage("Semua field harus diisi!");
      return;
    }

    if (password.length < 8) {
      _showMessage("Password minimal 8 karakter!");
      return;
    }

    if (password != confirm) {
      _showMessage("Konfirmasi password tidak sama!");
      return;
    }

    // Jika validasi berhasil → tampilkan pesan & arahkan ke Login
    _showMessage("Registrasi berhasil! Silakan login.", success: true);
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
        child: Column(
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
                      // Antisipasi jika gambar tidak ditemukan
                      return const Icon(Icons.store, size: 100, color: Colors.blue);
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
            const SizedBox(height: 10),
            const Text(
              "Daftar",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            const Text(
              "Silahkan isi Data Pribadi Anda",
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 20),
            _buildTextField("Nama Lengkap", _namaController),
            const SizedBox(height: 15),
            _buildTextField("Alamat", _alamatController),
            const SizedBox(height: 15),
            _buildTextField("Username", _usernameController,
                icon: Icons.person),
            const SizedBox(height: 15),
            _buildPasswordField(
              label: "Password*",
              controller: _passwordController,
              showPassword: _showPassword,
              onToggle: () => setState(() {
                _showPassword = !_showPassword;
              }),
            ),
            const SizedBox(height: 15),
            _buildPasswordField(
              label: "Konfirmasi Password*",
              controller: _konfirmasiPasswordController,
              showPassword: _showConfirmPassword,
              onToggle: () => setState(() {
                _showConfirmPassword = !_showConfirmPassword;
              }),
            ),
            const SizedBox(height: 30),
            Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  onPressed: _register,
                  child: const Text(
                    "Daftar",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 25),
            Center(
              child: GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  );
                },
                child: const Text.rich(
                  TextSpan(
                    text: "Sudah punya akun? ",
                    style: TextStyle(color: Colors.black54),
                    children: [
                      TextSpan(
                        text: "Login di sini",
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
    );
  }
  Widget _buildTextField(String label, TextEditingController controller,
      {IconData? icon}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style:
                const TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: label,
            prefixIcon: icon != null ? Icon(icon) : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ],
    );
  }
  Widget _buildPasswordField({
    required String label,
    required TextEditingController controller,
    required bool showPassword,
    required VoidCallback onToggle,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style:
                const TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
        TextField(
          controller: controller,
          obscureText: !showPassword,
          decoration: InputDecoration(
            hintText: "Min. 8 characters",
            suffixIcon: IconButton(
              icon: Icon(showPassword ? Icons.visibility : Icons.visibility_off),
              onPressed: onToggle,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ],
    );
  }
}
