import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart' hide Gfont, gfont;
import 'package:simple_prospect/app/constants/color_constants.dart';
import 'package:simple_prospect/app/core/text_theme.dart';
import 'package:simple_prospect/app/data/models/prospect_model.dart';
import 'package:simple_prospect/app/providers/prospect/prospect_provider.dart';
import 'package:simple_prospect/app/widgets/custom_appbar.dart';

// class ProspectView extends StatefulWidget {
//   const ProspectView({super.key});

//   @override
//   State<ProspectView> createState() => _ProspectViewState();
// }

// class _ProspectViewState extends State<ProspectView> {
//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }

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
                Flexible(
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
                  height: context.height * 0.08,
                  child: ListView.separated(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: data.length,
                    padding: Ei.all(10),
                    separatorBuilder: (context, index) {
                      return SizedBox(width: 5);
                    },
                    itemBuilder: (BuildContext context, int index) {
                      ProspectModel datas = data[index];

                      // int contactId = datas.contactId ?? 0;
                      // String contactName = datas.contactName ?? '';
                      // int contactCategoryId = datas.contactCategoryId ?? 0;
                      String categoryName = datas.categoryName?.toString() ?? '';

                      return Container(
                        padding: Ei.all(10),
                        decoration: BoxDecoration(
                          color: ColorConstants.primaryColor,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(categoryName,
                            style: Gfont.autoSizeText(context, FontSizeManager.getBodyFontSize(), color: Colors.white)),
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
