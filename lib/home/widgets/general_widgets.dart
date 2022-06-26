import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StandartHeader extends StatelessWidget {
  const StandartHeader({required this.title, this.icon, Key? key})
      : super(key: key);

  final String title;
  final Icon? icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 17),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$title',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.sp),
          ),
          icon ?? Container(),
        ],
      ),
    );
  }
}

