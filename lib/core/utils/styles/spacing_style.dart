
import 'package:flutter/cupertino.dart';

import '../constants/sizes.dart';

class RSpacingStyle{
  static const EdgeInsetsGeometry paddingWithAppBarHeight=EdgeInsets.only(
    top: Sizes.appBarHeight,
    left: Sizes.defaultSpace,
    right: Sizes.defaultSpace,
    bottom: Sizes.defaultSpace,
  );
}