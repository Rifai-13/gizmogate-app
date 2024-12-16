import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gizmogate/app/modules/auth-admin/views/auth_admin_view.dart';
import '../../auth-admin/controllers/auth_admin_controller.dart';
import '../../consign/views/consign_view.dart';
import '../../navbar/views/navbar_view.dart';

class AdminView extends StatelessWidget {
  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Consign'),
        actions: [
          // Tombol Pengaturan
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              // Logika untuk pengaturan
              Get.snackbar('Settings', 'Settings menu clicked!');
            },
          ),
          // Tombol Logout
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              // Tampilkan dialog konfirmasi
              final confirm = await showDialog<bool>(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Logout'),
                    content: Text('Apakah Anda yakin ingin logout?'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(false); // Batalkan logout
                        },
                        child: Text('Batal'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(true); // Konfirmasi logout
                        },
                        child: Text('Ya'),
                      ),
                    ],
                  );
                },
              );

              // Jika pengguna mengonfirmasi, lakukan logout
              if (confirm == true) {
                await authController.logout();
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Bagian Fitur Terkunci
            Obx(() {
              return Container(
                color: authController.isLoggedIn.value
                    ? Colors.green
                    : Colors.black,
                padding: EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          authController.isLoggedIn.value
                              ? Icons.lock_open
                              : Icons.lock,
                          color: Colors.white,
                        ),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              authController.isLoggedIn.value
                                  ? 'Fitur Terbuka'
                                  : 'Fitur Terkunci',
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(
                              authController.isLoggedIn.value
                                  ? 'Anda memiliki akses penuh.'
                                  : 'Daftar untuk membuka akses.',
                              style: TextStyle(color: Colors.white70),
                            ),
                          ],
                        ),
                      ],
                    ),
                    if (!authController.isLoggedIn.value)
                      MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: ElevatedButton(
                          onPressed: () {
                            // Navigasi ke AuthAdminView jika belum login
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AuthView()),
                            );
                          },
                          child: Text('Login'),
                        ),
                      ),
                  ],
                ),
              );
            }),
            Divider(height: 0),
            SizedBox(height: 16),
            // Bagian Upload Produk
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Upload Produk',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Obx(() {
                    return HoverCard(
                      child: ListTile(
                        leading: Icon(Icons.add_box_outlined),
                        title: Text('Jual Produk Kamu Disini!'),
                        subtitle:
                            Text('Proses transaksi aman, mudah, dan nyaman.'),
                        trailing: authController.isLoggedIn.value
                            ? Icon(Icons.check_circle, color: Colors.green)
                            : Icon(Icons.lock, color: Colors.red),
                        onTap: authController.isLoggedIn.value
                            ? () {
                                // Navigasi ke ConsignView
                                Get.to(() => ConsignView());
                              }
                            : null, // Disabled jika belum login
                      ),
                    );
                  }),

                  SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      // Logika untuk klik di sini
                      Get.snackbar('Info', 'Harga fee dapat dilihat di sini.');
                    },
                    child: Text(
                      'Cek harga fee, klik disini.',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                  SizedBox(height: 10),
                  // Bagian Status Pengajuan Produk
                  Obx(() {
                    return MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: HoverCard(
                        child: ListTile(
                          leading: Icon(Icons.sync_outlined),
                          title: Text('Status Pengajuan Produk'),
                          subtitle: Text('0 Produk'),
                          trailing: authController.isLoggedIn.value
                              ? Icon(Icons.check_circle, color: Colors.green)
                              : Icon(Icons.lock, color: Colors.red),
                          onTap: authController.isLoggedIn.value
                              ? () {
                                  Get.snackbar('Akses Diterima',
                                      'Mengakses status pengajuan produk.');
                                }
                              : null, // Disabled jika belum login
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
            SizedBox(height: 16),
            // Bagian Kelola Produk
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Kelola Produk',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Obx(() {
                    return MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: HoverCard(
                        child: ListTile(
                          leading: Icon(Icons.list),
                          title: Text('Daftar Produk'),
                          subtitle: Text('0 Produk'),
                          trailing: authController.isLoggedIn.value
                              ? Icon(Icons.check_circle, color: Colors.green)
                              : Icon(Icons.lock, color: Colors.red),
                          onTap: authController.isLoggedIn.value
                              ? () {
                                  Get.snackbar('Akses Diterima',
                                      'Mengakses daftar produk.');
                                }
                              : null, // Disabled jika belum login
                        ),
                      ),
                    );
                  }),
                  SizedBox(height: 10),
                  Obx(() {
                    return MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: HoverCard(
                        child: ListTile(
                          leading: Icon(Icons.storefront),
                          title: Text('Etalase Produk'),
                          subtitle: Text('0 Etalase'),
                          trailing: authController.isLoggedIn.value
                              ? Icon(Icons.check_circle, color: Colors.green)
                              : Icon(Icons.lock, color: Colors.red),
                          onTap: authController.isLoggedIn.value
                              ? () {
                                  Get.snackbar('Akses Diterima',
                                      'Mengakses etalase produk.');
                                }
                              : null, // Disabled jika belum login
                        ),
                      ),
                    );
                  }),
                  SizedBox(height: 10),
                  Obx(() {
                    return MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: HoverCard(
                        child: ListTile(
                          leading: Icon(Icons.drafts),
                          title: Text('Draft Produk'),
                          subtitle: Text('0 Produk'),
                          trailing: authController.isLoggedIn.value
                              ? Icon(Icons.check_circle, color: Colors.green)
                              : Icon(Icons.lock, color: Colors.red),
                          onTap: authController.isLoggedIn.value
                              ? () {
                                  Get.snackbar('Akses Diterima',
                                      'Mengakses draft produk.');
                                }
                              : null, // Disabled jika belum login
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
            SizedBox(height: 16),
            // Pesan Peringatan
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                padding: EdgeInsets.all(16),
                color: Colors.orange[100],
                child: Row(
                  children: [
                    Icon(Icons.warning, color: Colors.orange),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Tidak mengirim pesanan atau membatalkan pesanan sebanyak maksimal 2 kali, dapat membuat akun kamu di suspend.',
                        style: TextStyle(color: Colors.orange[800]),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const NavbarView(),
    );
  }
}

class HoverCard extends StatelessWidget {
  final Widget child;

  const HoverCard({required this.child});

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Card(
        child: child,
      ),
    );
  }
}
