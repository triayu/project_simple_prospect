import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';
import 'package:simple_prospect/app/constants/color_constants.dart';
import 'package:simple_prospect/app/data/models/prospect_model.dart';
import 'package:simple_prospect/app/providers/prospect/prospect_provider.dart';
import 'package:simple_prospect/app/widgets/custom_appbar.dart';

class ProspectView extends ConsumerWidget {
  const ProspectView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Prospect',
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Consumer(builder: (context, ref, _) {
              final asyncData = ref.watch(prospectProvider);

              return asyncData.when(
                data: (data) {
                  if (data.isEmpty) {
                    return LzNoData(
                        message: 'Opps! No data found', onTap: () => ref.read(prospectProvider.notifier).getProspect());
                  }

                  return GridView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5,
                      childAspectRatio: 5 / 2,
                    ),
                    itemCount: data.length,
                    itemBuilder: (BuildContext context, int index) {
                      ProspectModel datas = data[index];

                      int contactId = datas.contactId ?? 0;
                      String contactName = datas.contactName ?? '';
                      int contactCategoryId = datas.contactCategoryId ?? 0;
                      String categoryName = datas.categoryName?.toString() ?? '';

                      logg(categoryName, color: LogColor.red, name: 'Category name');

                      return Container(
                        height: 50,
                        width: 150,
                        decoration: BoxDecoration(
                          color: ColorConstants.primaryColor,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Center(
                          child: Text(
                            categoryName,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
                error: (error, _) {
                  return LzNoData(message: 'Opps! $error');
                },
                loading: () {
                  return SizedBox(
                    height: 90,
                    child: ListView.builder(
                      itemCount: 10,
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Skeleton(radius: 10, margin: Ei.all(10), size: [100, 50]);
                      },
                    ),
                  );
                },
              );
            }),
          ],
        ),
      ),
    );
  }
}
