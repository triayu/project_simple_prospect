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
      body: Column(
        children: [
          Container(
            height: 100,
            margin: Ei.only(l: 10, r: 10, t: 20),
            padding: Ei.sym(h: 20, v: 10),
            decoration: BoxDecoration(
              color: ColorConstants.primaryColor,
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
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LzImage(
                  'prospect_latar.png',
                  size: 80,
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Carilah sensasi untuk menemukan contact yang anda inginkan.',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // ===========
          // CATEGORY
          Consumer(builder: (context, ref, _) {
            final asyncData = ref.watch(prospectProvider);

            return asyncData.when(
              data: (data) {
                if (data.isEmpty) {
                  return LzNoData(
                    message: 'Oops! No data found',
                    onTap: () => ref.read(prospectProvider.notifier).getProspect(),
                  );
                }

                return SizedBox(
                  height: 90,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: data.length,
                    itemBuilder: (BuildContext context, int index) {
                      ProspectModel datas = data[index];

                      int contactId = datas.contactId ?? 0;
                      String contactName = datas.contactName ?? '';
                      int contactCategoryId = datas.contactCategoryId ?? 0;
                      String categoryName = datas.categoryName?.toString() ?? '';

                      return Container(
                        margin: Ei.only(
                          l: 10,
                          v: 20,
                        ),
                        decoration: BoxDecoration(
                          color: ColorConstants.primaryColor,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              categoryName,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),

                  
                );

                
                
              },
              
              error: (error, _) {
                return LzNoData(message: 'Oops! $error');
              },
              loading: () {
                return SizedBox(
                  height: 90,
                  child: ListView.builder(
                    itemCount: 10,
                    scrollDirection: Axis.horizontal,
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
    );
  }
}
