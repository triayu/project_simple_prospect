import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart' hide Gfont, gfont;
import '../../../../constants/color_constants.dart';
import '../../../../core/text_theme.dart';
import '../../../../data/models/message_template_model.dart';
import '../../../../widgets/custom_appbar.dart';
import 'add_contact_view.dart';

class SendMessage extends ConsumerWidget {
  final MessageTemplateModel message;
  const SendMessage({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final key = GlobalKey();
    GlobalKey _iconKey = GlobalKey();
    GlobalKey _inkTouchKey = GlobalKey();

    final DataTableSource _source = _dataTableSource();
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Kirim Pesan',
        actions: [
          InkTouch(
            elevation: 1,
            key: _inkTouchKey,
            child: Container(
              padding: Ei.only(h: 20),
              color: Colors.white,
              child: Icon(
                Ti.plus,
                color: Colors.black,
                size: 30,
                key: _iconKey,
              ),
            ),
            onTap: () {
              final options =
                  ['Tambah Kontak', 'Import Kontak', 'Import From Excel'].options(icons: [Ti.send, Ti.edit, Ti.trash]);
              DropX.show(_inkTouchKey.currentContext, options: options, onSelect: (val) {
                if (val.index == 0) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => AddContact(),
                    ),
                  );
                } else if (val.index == 1) {
                  // Navigator.of(context).push(
                  //   MaterialPageRoute(
                  //     builder: (context) => AddTemplateMessage(data: datas),
                  //   ),
                  // );
                } else if (val.index == 2) {
                  // Handle 'Hapus' option
                }
              });
            },
          ),
        ],
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          Column(
            children: [
              InkWell(
                onTap: () {
                  // Navigator.push(context, MaterialPageRoute(builder: (context) => FormContactView()));
                },
                child: Container(
                  width: context.width,
                  margin: Ei.only(l: 10, r: 10, t: 20),
                  padding: Ei.only(h: 20, v: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 1,
                        offset: Offset(0, 1),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Row(
                        children: [
                          Icon(Ti.send, size: 20),
                          SizedBox(
                            width: 10,
                          ),
                          Textr(
                            '${message.title}',
                            style: Gfont.autoSizeText(context, FontSizeManager.getBodyFontSize()),
                          ),
                        ],
                      ),
                      Text(
                        '${message.message}',
                        textAlign: Ta.justify,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(
                height: 10,
              ),
              Row(
                children: List.generate(3, (i) {
                  List<IconData> icons = [La.fileAlt, La.video, La.image];
                  List<Color> colors = [ColorConstants.event1, ColorConstants.event2, ColorConstants.event3];
                  return Expanded(
                    child: InkTouch(
                      onTap: () {},
                      child: Container(
                        padding: Ei.all(20),
                        height: 100,
                        margin: Ei.sym(h: 5),
                        decoration:
                            BoxDecoration(color: colors[i], borderRadius: BorderRadius.circular(10), boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 5,
                            offset: Offset(0, 5),
                          )
                        ]),
                        child: Column(children: [
                          Icon(
                            icons[i],
                            size: 30,
                            color: colors[i],
                          ),
                          Text(
                            i.toString(),
                            style: Gfont.fs17,
                          ),
                        ]),
                      ),
                    ),
                  );
                }),
              ),
              SizedBox(
                height: 10,
              ),
              // Data Table
              PaginatedDataTable(
                  showCheckboxColumn: false,
                  arrowHeadColor: ColorConstants.textPrimaryColor,
                  availableRowsPerPage: [
                    10,
                    20,
                    30,
                    40,
                    50,
                  ],
                  columns: List.generate(6, (i) {
                    List<String> tittle = ['ID', 'Nama Kontak', 'No HP', 'Status', 'Keterangan', 'Aksi'];
                    return DataColumn(
                        label: Text(
                      tittle[i],
                      style: Gfont.fs19
                          .copyWith(fontWeight: FontWeight.bold, fontSize: 16, color: ColorConstants.textPrimaryColor),
                    ));
                  }),
                  columnSpacing: 40,
                  primary: true,
                  source: _source),
            ],
          ),
        ],
      ),
    );
  }
}

class _dataTableSource extends DataTableSource {
  @override
  DataRow? getRow(int index) {
    final List<Map<String, dynamic>> _datas = List.generate(15, (i) {
      return {
        'Id': index + 1,
        'Nama Kontak': ' Aing Liyer',
        'No Hp': '0821sisanya besok',
        'status': 'Capek Ngoding',
        'Keterangan': 'Pesan sudah terkirim dan tunggu',
        'Aksi': '',
      };
    });

    // Color colorStatus = _ctrl.queues[index].status == 'pending'
    //     ? C.yellow2
    //     : _ctrl.queues[index].status == 'failed'
    //         ? C.red2
    //         : _ctrl.queues[index].status == 'progress'
    //             ? C.blue
    //             : C.green2;

    return DataRow(cells: [
      DataCell(Text(_datas[index]['Id'].toString())),
      DataCell(Text(_datas[index]['Nama Kontak'].toString())),
      DataCell(Text(_datas[index]['No Hp'].toString())),
      DataCell(Container(
          decoration: BoxDecoration(
            color: ColorConstants.accentColor,
            borderRadius: BorderRadius.circular(5),
          ),
          padding: Ei.all(3),
          child: Text(
            _datas[index]['status'].toString(),
            style: Gfont.bold.copyWith(color: ColorConstants.secondaryColor, fontSize: 12),
          ))),
      DataCell(Text(_datas[index]['Keterangan'].toString())),
      DataCell(Text('Action')),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => 15;

  @override
  int get selectedRowCount => 0;
}
