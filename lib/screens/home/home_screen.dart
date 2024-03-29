import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:buy_mate/constants/color.dart';
import 'package:buy_mate/functions/next_page.dart';
import 'package:buy_mate/screens/home/activity_screen.dart';
import 'package:buy_mate/screens/home/asset_screen.dart';
import 'package:buy_mate/screens/home/notification_screen.dart';
import 'package:buy_mate/screens/home/profile_screen.dart';
import 'package:buy_mate/screens/home/purchase_power_screen.dart';
import 'package:buy_mate/screens/home/share_screen.dart';
import 'package:buy_mate/widgets/card_widget.dart';
import 'package:buy_mate/widgets/text_styles.dart';

class HomeScreen extends StatefulWidget {
  final int bottomIndex;

  const HomeScreen({Key? key, required this.bottomIndex}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

int _bottomNavIndex = 0;

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    _bottomNavIndex = widget.bottomIndex;
    super.initState();
  }

  final List<IconAndText> _iconList = [
    IconAndText(icon: Icons.home_work_outlined, text: 'Assets'),
    IconAndText(icon: Icons.monitor_heart_outlined, text: 'Activity'),
    IconAndText(icon: Icons.account_circle_outlined, text: 'Profile'),
    IconAndText(icon: Icons.home, text: 'Home'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: AnimatedBottomNavigationBar.builder(
        backgroundColor: kBlackColor,
        activeIndex: _bottomNavIndex,
        gapLocation: GapLocation.none,
        leftCornerRadius: 20,
        rightCornerRadius: 20,
        notchSmoothness: NotchSmoothness.smoothEdge,
        onTap: (index) => setState(() => _bottomNavIndex = index),
        tabBuilder: (int index, bool isActive) {
          final color = isActive ? Colors.white : kWhiteColor.withOpacity(0.5);
          return Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                _iconList[index].icon,
                size: 24,
                color: color,
              ),
              const SizedBox(height: 4),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  _iconList[index].text,
                  maxLines: 1,
                  style: TextStyle(color: color),
                ),
              )
            ],
          );
        },
        itemCount: _iconList.length,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: _bottomNavIndex == 3 ? kBlackColor : kWhiteColor,
              child: SafeArea(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 4),
                      child: Container(
                        decoration: BoxDecoration(
                            color: kBlackColor,
                            borderRadius: BorderRadius.circular(4)),
                        height: 42,
                        width: 42,
                        child: IconButton(
                          onPressed: () {
                            setState(() {
                              _bottomNavIndex = 3;
                            });
                          },
                          icon: Icon(
                            _bottomNavIndex == 3
                                ? Icons.menu
                                : Icons.arrow_back_ios,
                            color: kWhiteColor,
                          ),
                        ),
                      ),
                    ),
                    if (_bottomNavIndex != 3)
                      Container(
                        color: kWhiteColor,
                        child: Image.asset('asset/small_logo.png'),
                      ),
                    IconButton(
                      onPressed: () {
                        //TODO
                        if (_bottomNavIndex == 3) {
                          nextPage(
                              context: context, widget: const NotificationScreen());
                        }
                      },
                      icon: Icon(
                        _bottomNavIndex == 3 ? Icons.notifications : Icons.menu,
                        color: _bottomNavIndex == 3 ? kWhiteColor : kBlackColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            IndexedStack(
              index: _bottomNavIndex,
              children: [
                AssetScreen(),
                const ActivityScreen(),
                const ProfilePage(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.36,
                      decoration: const BoxDecoration(
                        color: kBlackColor,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            mediumText(
                                text: 'Welcome back, Troy',
                                color: kWhiteColor,
                                size: 17),
                            const SizedBox(
                              height: 10,
                            ),
                            GestureDetector(
                              onTap: () {
                                nextPage(
                                    context: context,
                                    widget: const PurchasePowerScreen());
                              },
                              child: _totalPurchasingWidget(),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TapIconAndText(
                                  text: 'My Assets',
                                  function: () {
                                    setState(() {
                                      _bottomNavIndex = 0;
                                    });
                                  },
                                  icon: Icons.home_work_outlined,
                                ),
                                TapIconAndText(
                                  text: 'Team Mates',
                                  function: () {
                                    nextPage(
                                        context: context,
                                        widget: const ShareScreen());
                                  },
                                  icon: Icons.people_outlined,
                                ),
                                TapIconAndText(
                                  text: 'Sell in B.M',
                                  function: () {},
                                  icon: Icons.add,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _bottomNavIndex = 1;
                        });
                      },
                      child: CardWidget(
                        color: kWhiteColor,
                        elevation: 2,
                        widget: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: 50,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: regularText(
                                  text: 'Find a property\nto buy with\nmates',
                                  size: 35,
                                  color: kBlackColor),
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        nextPage(
                            context: context, widget: const NotificationScreen());
                      },
                      child: CardWidget(
                        radius: 10,
                        color: kBlackColor,
                        widget: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Icon(
                                    Icons.notifications,
                                    color: kWhiteColor,
                                  ),
                                  regularText(text: 'New Alert', size: 18),
                                  regularText(
                                      text: 'View now',
                                      color: kWhiteColor.withOpacity(0.8))
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              regularText(
                                  color: kWhiteColor.withOpacity(0.8),
                                  text:
                                      'We notices a small change that is out of character of this account.Please review'),
                            ],
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        nextPage(context: context, widget: const ShareScreen());
                      },
                      child: CardWidget(
                        radius: 10,
                        widget: SizedBox(
                          height: 80,
                          child: Center(
                            child: regularText(
                                text: 'Invite your mates',
                                size: 25,
                                textAlign: TextAlign.center,
                                color: kBlackColor),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Container _totalPurchasingWidget() {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: kLightBlack,
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          regularText(
            text: 'Total Purchasing Power',
            color: kWhiteColor.withOpacity(0.8),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              boldText(text: '\$2,250,000'),
              regularText(
                text: 'View Details',
                color: kWhiteColor.withOpacity(0.8),
              ),
            ],
          )
        ],
      ),
    ),
  );
}

class TapIconAndText extends StatelessWidget {
  final Function() function;
  final String text;
  final IconData icon;

  const TapIconAndText(
      {Key? key,
      required this.icon,
      required this.text,
      required this.function})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: kLightBlack,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: kWhiteColor,
                size: 50,
              ),
              const SizedBox(
                height: 10,
              ),
              regularText(
                text: text,
                color: kWhiteColor.withOpacity(0.8),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class IconAndText {
  final IconData icon;
  final String text;

  IconAndText({required this.icon, required this.text});
}

class AlertClass {
  final String id;
  final String text;

  AlertClass({required this.text, required this.id});
}
