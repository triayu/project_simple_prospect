import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';
import 'package:simple_prospect/app/constants/color_constants.dart';
import 'package:simple_prospect/app/modules/home/broadcast/message/add_contact_view.dart';
import 'package:simple_prospect/app/modules/home/broadcast/message/add_template_message_view.dart';
import 'package:simple_prospect/app/modules/drawer/contact/contact_view.dart';
import 'package:simple_prospect/app/widgets/custom_appbar.dart';

class SendMessage extends ConsumerWidget {
  const SendMessage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bottomKey = GlobalKey();
    final DataTableSource _source = _dataTableSource();
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Kirim Pesan',
        actions: [
          Icon(
            Ti.plus,
            key: bottomKey,
          ).onPressed(() {
            final options = ['Tambah Kontak', 'Import Kontak', 'Hapus'].options();
            DropX.show(bottomKey.context, options: options, onSelect: (p0) {
              if (p0.option == 'Kirim Pesan') {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => AddContact(),
                ));
              }
              logg(p0.option);
              if (p0.option == 'Edit') {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ContactView(),
                  ),
                );
              } else if (p0 == 'Hapus') {
                // ---
              }
            });
          })
          // onPressed: () {
          //   Navigator.of(context).push(
          //     MaterialPageRoute(
          //       builder: (context) => AddContact(),
          //     ),
          //   );
          // },
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
                    children: [
                      Text(
                        'Pesan',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.',
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
                            style: Gfont.white,
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
                      style: Gfont.black
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
