import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';
import '../../navbar/views/navbar_view.dart';
import '../controllers/shope_controller.dart';

class ShopeView extends StatefulWidget {
  @override
  _ShopeViewState createState() => _ShopeViewState();
}

class _ShopeViewState extends State<ShopeView> {
  final ShopeController controller = Get.find<ShopeController>();
  // int _selectedIndex = 1; // Set the initial index to 1 for Shopee tab

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              'assets/bg_home.png',
              fit: BoxFit.cover,
            ),
          ),
          // Main content
          Column(
            children: [
              AppBar(
                title: Container(
                  height: 40,
                  width: MediaQuery.of(context).size.width * 1,
                  child: TextField(
                    onChanged: (query) => controller.updateSearchQuery(query),
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      hintText: 'Cari di Second\'s Hands...',
                      hintStyle: TextStyle(color: Colors.black54),
                      prefixIcon: Icon(Icons.search, color: Colors.black),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                actions: [
                  IconButton(
                      icon: Icon(Icons.notifications, color: Colors.white),
                      onPressed: () {}),
                  IconButton(
                      icon: Icon(Icons.shopping_cart, color: Colors.white),
                      onPressed: () {}),
                  IconButton(
                    icon: Icon(Icons.person, color: Colors.white),
                    onPressed: () {},
                  )
                ],
                backgroundColor: Colors.transparent,
                elevation: 0,
              ),
              SizedBox(height: 16),
              Container(
                height: 120,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildProductImage('assets/Labubu.jpg'),
                      _buildProductImage('assets/Kompor induksi.jpg'),
                      _buildProductImage('assets/Kulkas.jpg'),
                      _buildProductImage('assets/Alat Pijat.jpg'),
                      _buildProductImage('assets/DX Kamen Rider.jpg'),
                      _buildProductImage('assets/Sepeda Listrik Eco.jpg'),
                      _buildProductImage('assets/Acer Nitro 16.jpg'),
                      _buildProductImage('assets/Mesin Jahit.jpg'),
                      _buildProductImage('assets/TV LED.jpg'),
                      _buildProductImage('assets/Set Peralatan Dapur.jpg'),
                      _buildProductImage('assets/Meja Makan Kayu.jpg'),
                      _buildProductImage('assets/Speaker Bluetooth.jpg'),
                      _buildProductImage('assets/Camera DSLR Canon.jpg'),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  children: [
                    _buildCategoryButton('Semua Kategori', Icons.list),
                    _buildCategoryButton('Alat Masak', Icons.kitchen),
                    _buildCategoryButton('Perabotan', Icons.chair),
                    _buildCategoryButton(
                        'Elektronik', Icons.electrical_services),
                  ],
                ),
              ),
              SizedBox(height: 19),
              Expanded(
                child: Obx(
                  () => ListView.builder(
                    itemCount: controller.filteredItems.length,
                    itemBuilder: (context, index) {
                      final item = controller.filteredItems[index];
                      return GestureDetector(
                        onTap: () {
                          Get.toNamed(Routes.DETAIL_PESANAN,arguments: item);
                        },
                        child: Card(
                          margin: EdgeInsets.all(8),
                          color: Colors.white,
                          child: MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: ListTile(
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.asset(
                                  item['image'],
                                  width: 60,
                                  height: 60,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              title: MouseRegion(
                                cursor: SystemMouseCursors.click,
                                child: Text(
                                  item['name'],
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item['desc'],
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        'Rp${item['price']},-',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                        ),
                                      ),
                                      Spacer(),
                                      Column(
                                        children: [
                                          SizedBox(height: 4),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 4, vertical: 2),
                                            decoration: BoxDecoration(
                                              color: Colors.green,
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: Text(
                                              item['category'],
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 10,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              trailing: PopupMenuButton<String>(
                                icon: Icon(Icons.more_vert),
                                onSelected: (String value) {
                                  if (value == 'edit') {
                                    // Handle edit action
                                    print('Edit item: ${item['name']}');
                                  } else if (value == 'delete') {
                                    print('Delete item: ${item['name']}');
                                  }
                                },
                                itemBuilder: (BuildContext context) => [
                                  PopupMenuItem<String>(
                                    value: 'edit',
                                    child: Text(
                                      'Edit',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  PopupMenuItem<String>(
                                    value: 'delete',
                                    child: Text(
                                      'Delete',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ],
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: const NavbarView(),
    );
  }

  Widget _buildProductImage(String imagePath) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: 4), // Padding outside MouseRegion
      child: MouseRegion(
        cursor: SystemMouseCursors
            .click, // Pointer cursor only active on the image area
        child: GestureDetector(
          onTap: () {
            // Show enlarged image when tapped
            _showEnlargedImage(imagePath);
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              imagePath,
              width: 120,
              height: 120,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryButton(String category, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Obx(
        () => ElevatedButton.icon(
          onPressed: () {
            controller.filterByCategory(category);
          },
          icon: Icon(
            icon,
            size: 18,
            color: controller.selectedCategory.value == category
                ? Colors.white
                : Colors.black,
          ),
          label: Text(
            category,
            style: TextStyle(
              color: controller.selectedCategory.value == category
                  ? Colors.white
                  : Colors.black,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: controller.selectedCategory.value == category
                ? Colors.green
                : Colors.white,
          ),
        ),
      ),
    );
  }

  void _showEnlargedImage(String imagePath) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.7,
            child: Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.contain, // Ensure the image scales appropriately
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
