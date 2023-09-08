import 'package:flutter/material.dart';

class Dashboard_view extends StatelessWidget {
  const Dashboard_view({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Stack(
        children: [
          Container(
            height: 140,
            width: double.infinity,
            color: Colors.white,
          ),
          Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Halo, Selamat datang Yono',
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                        Text(
                          'Good Morning',
                          style: TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 50),
                      alignment: Alignment.topRight,
                      child: Icon(
                        Icons.notifications_active,
                        color: Colors.blue,
                        size: 20,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 10),
                      alignment: Alignment.topRight,
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                          image: DecorationImage(image: AssetImage('poto.jpg')),
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(color: Colors.black, style: BorderStyle.solid, width: 2)),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 3,
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Container(
                  height: 50,
                  width: double.infinity,
                  decoration:
                      BoxDecoration(color: Color.fromARGB(255, 255, 255, 255), borderRadius: BorderRadius.circular(30)),
                  child: TextField(
                    cursorHeight: 20,
                    autofocus: false,
                    decoration: InputDecoration(
                      hintText: 'Search',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 3),
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ),
              ),

              // CarouselSlider(
              //   options: CarouselOptions(),
              //   items: [1, 2, 3, 4, 5].map((i) {
              //     return Builder(
              //       builder: (BuildContext context) {
              //         return Container(
              //             width: MediaQuery.of(context).size.width,
              //             margin: EdgeInsets.symmetric(horizontal: 5),
              //             decoration: BoxDecoration(color: Colors.blue),
              //             child: Image.asset("img/gambar1.png"));
              //       },
              //     );
              //   }).toList(),
              // ),
              Container(
                padding: const EdgeInsets.all(10),
                child: Text(
                  'Data Prospect Terbaru',
                  style: TextStyle(
                      color: const Color.fromARGB(255, 39, 36, 36), fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ),
              // *PENTING*
              SizedBox(
                height: 100,
                child: ListView.separated(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.all(5),
                    itemBuilder: ((context, index) {
                      List<String> tittle = [
                        'Test1 ',
                        'Test2',
                        'Test 3',
                        'Test 4',
                        'Test 5',
                      ];
                      return Row(
                        children: [
                          Container(
                              padding: EdgeInsets.all(30),
                              decoration: BoxDecoration(color: Colors.white, border: Border.all(color: Colors.black)),
                              child: Text(tittle[index])),
                        ],
                      );
                    }),
                    separatorBuilder: (context, index) {
                      return SizedBox(width: 10);
                    },
                    itemCount: 8),
              ),
              // Container(
              //   margin: EdgeInsets.all(5),
              //   child: SizedBox(
              //     width: MediaQuery.of(context).size.width,
              //     child: ElevatedButton(
              //       style: ButtonStyle(
              //           backgroundColor: MaterialStateProperty.all(
              //               Color.fromARGB(255, 0, 0, 0))),
              //       onPressed: () {
              //         Navigator.push(
              //           context,
              //           MaterialPageRoute(
              //               // builder: (context) => ContactView()),
              //               builder: (context) => FormView()),
              //         );
              //       },
              //       child: Text(
              //         "Masuk",
              //         style: TextStyle(fontSize: 15, color: Colors.white),
              //       ),
              //     ),
              //   ),
              // ),
            ],
          )
        ],
      )
    ]);
  }
}
