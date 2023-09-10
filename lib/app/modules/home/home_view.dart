import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';
import '../../providers/home/home_state_provider.dart';
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
    List<IconData> icon = [Ti.home, Ti.addressBook, Ti.calendar, Ti.clipboard];
    List<String> title = ['Home', 'Contact', 'Event', 'Task'];

    return Scaffold(body: SafeArea(
      child: notifier.watch(
        (state) {
          return Stack(
            children: List<Widget>.generate(homes.length, (i) {
              bool isActive = state.activeIndex == i;

              logg(isActive);

              return IgnorePointer(
                ignoring: !isActive,
                child: AnimatedOpacity(
                  duration: 250.ms,
                  opacity: isActive ? 1 : 0,
                  child: Navigator(
                    onGenerateRoute: (RouteSettings settings) {
                      return MaterialPageRoute(
                        builder: (_) => homes[state.activeIndex],
                        settings: settings,
                      );
                    },
                  ),
                ),
              );
            }),
          );
        },
      ),
    ), bottomNavigationBar: notifier.watch(
      (state) {
        return Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
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
                    logg(notifier.activeIndex);
                  },
                  padding: Ei.all(20),
                  color: Colors.white,
                  child: Column(
                    children: [
                      Icon(
                        icon[i],
                        size: 25,
                        color: state.activeIndex == i ? Colors.black87 : Colors.black45,
                      ),
                      Text(
                        title[i],
                        style: Gfont.fs(16).copyWith(
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
    ));
  }
}
