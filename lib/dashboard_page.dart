// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:good_space/product.dart';
import 'package:good_space/services.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

List<Product> products = [];
int bottomNavBarIndex = 0;

class _DashBoardState extends State<DashBoard> {
  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    products = await Services.getPremiumProducts(context: context);
    await Services.getJobs(context: context);
    setState(() {});
  }

  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    List<String> names = ["Kimaya", "Andrew", "Ajay", "Shakshi", "Anita"];

    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        drawer: const Drawer(
          child: Center(child: Text("this is the sidebar of Good Space")),
        ),
        appBar: AppBar(
          leading: const Image(image: AssetImage("Assets/Images/profile.png")),
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.diamond_outlined,
                  color: Colors.lightBlue,
                )),
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.notifications_none,
                  color: Colors.black,
                )),
            IconButton(
                onPressed: () {
                  scaffoldKey.currentState?.openDrawer();
                },
                icon: const Icon(Icons.format_align_right_outlined))
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: bottomNavBarIndex,
          selectedIconTheme: const IconThemeData(color: Colors.lightBlue),
          unselectedItemColor: Colors.black,
          selectedItemColor: Colors.lightBlue,
          showUnselectedLabels: true,
          showSelectedLabels: true,
          mouseCursor: SystemMouseCursors.click,
          type: BottomNavigationBarType.fixed,
          onTap: (index) {
            setState(() {
              bottomNavBarIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.work,
              ),
              label: "Work",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.handshake_outlined,
              ),
              label: "Recruit",
            ),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.people_outline_outlined,
                ),
                label: "Social"),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.message_outlined,
                ),
                label: "Message"),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.person_outline,
                ),
                label: "Profile"),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const Row(
                  children: [
                    Icon(
                      Icons.diamond_outlined,
                      color: Color.fromARGB(255, 255, 168, 0),
                    ),
                    Text(
                      "Step into the future",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                SizedBox(
                  height: 175,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: products.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Card(
                          color: Colors.white,
                          child: SizedBox(
                            height: 100,
                            width: 140,
                            child: Column(children: [
                              Image(
                                  image: AssetImage(
                                      "Assets/Images/product${(index) % 5 + 1}.png")),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(names[index % 5]),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(products[index].displayName),
                            ]),
                          ),
                        );
                      }),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Center(
                      child: Text(
                    "Jobs for you",
                    style: TextStyle(
                        color: Colors.blue, fontWeight: FontWeight.bold),
                  )),
                ),
                const Divider(color: Colors.blue),
                const TextField(
                  decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.blue,
                      ),
                      hintText: "Search for jobs",
                      border: OutlineInputBorder()),
                ),
                SizedBox(
                  child: ListView.builder(
                      itemCount: products.length,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Card(
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              child: Column(children: [
                                const Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("IOS Developer"),
                                    Icon(Icons.share_outlined)
                                  ],
                                ),
                                const Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("GoodSpace"),
                                    Text("2 days ago")
                                  ],
                                ),
                                const Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(Icons.home_outlined),
                                    Text("Saket, New Delhi"),
                                  ],
                                ),
                                MediaQuery.of(context).size.width < 340
                                    ? Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                                color: Colors.green[100],
                                                border: Border.all(
                                                    color: Colors.green)),
                                            child: const Padding(
                                              padding: EdgeInsets.all(4.0),
                                              child: Row(
                                                children: [
                                                  Icon(Icons
                                                      .currency_rupee_sharp),
                                                  Text("20-25LPA"),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                                color: Colors.blue[100],
                                                border: Border.all(
                                                    color: Colors.blue)),
                                            child: const Padding(
                                              padding: EdgeInsets.all(4.0),
                                              child: Row(
                                                children: [
                                                  Icon(Icons
                                                      .star_border_outlined),
                                                  Text("5-7 years"),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                                color: Colors.lightBlue.shade50,
                                                border: Border.all(
                                                    color: Colors
                                                        .lightBlue.shade200)),
                                            child: const Padding(
                                              padding: EdgeInsets.all(4.0),
                                              child: Row(
                                                children: [
                                                  Icon(Icons
                                                      .work_outline_outlined),
                                                  Text("remote"),
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      )
                                    : Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                                color: Colors.green[100],
                                                border: Border.all(
                                                    color: Colors.green)),
                                            child: const Padding(
                                              padding: EdgeInsets.all(4.0),
                                              child: Row(
                                                children: [
                                                  Icon(Icons
                                                      .currency_rupee_sharp),
                                                  Text("20-25LPA"),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                                color: Colors.blue[100],
                                                border: Border.all(
                                                    color: Colors.blue)),
                                            child: const Padding(
                                              padding: EdgeInsets.all(4.0),
                                              child: Row(
                                                children: [
                                                  Icon(Icons
                                                      .star_border_outlined),
                                                  Text("5-7 years"),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                                color: Colors.lightBlue.shade50,
                                                border: Border.all(
                                                    color: Colors
                                                        .lightBlue.shade200)),
                                            child: const Padding(
                                              padding: EdgeInsets.all(4.0),
                                              child: Row(
                                                children: [
                                                  Icon(Icons
                                                      .work_outline_outlined),
                                                  Text("remote"),
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                MediaQuery.of(context).size.width < 340
                                    ? Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            const Row(
                                              children: [
                                                Image(
                                                    image: AssetImage(
                                                        "Assets/Images/tooliqa.png")),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text("Nikita"),
                                                    Text("Tooliqa Innovations")
                                                  ],
                                                )
                                              ],
                                            ),
                                            ElevatedButton(
                                                onPressed: () {},
                                                child: const Text("Apply")),
                                          ],
                                        ),
                                      )
                                    : Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Row(
                                              children: [
                                                Image(
                                                    image: AssetImage(
                                                        "Assets/Images/tooliqa.png")),
                                                Padding(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text("Nikita"),
                                                      Text(
                                                          "Tooliqa Innovations")
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                            ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        Colors.blue,
                                                    foregroundColor:
                                                        Colors.white,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15.0))),
                                                onPressed: () {},
                                                child: const Text("Apply")),
                                          ],
                                        ),
                                      )
                              ]),
                            ),
                          ),
                        );
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
