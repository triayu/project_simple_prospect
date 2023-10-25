import 'package:flutter/material.dart';
import 'package:lazyui/lazyui.dart';
import 'package:simple_prospect/app/widgets/custom_appbar.dart';

import '../../../constants/color_constants.dart';
import 'tambah_buku_telepon.dart';

class PhoneBook extends StatefulWidget {
  const PhoneBook({Key? key}) : super(key: key);

  @override
  _PhoneBookState createState() => _PhoneBookState();
}

class _PhoneBookState extends State<PhoneBook> {
  bool isLoading = false;

  void fetchData() async {
    setState(() {
      isLoading = true;
    });

    // Simulasi pembaruan data
    await Future.delayed(Duration(seconds: 2));

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Buku Kontak Telepon',
        actions: [
          IconButton(
              icon: Icon(Ti.plus),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => TambahBukuTelepon(),
                  ),
                );
              }),
        ],
      ),
      body: Center(
        child: isLoading
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(color: ColorConstants.primaryColor),
                  SizedBox(height: 16),
                  Text(
                    'Memuat Data...',
                    style: TextStyle(
                      fontSize: 16,
                      color: ColorConstants.textSecondaryColor,
                    ),
                  ),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LzImage(
                    'wait.png',
                    size: 200,
                  ),
                  Text(
                    'Tidak ada data',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: ColorConstants.textPrimaryColor,
                    ),
                  ),
                  Text(
                    'Data Buku Telepon Tidak Ditemukan',
                    style: TextStyle(
                      fontSize: 14,
                      color: ColorConstants.textSecondaryColor,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      fetchData();
                    },
                    child: Text(
                      'Muat Ulang',
                      style: TextStyle(
                        fontSize: 15,
                        color: ColorConstants.primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
