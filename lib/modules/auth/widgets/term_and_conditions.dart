import 'package:flutter/material.dart';
import '../../../core/utils/constants/text_constant.dart';
import '../../../core/utils/helper/helper_functions.dart';

class TermAndConditions extends StatelessWidget {
  const TermAndConditions({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    final isDark=HelperFunctions.isDarkMode(context);
    return Text.rich(TextSpan(children: [
      TextSpan(
          text: '${TextConstant.iAgreeTo} ',
          style: Theme.of(context).textTheme.bodySmall),
      TextSpan(
        text: '${TextConstant.privacyPolicy} ',
        style: Theme.of(context)
            .textTheme
            .bodyMedium!
            .apply(
          color:
          isDark ? Colors.white : Colors.blue,
          decoration: TextDecoration.underline,
          decorationColor:
          isDark ? Colors.white : Colors.blue,
        ),
      ),
      TextSpan(
          text: '${TextConstant.and} ',
          style: Theme.of(context).textTheme.bodySmall),
      TextSpan(
        text: '${TextConstant.termOfUse} ',
        style: Theme.of(context)
            .textTheme
            .bodyMedium!
            .apply(
          color:
          isDark ? Colors.white : Colors.blue,
          decoration: TextDecoration.underline,
          decorationColor:
          isDark ? Colors.white : Colors.blue,
        ),
      ),
    ],),);
  }
}
