import 'package:flutter/material.dart';
import 'package:shop_app/components/constants.dart';
import 'package:shop_app/utils/app_theme.dart';
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
      title: 'Shop What You Need Anytime',
      body:
          'Discover a wide variety of products to meet all your needs at competitive prices.',
      image: 'assets/images/shop1.png',
    ),
    BoardingItemModel(
      title: 'Fast & Secure Delivery',
      body:
          'Get your orders delivered to your doorstep in no time with fast delivery services.',
      image: 'assets/images/shop2.png',
    ),
    BoardingItemModel(
      title: 'Exclusive Deals & Special Discounts',
      body:
          'Enjoy special discounts and unbeatable offers on a wide range of products.',
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
  Widget build(BuildContext context2) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            TextButton(
              onPressed: () async {
                await CachedHelper.saveData(key: kOnBoarding, value: true);
                if (mounted) {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginPage(),
                    ),
                    (route) => false,
                  );
                }
              },
              child: const Text(
                'SKIP',
                style: TextStyle(
                  color: defaultColor,
                ),
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
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
                  itemBuilder: (context, index) => boardingBuildItem(
                    context: context,
                    model: widget.boardingList[index],
                  ),
                  itemCount: 3,
                ),
              ),
              _smoothPageIndicatorAndActionButton(),
            ],
          ),
        ));
  }

  Row _smoothPageIndicatorAndActionButton() {
    return Row(
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
          backgroundColor: defaultColor,
          foregroundColor: Colors.white,
          onPressed: () async {
            if (isLast) {
              await CachedHelper.saveData(key: kOnBoarding, value: true);
              if (mounted) {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (_) => LoginPage(),
                  ),
                  (route) => false,
                );
              }
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
    );
  }
}

Widget boardingBuildItem({
  required BoardingItemModel model,
  required BuildContext context,
}) =>
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 3,
          child: Image.asset(
            model.image,
            height: 150,
          ),
        ),
        _titleAndBodyBoadingPage(model, context),
        SizedBox(
          height: 20,
        ),
      ],
    );

SizedBox _titleAndBodyBoadingPage(
    BoardingItemModel model, BuildContext context) {
  return SizedBox(
    height: 150,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            model.title,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Expanded(
          child: Text(
            model.body,
            style: const TextStyle(
              fontSize: 14,
              fontFamily: 'REM',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    ),
  );
}
