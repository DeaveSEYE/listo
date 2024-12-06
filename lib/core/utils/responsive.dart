<<<<<<< HEAD
=======
<<<<<<< HEAD
import 'package:flutter/material.dart';

class Responsive {
  final BuildContext context;
  double width;
  double height;
  double textScaleFactor;

  Responsive(this.context)
      : width = MediaQuery.of(context).size.width,
        height = MediaQuery.of(context).size.height,
        textScaleFactor = MediaQuery.of(context).textScaleFactor;

  double wp(double percentage) => width * (percentage / 100);
  double hp(double percentage) => height * (percentage / 100);
  double fontSize(double ratio) => width * ratio * textScaleFactor;
}
=======
>>>>>>> 67dcd6674c2dc54cbe30ca18b1dd4959dd283566
import 'package:flutter/material.dart';

class Responsive {
  final BuildContext context;
  double width;
  double height;
  double textScaleFactor;

  Responsive(this.context)
      : width = MediaQuery.of(context).size.width,
        height = MediaQuery.of(context).size.height,
        textScaleFactor = MediaQuery.of(context).textScaleFactor;

  double wp(double percentage) => width * (percentage / 100);
  double hp(double percentage) => height * (percentage / 100);
  double fontSize(double ratio) => width * ratio * textScaleFactor;
}
<<<<<<< HEAD
=======
>>>>>>> 21e5289 (initial commit)
>>>>>>> 67dcd6674c2dc54cbe30ca18b1dd4959dd283566
