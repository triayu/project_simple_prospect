import 'package:flutter/material.dart';

class ContactView extends StatelessWidget {
  const ContactView({super.key});

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
          decoration: BoxDecoration(
              color: Color.fromARGB(255, 255, 255, 255),
              borderRadius: BorderRadius.circular(30)),
          child: TextField(
            cursorHeight: 20,
            autofocus: false,
            decoration: InputDecoration(
              hintText: 'Search by Name, Company ...',
              prefixIcon: Icon(Icons.search),
            ),
          ),
        ),
      ),
      ListView.builder(
        itemCount: 4,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) => Container(
          height: 50,
          width: 100,
          margin: EdgeInsets.all(5),
          child: Text("Nama Kontak $index"),
          color: Color.fromARGB(255, 231, 226, 226),
        ),
      ),

      // Container(
      //   margin: EdgeInsets.all(5),
      //   child: SizedBox(
      //     height: 50,
      //     width: 50,
      //     child: ElevatedButton(
      //       style: ButtonStyle(
      //           backgroundColor: MaterialStateProperty.all(Colors.blue)),
      //       onPressed: () {
      //         Navigator.push(
      //           context,
      //           MaterialPageRoute(builder: (context) => Isicontact_view()),
      //         );
      //       },
      //       child: Icon(
      //         Icons.add,
      //         color: Colors.white,
      //         size: 25,
      //       ),
      //     ),
      //   ),
      // ),
    ]);
  }
}
