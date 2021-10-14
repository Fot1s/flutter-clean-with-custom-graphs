import 'package:flutter/material.dart';
import 'package:lab_coffee/presentation/theme/constants.dart';

class HeaderTitle extends StatelessWidget {
  const HeaderTitle(this.title, {Key? key}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Constants.doublePadding,
      child: Text(
        title,
        style: Theme.of(context).textTheme.headline2,
      ),
    );
  }
}
