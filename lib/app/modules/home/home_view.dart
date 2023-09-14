import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';
import 'package:simple_prospect/app/modules/home/widgets/wi_dashboard/drawer_widget.dart';
import '../../constants/color_constants.dart';
import '../../providers/home/home_state_provider.dart';
import '../../widgets/custom_appbar.dart';
import 'contact_view.dart';
import 'dashboard_view.dart';
import 'event_view.dart';
import 'task_view.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(homeProvider.notifier);

    List<Widget> homes = [DashBoardView(), ContactView(), EventView(), TaskView()];
    List<IconData> icon = [Ti.home, Ti.addressBook, Ti.calendar, Ti.list];
    List<String> title = ['Home', 'Contact', 'Event', 'Task'];

    logg(notifier.activeIndex);

    return Scaffold(
      appBar: ref.watch(homeProvider).activeIndex != 0
          ? CustomAppBar(
              title: title[notifier.activeIndex],
              leading: Builder(
                builder: (BuildContext context) {
                  return IconButton(
                    icon: Icon(Icons.menu),
                    onPressed: () {
                      ;
                    },
                  );
                },
              ),
            )
          : null,
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
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: ColorConstants.textSecondaryColor,
                  blurRadius: 10,
                  offset: Offset(0, -5),
                )
              ],
            ),
            child: Intrinsic(
              children: List.generate(homes.length, (i) {
                return Expanded(
                  child: InkTouch(
                    onTap: () {
                      state.setNavigation(i);
                    },
                    padding: Ei.all(20),
                    color: ColorConstants.secondaryColor,
                    child: Column(
                      children: [
                        Icon(
                          icon[i],
                          size: 25,
                          color: state.activeIndex == i ? Colors.black87 : Colors.black45,
                        ),
                        Text(
                          title[i],
                          style: Gfont.fs(12).copyWith(
                            color: state.activeIndex == i ? Colors.black87 : Colors.black45,
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }),
            ),
          );
        },
      ),
    );
  }
}
