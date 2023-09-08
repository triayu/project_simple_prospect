import 'package:flutter/material.dart';
class EventView extends StatelessWidget {
  const EventView({super.key});
  

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
              hintText: 'Cari Event',
              prefixIcon: Icon(Icons.search),
            ),
          ),
        ),
      ),
      
      Text(
        "Category",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    ]);
  }
}
