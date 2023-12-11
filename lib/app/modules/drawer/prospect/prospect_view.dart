import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart' hide Gfont, gfont;
import 'package:simple_prospect/app/constants/color_constants.dart';
import 'package:simple_prospect/app/core/text_theme.dart';
import 'package:simple_prospect/app/data/models/model.dart';
import 'package:simple_prospect/app/providers/contact/category_contact_provider.dart';
import 'package:simple_prospect/app/providers/contact/category_contacts_provider.dart';
import 'package:simple_prospect/app/providers/contact/contact_provider.dart';
import 'package:simple_prospect/app/providers/prospect/prospect_provider.dart';
import 'package:simple_prospect/app/widgets/custom_appbar.dart';

class ProspectView extends StatefulWidget {
  const ProspectView({super.key});

  @override
  State<ProspectView> createState() => _ProspectViewState();
}

class _ProspectViewState extends State<ProspectView> {
  @override
  void initState() {
    super.initState();
    initKey();
  }

  Map gkey = {};

  void initKey() {
    List.generate(100, (i) {
      gkey[i] = GlobalKey();
    });
  }

  final ScrollController tabBarController = ScrollController();
  int activeIndex = 0;
  int clickMoreThanOne = 0;

  void centerScrollTab(int i) {
    GlobalKey key = gkey[i];

    RenderBox box = key.currentContext?.findRenderObject() as RenderBox;
    double tabWidth = box.size.width;
    double tabPosition = box.localToGlobal(Offset.zero).dx;

    ScrollController scroll = tabBarController;
    double maxScroll = scroll.position.maxScrollExtent;
    double currentScroll = scroll.position.pixels;
    double screenWidth = context.width;

    double scrollTo = (currentScroll + tabPosition) - (screenWidth / 2) + (tabWidth / 2);
    double pos = scrollTo;

    tabBarController.animateTo(
      pos < 0
          ? 0
          : pos > maxScroll
              ? maxScroll
              : pos,
      duration: Duration(milliseconds: 250),
      curve: Curves.ease,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Prospect',
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 100,
            margin: EdgeInsets.only(left: 10, right: 10, top: 20),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
            final asyncData = ref.watch(categoryContactsProvider);

            return asyncData.when(
              data: (data) {
                if (data.isEmpty) {
                  return LzNoData(
                    message: 'Oops! No data found',
                    onTap: () => ref.read(prospectProvider.notifier).getCatProspect(),
                  );
                }

                return SizedBox(
                  height: context.height * 0.08,
                  child: ListView.separated(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    controller: tabBarController,
                    itemCount: data.length,
                    padding: EdgeInsets.all(10),
                    separatorBuilder: (context, index) {
                      return SizedBox(width: 5);
                    },
                    itemBuilder: (BuildContext context, int index) {
                      CategoryContactModel datas = data[index];
                      String categoryName = datas.categoryName?.toString() ?? '';

                      return AnimatedContainer(
                        key: gkey[index],
                        duration: Duration(milliseconds: 250),
                        child: InkTouch(
                          onTap: () {
                            centerScrollTab(index);
                            setState(() {
                              activeIndex = index;
                            });

                            ref.read(categoryContactProvider.notifier).setCategoryContact(data[index]);
                            ref.read(contactProvider.notifier).getContact(data[index].id ?? 0);
                          },
                          child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: activeIndex == index ? ColorConstants.primaryColor : Colors.grey[300],
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Text(
                              categoryName,
                              style: Gfont.autoSizeText(
                                context,
                                FontSizeManager.getBodyFontSize(),
                                color: Colors.white,
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
                      return Skeleton(radius: 10, margin: EdgeInsets.all(10), size: [100, 50]);
                    },
                  ),
                );
              },
            );
          }),
          // ===========
          // LIST CONTACT
          Consumer(builder: (context, ref, _) {
            final asyncData = ref.watch(contactProvider);

            return asyncData.when(data: (data) {
              if (data.isEmpty) {
                return LzNoData(
                  message: 'Oops! No data found',
                  onTap: () async {
                    await ref.read(prospectProvider.notifier).getCatProspect();
                  },
                );
              }
              return Expanded(
                child: ListView.separated(
                  itemCount: data.length,
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 5);
                  },
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListTile(
                        leading: Icon(
                          Ti.userCircle,
                          color: ColorConstants.primaryColor,
                        ),
                        title: Text(
                          data[index].fullName ?? '',
                          style: Gfont.autoSizeText(context, FontSizeManager.getBodyFontSize()),
                        ),
                      ),
                    );
                  },
                ),
              );
            }, error: (error, _) {
              return LzNoData(message: 'Oops! $error');
            }, loading: () {
              return Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Skeleton(radius: 10, margin: EdgeInsets.all(10), size: [100, 50]);
                  },
                ),
              );
            });
          }),
        ],
      ),
    );
  }
}
