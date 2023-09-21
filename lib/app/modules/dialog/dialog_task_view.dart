import 'package:flutter/material.dart';

class DialogTaskView extends StatelessWidget {
  final String? title;

  const DialogTaskView({Key? key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text(title ?? ''),
      insetPadding: EdgeInsets.zero,
      backgroundColor: Colors.transparent,
      children: [
        SizedBox(height: 20), // Spasi sebelum pilihan teks

        // Kolom teks yang bisa dipilih
        Column(
          children: [
            ListTile(
              title: Text('Pilihan 1'),
              onTap: () {
                // Tambahkan logika ketika Pilihan 1 dipilih
                Navigator.of(context).pop(); // Tutup dialog
              },
            ),
            ListTile(
              title: Text('Pilihan 2'),
              onTap: () {
                // Tambahkan logika ketika Pilihan 2 dipilih
                Navigator.of(context).pop(); // Tutup dialog
              },
            ),
            // Tambahkan ListTile lainnya sesuai kebutuhan
          ],
        ),
      ],
    );
  }
}
