import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/shope_controller.dart';

class ShopeView extends GetView<ShopeController> {
  const ShopeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ShopeView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'ShopeView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
