import 'package:flutter/material.dart';

class ProfilePage1 extends StatelessWidget {
  const ProfilePage1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Expanded(flex: 1, child: _TopPortion()),
          Expanded(
            flex: 3,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      "Full Name",
                      textScaleFactor: 1.5,
                      style: TextStyle(color: Colors.black),
                    ),
                    const SizedBox(height: 16),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 100,
                          width: 700,
                          child: Text(""),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromARGB(255, 238, 235, 235),
                                  blurRadius: 10,
                                  offset: Offset(0, -5),
                                ),
                              ]),
                        ),
                        SizedBox(
                          height: 32,
                        ),
                        Container(
                          height: 100,
                          width: 700,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromARGB(255, 238, 235, 235),
                                blurRadius: 10,
                                offset: Offset(0, -5),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 32,
                        ),
                        Container(
                          height: 100,
                          width: 700,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromARGB(255, 238, 235, 235),
                                blurRadius: 10,
                                offset: Offset(0, -5),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const _ProfileInfoRow()
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Color.fromARGB(255, 238, 235, 235),
    );
  }
}

class _ProfileInfoRow extends StatelessWidget {
  const _ProfileInfoRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      constraints: const BoxConstraints(maxWidth: 400),
    );
  }

  Widget _singleItem(BuildContext context, ProfileInfoItem item) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              item.value.toString(),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          Text(
            item.title,
            style: Theme.of(context).textTheme.caption,
          )
        ],
      );
}

class ProfileInfoItem {
  final String title;
  final int value;
  const ProfileInfoItem(this.title, this.value);
}

class _TopPortion extends StatelessWidget {
  const _TopPortion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 50),
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Color.fromARGB(255, 238, 235, 235),
                    Colors.white,
                  ]),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50),
              )),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: SizedBox(
            width: 150,
            height: 150,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black,
                    shape: BoxShape.circle,
                    border: Border.all(
                        width: 3, color: Color.fromARGB(255, 211, 211, 211)),
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            'https://pbs.twimg.com/media/EykTF5RXEAAAt0H.jpg:large')),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
