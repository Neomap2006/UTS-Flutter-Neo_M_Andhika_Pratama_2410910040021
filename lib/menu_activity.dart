import 'package:flutter/material.dart';
import 'package:uts_neo/login_activity.dart';

class MenuActivity extends StatefulWidget {
  const MenuActivity({super.key});

  @override
  State<MenuActivity> createState() => _MenuActivityState();
}

class _MenuActivityState extends State<MenuActivity> {
  final List<Map<String, dynamic>> _products = [
    {
      "name": "Fanta Orange",
      "price": 7000,
      "image": "Gambar/001.jpg",
      "rating": 4.5,
      "qty": 2
    },
    {
      "name": "Fanta Strawberry",
      "price": 7000,
      "image": "Gambar/002.jpg",
      "rating": 4.5,
      "qty": 0
    },
    {
      "name": "Oreo",
      "price": 2000,
      "image": "Gambar/003.jpg",
      "rating": 4.0,
      "qty": 1
    },
    {
      "name": "Coca-Cola",
      "price": 7000,
      "image": "Gambar/004.jpg",
      "rating": 4.5,
      "qty": 1
    },
  ];

  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _filteredProducts = [];

  @override
  void initState() {
    super.initState();
    _filteredProducts = _products;
    _searchController.addListener(_filterProducts);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  int get totalHarga {
    return _filteredProducts.fold(
      0,
      (total, product) => total + (product["price"] as int) * (product["qty"] as int),
    );
  }

  void _filterProducts() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredProducts = _products.where((product) {
        final name = product["name"].toString().toLowerCase();
        return name.contains(query);
      }).toList();
    });
  }

  void _handlePayment() {
    if (totalHarga > 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Memproses pembayaran sebesar Rp.$totalHarga'),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        elevation: 0,
        title: Row(
          children: [
            Image.asset('Gambar/Logo.png', height: 30),
            const SizedBox(width: 8),
            const Text(
              "LKS MART",
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.redAccent),
            onPressed: () => _showLogoutDialog(context),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const Text(
                  "Produk",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.black87,
                  ),
                ),
                const Spacer(),
                SizedBox(
                  width: 150,
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: "Cari Item",
                      prefixIcon: const Icon(Icons.search, size: 20),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.grey[400]!),
                      ),
                      isDense: true,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: _filteredProducts.isEmpty
                ? const Center(child: Text('Tidak ada produk ditemukan'))
                : ListView.builder(
                    padding: const EdgeInsets.all(8.0),
                    itemCount: _filteredProducts.length,
                    itemBuilder: (context, index) {
                      final product = _filteredProducts[index];
                      return _buildProductItem(product);
                    },
                  ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Total Belanja : ",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      "Rp.$totalHarga",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: totalHarga > 0 ? _handlePayment : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    minimumSize: const Size(double.infinity, 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    "Bayar Sekarang",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.grey[200],
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.store),
            label: "Produk",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
        onTap: (index) {
          if (index == 1) {
            // Navigasi ke halaman profil
          }
        },
      ),
    );
  }

  Widget _buildProductItem(Map<String, dynamic> product) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                product["image"],
                width: 60,
                height: 60,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  print("Error loading image: $error");
                  return const Icon(
                    Icons.broken_image_outlined,
                    size: 60,
                    color: Colors.grey,
                  );
                },
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product["name"],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    "Rp. ${product["price"]}",
                    style: const TextStyle(
                      color: Colors.black54,
                      fontSize: 14,
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove_circle_outline),
                        onPressed: () {
                          setState(() {
                            if (product["qty"] > 0) product["qty"]--;
                          });
                        },
                      ),
                      Text(product["qty"].toString()),
                      IconButton(
                        icon: const Icon(Icons.add_circle_outline),
                        onPressed: () {
                          setState(() {
                            product["qty"]++;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 16),
                    Text(
                      product["rating"].toString(),
                      style: const TextStyle(fontSize: 12),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                IconButton(
                  icon: const Icon(Icons.add_shopping_cart, color: Colors.blue),
                  onPressed: () {
                    setState(() {
                      product["qty"]++;
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Konfirmasi Logout"),
        content: const Text("Apakah Anda yakin ingin keluar?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Batal"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
                (route) => false,
              );
            },
            child: const Text(
              "Keluar",
              style: TextStyle(color: Colors.redAccent),
            ),
          ),
        ],
      ),
    );
  }
}