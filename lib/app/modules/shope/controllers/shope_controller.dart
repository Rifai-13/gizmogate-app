import 'package:get/get.dart';

class ShopeController extends GetxController {
  var items = [
    {
      'name': 'Kulkas Sedingin Antartika',
      'price': 12000000,
      'desc': 'Simpan Kesegaran Maksimal, Tanpa Kompromi!',
      'category': 'Perabotan',
      'image': 'assets/Kulkas.jpg'
    },
    {
      'name': 'Alat Pijat Santay!',
      'price': 2000000,
      'desc': 'Relaksasi Instan, Bebas Lelah di Mana Saja!',
      'category': 'Alat Masak',
      'image': 'assets/Alat Pijat.jpg'
    },
    {
      'name': 'Boneka Labubu',
      'price': 2000000,
      'desc': 'Teman Imut yang Bikin Hari Selalu Ceria!',
      'category': 'Perabotan',
      'image': 'assets/Labubu.jpg'
    },
    {
      'name': 'DX Kamen Rider',
      'price': 2000000,
      'desc': 'Hadirkan Aksi Sang Pahlawan di Genggamanmu!',
      'category': 'Elektronik',
      'image': 'assets/DX Kamen Rider.jpg'
    },
    {
      'name': 'Sepeda Listrik Eco',
      'price': 5000000,
      'desc': 'Hemat Energi, Maksimalkan Petualangan!',
      'category': 'Elektronik',
      'image': 'assets/Sepeda Listrik Eco.jpg'
    },
    {
      'name': 'Laptop Acer Nitro',
      'price': 9000000,
      'desc': 'Performa Gahar untuk Kemenangan Tanpa Batas!',
      'category': 'Elektronik',
      'image': 'assets/Acer Nitro 16.jpg'
    },
    {
      'name': 'Mesin Jahit Singer',
      'price': 7000000,
      'desc': 'Kreasi Sempurna di Setiap Jahitan!',
      'category': 'Perabotan',
      'image': 'assets/Mesin Jahit.jpg'
    },
    {
      'name': 'Kompor Induksi',
      'price': 3000000,
      'desc': 'Masak Cepat, Hemat Energi, dan Lebih Aman!',
      'category': 'Alat Masak',
      'image': 'assets/Kompor induksi.jpg'
    },
    {
      'name': 'Televisi LED 32"',
      'price': 3000000,
      'desc': 'Nikmati Hiburan Jernih dengan Tampilan Lebih Luas!',
      'category': 'Elektronik',
      'image': 'assets/TV LED.jpg'
    },
    {
      'name': 'Set Peralatan Dapur',
      'price': 1500000,
      'desc': 'Lengkapi Dapurmu, Ciptakan Masakan Lezat!',
      'category': 'Alat Masak',
      'image': 'assets/Set Peralatan Dapur.jpg'
    },
    {
      'name': 'Meja Makan Kayu',
      'price': 4500000,
      'desc': 'Sentuhan Elegan untuk Momen Kebersamaan yang Hangat!',
      'category': 'Perabotan',
      'image': 'assets/Meja Makan Kayu.jpg'
    },
    {
      'name': 'Speaker Bluetooth',
      'price': 1200000,
      'desc': 'Suara Keren, Musik Tanpa Batas, Dimanapun!',
      'category': 'Elektronik',
      'image': 'assets/Speaker Bluetooth.jpg'
    },
    {
      'name': 'Kamera DSLR Canon',
      'price': 8500000,
      'desc': 'Tangkap Setiap Detil, Abadikan Momen Berkualitas!',
      'category': 'Elektronik',
      'image': 'assets/Camera DSLR Canon.jpg'
    },
  ].obs;

  var searchQuery = ''.obs;
  var selectedCategory = ''.obs;

  var transactionList = <Map<String, dynamic>>[].obs;

  void updateSearchQuery(String query) {
    searchQuery.value = query;
  }

  void addToTransactionList(Map<String, dynamic> item) {
    transactionList.add(item);
  }

  void removeFromTransactionList(Map<String, dynamic> item) {
    transactionList.remove(item);
  }

  void filterByCategory(String category) {
    selectedCategory.value = category;
  }

  List<Map<String, dynamic>> get filteredItems {
    var filtered = items.toList(); // Menghindari referensi langsung ke items

    // Filter berdasarkan kategori
    if (selectedCategory.value.isNotEmpty &&
        selectedCategory.value != 'Semua Kategori') {
      filtered = filtered
          .where((item) => item['category'] == selectedCategory.value)
          .toList();
    }

    // Filter berdasarkan pencarian
    if (searchQuery.value.isNotEmpty) {
      filtered = filtered
          .where((item) => (item['name'] as String)
              .toLowerCase()
              .contains(searchQuery.value.toLowerCase()))
          .toList();
    }

    return filtered;
  }
}
