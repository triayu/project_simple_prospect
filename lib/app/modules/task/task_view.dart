import 'package:flutter/material.dart';

class TaskView extends StatelessWidget {
  const TaskView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SizedBox(
        height: 3,
      ),
      Padding(
        padding: const EdgeInsets.all(5),
        child: Container(
          height: 30,
          width: double.infinity,
          decoration: BoxDecoration(color: Color.fromARGB(255, 255, 255, 255), borderRadius: BorderRadius.circular(50)),
          child: TextField(
            cursorHeight: 20,
            autofocus: false,
            decoration: InputDecoration(
              hintText: 'Cari Task',
              prefixIcon: Icon(Icons.search),
            ),
          ),
        ),
      ),
      Container(
        margin: EdgeInsets.all(10),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 100,
          child: ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
              Color.fromARGB(255, 188, 209, 255),
            )),
            onPressed: () {
              // Navigator.push(
              //   context,
              //   // MaterialPageRoute(
              //   //     // builder: (context) => ContactView()),
              //   //     builder: (context) => FormView()),
              // );
            },
            child: Icon(
              Icons.add,
              color: Colors.blue,
            ),
          ),
        ),
      ),
    ]);
  }
}
