import 'package:flutter/material.dart';
import 'package:lazyui/lazyui.dart';
import 'package:simple_prospect/app/constants/color_constants.dart';
import 'package:simple_prospect/app/modules/form/form_contact/form_contact_view.dart';
import 'package:simple_prospect/app/modules/home/contact/edit_message_view.dart';
import 'package:simple_prospect/app/widgets/custom_appbar.dart';

class ManageContact extends StatefulWidget {
  const ManageContact({Key? key}) : super(key: key);

  @override
  _ManageContactState createState() => _ManageContactState();
}

class _ManageContactState extends State<ManageContact> {
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
    final key = GlobalKey(), bottomKey = GlobalKey();
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Kelola Kontak',
        actions: [
          Icon(
            Ti.menu2,
            color: Colors.black,
            key: bottomKey,
          ).onPressed(() {
            final options = ['Tambah kontak', 'Export Contact', 'Import from Excel'].options();
            DropX.show(bottomKey, options: options, onSelect: (p0) {
              logg(p0.option);
              if (p0.option == 'Tambah kontak') {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => FormContactView(),
                ));
              }
              logg(p0.option);
              if (p0.option == 'Export Contact') {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => FormContactView(),
                ));
              } else if (p0 == 'Import from Excel') {
                // ---
              }
            });
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
