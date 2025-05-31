import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showFavoriteToast(bool isAdded) {
  Fluttertoast.cancel(); // إلغاء أي توست ظاهر لمنع التداخل

  Fluttertoast.showToast(
    msg: isAdded ? "Added to favorites" : "Removed from favorites",
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    backgroundColor:
        isAdded ? Colors.green.withOpacity(0.9) : Colors.red.withOpacity(0.9),
    textColor: Colors.white,
    fontSize: 16.0,
  );
}
