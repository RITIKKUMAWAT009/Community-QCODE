
import 'package:flutter/material.dart';

import '../utils/helper/helper_functions.dart';

class FormDivider extends StatelessWidget {
  const FormDivider({
    super.key,
    required this.dividerText
  });
final String dividerText;
  @override
  Widget build(BuildContext context) {
    final bool isDark=HelperFunctions.isDarkMode(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
            child: Divider(
              color: isDark ? Colors.grey.shade900 : Colors.grey,
              thickness: 1,
              indent: 60,
              endIndent: 5,
            )),
         Text(dividerText),
        Flexible(
            child: Divider(
              color: isDark ? Colors.grey.shade900 : Colors.grey,
              thickness: 1,
              indent: 5,
              endIndent: 60,
            )),
      ],
    );
  }
}
