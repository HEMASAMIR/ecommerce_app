import 'package:animated_snack_bar/animated_snack_bar.dart';

showAnimatedSnackDialog(
    {required context,
    required String? message,
    required AnimatedSnackBarType? type}) {
  AnimatedSnackBar.material(message ?? "",
          type: type ?? AnimatedSnackBarType.success,
          mobileSnackBarPosition: MobileSnackBarPosition.bottom,
          desktopSnackBarPosition: DesktopSnackBarPosition.topRight)
      .show(context);
}
