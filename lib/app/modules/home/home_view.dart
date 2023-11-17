import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';
import 'package:simple_prospect/app/modules/home/broadcast/broadcast_view.dart';
import 'package:simple_prospect/app/modules/home/widgets/wi_dashboard/drawer_widget.dart';
import '../../constants/color_constants.dart';
import '../../providers/home/home_state_provider.dart';

import '../dialog/dialog_task_view.dart';
import '../profile/profile_view.dart';
import 'dashboard_view.dart';
import '../event/event_view.dart';
import 'task_view.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(homeProvider.notifier);

    List<Widget?> homes = [DashBoardView(), EventView(), BroadcastView(), TaskView(), ProfileView()];
    List<IconData?> icon = [
      Ti.home,
      Ti.calendar,
      null,
      Ti.list,
      Ti.user,
    ];
    List<String?> title = ['Home', 'Event', null, 'Task', 'Profile'];

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        actions: [
          ref.watch(homeProvider).activeIndex != 0
              ? InkTouch(
                  onTap: () {
                    // if (notifier.activeIndex == 1) {
                    //   // showDialog(
                    //   //     context: context,
                    //   //     builder: (context) {
                    //   //       return DialogContactView();
                    //   //     });
                    // }

                    if (notifier.activeIndex == 3) {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return DialogTaskView();
                          });
                    }
                  },
                  child: Padding(
                    padding: Ei.all(15),
                    child: Icon(Ti.filterPlus),
                  ),
                )
              : Row(
                  children: [
                    InkTouch(
                        margin: Ei.all(10),
                        child: Icon(
                          Ti.bellFilled,
                          size: 25,
                          color: ColorConstants.softBlack,
                        )),
                    InkTouch(
                      onTap: () {
                        // Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileView()));
                      },
                      margin: Ei.only(r: 10),
                      child: SizedBox(
                        width: 45,
                        height: 45,
                        child: ClipOval(
                          child: LzImage(
                            'poto.jpg',
                            size: context.width,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
        ],
        title: Text(
          title[notifier.activeIndex] ?? '',
        ),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(
                Ti.alignJustified,
                size: 25,
                color: Colors.black,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      drawer: WiDrawer(),
      body: SafeArea(
        child: notifier.watch(
          (state) {
            return Stack(
              children: List<Widget>.generate(homes.length, (i) {
                bool isActive = state.activeIndex == i;

                return IgnorePointer(
                  ignoring: !isActive,
                  child: AnimatedOpacity(duration: 250.ms, opacity: isActive ? 1 : 0, child: homes[state.activeIndex]),
                );
              }),
            );
          },
        ),
      ),
      bottomNavigationBar: notifier.watch(
        (state) {
          return Container(
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: Offset(0, 10),
              ),
            ]),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Intrinsic(
                  children: List.generate(homes.length, (i) {
                    return Expanded(
                      child: InkTouch(
                        onTap: () {
                          state.setNavigation(i);
                        },
                        padding: i == 5 ? Ei.all(10) : Ei.all(15),
                        color: ColorConstants.secondaryColor,
                        child: i == 5
                            ? Container(
                                // decoration: BoxDecoration(boxShadow: [BoxShadow(blurRadius: 0.3)]),
                                )
                            : Column(
                                children: [
                                  Icon(
                                    icon[i],
                                    size: 25,
                                    color: state.activeIndex == i ? ColorConstants.primaryColor : Colors.black45,
                                  ),
                                  title[i] != null
                                      ? Text(
                                          title[i]!,
                                          style: Gfont.fs(10).copyWith(
                                            fontWeight: state.activeIndex == i ? FontWeight.bold : FontWeight.normal,
                                            color:
                                                state.activeIndex == i ? ColorConstants.primaryColor : Colors.black45,
                                          ),
                                        )
                                      : None()
                                ],
                              ),
                      ),
                    );
                  }),
                ),
                Positioned.fill(
                  top: -30,
                  child: Align(
                    alignment: Alignment.center,
                    child: InkTouch(
                      onTap: () {
                        state.setNavigation(2);
                      },
                      child: Container(
                        padding: Ei.all(15),
                        decoration: BoxDecoration(boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                          ),
                        ], color: ColorConstants.secondaryColor, borderRadius: Br.circle),
                        child: LzImage('logo.png', fit: BoxFit.cover, size: 45),
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
