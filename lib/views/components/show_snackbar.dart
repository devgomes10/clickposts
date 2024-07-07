import 'package:flutter/material.dart';

import '../theme/theme_colors.dart';

showSnackBar({
  required BuildContext context,
  required String message,
  bool isError = true,
}) {
  SnackBar snackBar = SnackBar(
    content: Text(message),
    backgroundColor:
        (isError) ? ThemeColors.errorColor : ThemeColors.successColor,
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
