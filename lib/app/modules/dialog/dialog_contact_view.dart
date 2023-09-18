import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  final String title;
  final String content;
  final String positiveButtonText;
  final Function()? onPositivePressed;

  CustomDialog({
    required this.title,
    required this.content,
    required this.positiveButtonText,
    this.onPositivePressed,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            if (onPositivePressed != null) {
              onPositivePressed!();
            }
          },
          child: Text(positiveButtonText),
        ),
      ],
    );
  }
}

// Fungsi untuk menampilkan dialog
Future<void> showCustomDialog(BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return CustomDialog(
        title: 'Judul Dialog',
        content: 'Isi konten dialog di sini.',
        positiveButtonText: 'OK',
        onPositivePressed: () {
          // Tindakan yang diambil saat tombol OK ditekan
          Navigator.of(context).pop(); // Menutup dialog
          // Tambahkan kode Anda di sini...
        },
      );
    },
  );
}

// Panggil dialog dengan kode Anda
// if (notifier.activeIndex == 1) {
//   logg('Ini Action Contact');
//   showCustomDialog(context);
// }
