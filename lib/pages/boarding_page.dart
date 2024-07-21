import 'package:flutter/material.dart';
import 'package:shop_app/components/constants.dart';
import 'package:shop_app/components/theme.dart';
import 'package:shop_app/helper/cached_helper.dart';
import 'package:shop_app/pages/login_page.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingItemModel {
  final String title;
  final String body;
  final String image;

  const BoardingItemModel({
    required this.title,
    required this.body,
    required this.image,
  });
}

class BoardingPage extends StatefulWidget {
  const BoardingPage({super.key});
  final List<BoardingItemModel> boardingList = const [
    BoardingItemModel(
      title: 'On Board 1 Title',
      body: 'On Board 1 Body',
      image: 'assets/images/shop1.png',
    ),
    BoardingItemModel(
      title: 'On Board 2 Title',
      body: 'On Board 2 Body',
      image: 'assets/images/shop2.png',
    ),
    BoardingItemModel(
      title: 'On Board 3 Title',
      body: 'On Board 3 Body',
      image: 'assets/images/shop3.png',
    ),
  ];

  @override
  State<BoardingPage> createState() => _BoardingPageState();
}

class _BoardingPageState extends State<BoardingPage> {
  final boardingController = PageController();

  bool isLast = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            TextButton(
              onPressed: () {
                CachedHelper.saveData(key: kOnBoarding, value: true)
                    .then((value) {
                  if (value) {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginPage(),
                      ),
                      (route) => false,
                    );
                  }
                });
              },
              child: const Text('SKIP'),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: boardingController,
                  onPageChanged: (index) {
                    if (index == widget.boardingList.length - 1) {
                      setState(() {
                        isLast = true;
                      });
                    } else {
                      setState(() {
                        isLast = false;
                      });
                    }
                  },
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) => boardingBuildItem(
                    model: widget.boardingList[index],
                  ),
                  itemCount: 3,
                ),
              ),
              const SizedBox(
                height: 60,
              ),
              Row(
                children: [
                  SmoothPageIndicator(
                    controller: boardingController,
                    count: widget.boardingList.length,
                    effect: const ExpandingDotsEffect(
                      dotColor: Colors.grey,
                      dotHeight: 10,
                      dotWidth: 10,
                      activeDotColor: defaultColor,
                      spacing: 5,
                      expansionFactor: 4,
                    ),
                  ),
                  const Spacer(),
                  FloatingActionButton(
                    onPressed: () {
                      if (isLast) {
                        CachedHelper.saveData(key: kOnBoarding, value: true)
                            .then((value) {
                          if (value) {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginPage(),
                              ),
                              (route) => false,
                            );
                          }
                        });
                      } else {
                        boardingController.nextPage(
                          duration: const Duration(
                            milliseconds: 600,
                          ),
                          curve: Curves.fastLinearToSlowEaseIn,
                        );
                      }
                    },
                    child: const Icon(Icons.arrow_forward_ios),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}

Widget boardingBuildItem({
  required BoardingItemModel model,
}) =>
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Image.asset(
            model.image,
            scale: 1,
          ),
        ),
        const SizedBox(
          height: 72,
        ),
        Text(
          model.title,
          style: const TextStyle(
            fontSize: 24,
            fontFamily: 'REM',
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Text(
          model.body,
          style: const TextStyle(
            fontSize: 14,
            fontFamily: 'REM',
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 60,
        ),
      ],
    );
