import 'package:flutter/material.dart';
import 'package:lazyui/lazyui.dart';
import 'package:simple_prospect/app/constants/color_constants.dart';

class DialogTaskView extends StatefulWidget {
  final String? title;

  const DialogTaskView({super.key, this.title});

  @override
  _DialogTaskViewState createState() => _DialogTaskViewState();
}

class _DialogTaskViewState extends State<DialogTaskView> {
  String selectedFilter = "Task"; // Filter default saat dialog dibuka

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      insetPadding: Ei.zero,
      backgroundColor: Colors.transparent,
      children: [
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 2.0,
          child: Column(
            children: [
              Container(
                padding: Ei.all(16),
                width: double.infinity,
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(Ti.arrowLeft, color: Colors.black),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    SizedBox(
                      width: 50,
                    ),
                    Text(
                      "Filter",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.0,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedFilter = "Task";
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 3),
                          decoration: BoxDecoration(
                            border: selectedFilter == "Task"
                                ? Border(bottom: BorderSide(color: ColorConstants.primaryColor, width: 2.0))
                                : null,
                          ),
                          child: ListTile(
                            title: Text(
                              "Task",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: selectedFilter == "Task" ? ColorConstants.primaryColor : Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedFilter = "Priority";
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          decoration: BoxDecoration(
                            border: selectedFilter == "Priority"
                                ? Border(bottom: BorderSide(color: ColorConstants.primaryColor, width: 2.0))
                                : null,
                          ),
                          child: ListTile(
                            title: Text(
                              "Priority",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: selectedFilter == "Priority" ? ColorConstants.primaryColor : Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  ),
                ),
                elevation: 0.0,
                child: Container(
                  color: Colors.white,
                  child: Column(
                    children: getFilterOptions(selectedFilter),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  List<Widget> getFilterOptions(String filter) {
    if (filter == "Task") {
      return [
        ListTile(
          title: Text("All", textAlign: TextAlign.center),
          onTap: () {},
        ),
        Divider(),
        ListTile(
          title: Text("Completed", textAlign: TextAlign.center),
          onTap: () {
            // Aksi
          },
        ),
        Divider(),
        ListTile(
          title: Text("Not Completed", textAlign: TextAlign.center),
          onTap: () {
            // Aksi
          },
        ),
        Divider(),
        ListTile(
          title: Text("Due Today", textAlign: TextAlign.center),
          onTap: () {
            // Aksi
          },
        ),
      ];
    } else if (filter == "Priority") {
      return [
        ListTile(
          title: Text("Low", textAlign: TextAlign.center),
          onTap: () {
            // Aksi
          },
        ),
        Divider(),
        ListTile(
          title: Text("Medium", textAlign: TextAlign.center),
          onTap: () {
            // Aksi
          },
        ),
        Divider(),
        ListTile(
          title: Text("High", textAlign: TextAlign.center),
          onTap: () {
            // Aksi
          },
        ),
      ];
    }
    return [];
  }
}
