import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';
import 'package:two_tabs/home/screens_bloc/screens_event.dart';

import '../screens_bloc/screens_bloc.dart';
import '../screens_bloc/screens_view.dart';

double iconSize = 25;
Color colors = Colors.black38;
var colorSelected = Color.fromARGB(255, 100, 56, 12);
var color = Color.fromARGB(255, 174, 174, 178);

class NotAuthNavBar extends StatelessWidget {
  const NotAuthNavBar(this.blocScreen, {Key? key}) : super(key: key);

  final ScreenBloc blocScreen;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      builder: (BuildContext context, int value, Widget? child) {
        // This builder will only get called when the _counter
        // is updated.

        return StylishBottomBar(
          iconStyle: IconStyle.simple,
          hasNotch: true,
          opacity: 1,
          currentIndex: currentIndexNavBar.value,
          onTap: (index) {
            currentIndexNavBar.value = index ?? 0;
            if (index == 1) {
              blocScreen.add(TodoScreenEvent());
            } else {
              blocScreen.add(UsersScreenEvent());
            }
          },
          items: barList(),
        );
      },
      valueListenable: currentIndexNavBar,
    );
  }

  List barList() {
    return [
      barItems('Users', 'img/book-open.svg'),
      barItems('To-do', ('img/credit-card.svg')),
    ];
  }

  AnimatedBarItems barItems(String title, svgImage) {
    return AnimatedBarItems(
        icon: Column(
          children: [
            SvgPicture.asset(
              '$svgImage',
              width: iconSize,
              color: color,
            ),
            Text(
              '$title',
              style: TextStyle(color: color),
            )
          ],
        ),
        selectedIcon: Column(
          children: [
            SvgPicture.asset(
              '$svgImage',
              width: iconSize,
              color: colorSelected,
            ),
            Text(
              '$title',
              style: TextStyle(color: colorSelected),
            )
          ],
        ),
        title: Container());
  }
}
