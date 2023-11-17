import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';
import 'package:simple_prospect/app/constants/color_constants.dart';

class ShowEventView extends ConsumerWidget {
  const ShowEventView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Event'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: Ei.sym(v: 5, h: 10),
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('Meeting'),
            _buildInfoContainer([
              _buildListTile("Meeting With", "Client"),
              _buildListTile("Meeting type", "Presentation"),
              _buildListTile("Alamat", "Jl. Lijen, Glagah, Kp. Baru"),
              _buildListTile("No. Telepon", "08123456789"),
            ]),
            _buildSectionTitle('Detail Acara'),
            _buildInfoContainer([
              _buildListTile("Title", "Hari ini meeting dengan client"),
              _buildListTile("Note Event", "Meeting diadakan di cafe gue"),
              _buildListTile("Start Date", "12 November 2023"),
              _buildListTile("End Date", "12 November 2050"),
              _buildListTile("Location", "Jln yang aku cari"),
              _buildListTile("Set Time Reminder", "25.00"),
            ]),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Container(
      padding: Ei.only(t: 10),
      child: Text(
        title,
        textAlign: TextAlign.left,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _buildInfoContainer(List<Widget> children) {
    return Container(
      padding: Ei.sym(v: 5),
      margin: Ei.sym(v: 10),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black.withOpacity(0.1)),
      ),
      child: Column(children: children),
    );
  }

  Widget _buildListTile(String title, String subtitle) {
    return Column(
      children: [
        ListTile(
          title: Text(title, style: TextStyle(color: ColorConstants.textSecondaryColor)),
          subtitle:
              Text(subtitle, style: TextStyle(fontWeight: FontWeight.bold, color: ColorConstants.textPrimaryColor)),
        ),
        Divider(),
      ],
    );
  }
}
