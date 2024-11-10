import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../navbar/views/navbar_view.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(  // Menggunakan SafeArea untuk menghindari gangguan dengan status bar
        child: SingleChildScrollView( // Membungkus seluruh konten di dalam SingleChildScrollView
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 40),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.grey[300],
                    ),
                    SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'User Name',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'Email@gmail.com',
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          'Saldo: Rp1.000.000.000',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 30),
                Text(
                  'DAFTAR TRANSAKSI',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                ListTile(
                  title: Text('Menunggu Pembayaran', style: TextStyle(color: Colors.white)),
                  trailing: Icon(Icons.arrow_forward_ios, color: Colors.white),
                ),
                ListTile(
                  title: Text('Dalam Pengiriman', style: TextStyle(color: Colors.white)),
                  trailing: Icon(Icons.arrow_forward_ios, color: Colors.white),
                ),
                ListTile(
                  title: Text('Pembelian', style: TextStyle(color: Colors.white)),
                  trailing: Icon(Icons.arrow_forward_ios, color: Colors.white),
                ),
                SizedBox(height: 20),
                Text(
                  'LAINNYA',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                ListTile(
                  title: Text('Wishlist', style: TextStyle(color: Colors.white)),
                  trailing: Icon(Icons.arrow_forward_ios, color: Colors.white),
                ),
                ListTile(
                  title: Text('Pesanan Dikomplain', style: TextStyle(color: Colors.white)),
                  trailing: Icon(Icons.arrow_forward_ios, color: Colors.white),
                ),
                SizedBox(height: 20),
                Text(
                  'New Upload',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                // Membungkus produk dalam Scrollable container
                Container(
                  height: 200,  // Membatasi tinggi untuk scroll produk
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,  // Mengurangi ukuran ListView agar tidak meluap
                    physics: BouncingScrollPhysics(),  // Memberikan efek scroll yang halus
                    children: [
                      ProductCard(),
                      ProductCard(),
                      ProductCard(),
                    ],
                  ),
                ),
                SizedBox(height: 20), // Menambahkan jarak agar tidak terlalu padat
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const NavbarView(), // Navbar tetap di bawah
    );
  }
}

class ProductCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 100,
            color: Colors.grey,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Asus TUFF i7 9999HX RTX\n4090 Ti 2TB SSD M.2',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              'Rp 20.000.000',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '1 Jam Lalu',
              style: TextStyle(fontSize: 10, color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}
