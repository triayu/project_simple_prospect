import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final contactListProvider = StateProvider<List<String>>((ref) {
  // Isi data kontak awal di sini
  return [
    'Kontak 1',
    'Kontak 2',
    'Kontak 3',
    // Tambahkan lebih banyak kontak jika diperlukan
  ];
});

final searchQueryProvider = StateProvider<String?>((ref) {
  return null;
});
