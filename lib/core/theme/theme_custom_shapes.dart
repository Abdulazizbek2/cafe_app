part of "themes.dart";

class ThemeCustomShapes extends ThemeExtension<ThemeCustomShapes> {
  const ThemeCustomShapes({
    required this.buttonDecoration, required this.buttonsShadowDecoration, required this.favoriteButtonStyle, this.topRectangleBorder,
    this.bottomRectangleBorder,
    this.circleBorder,
  });

  final OutlinedBorder? topRectangleBorder;
  final OutlinedBorder? circleBorder;
  final OutlinedBorder? bottomRectangleBorder;
  final Decoration buttonDecoration;
  final Decoration buttonsShadowDecoration;
  final ButtonStyle favoriteButtonStyle;

  static const ThemeCustomShapes light = ThemeCustomShapes(
    circleBorder: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(32)),
      side: BorderSide(color: Color.fromRGBO(255, 255, 255, 0.05)),
    ),
    topRectangleBorder: CustomRectangleBorder(
      isTop: true,
      side: BorderSide(color: Color(0xFF343434)),
    ),
    bottomRectangleBorder: CustomRectangleBorder(
      isBottom: true,
      side: BorderSide(color: Color(0xFF343434)),
    ),
    buttonDecoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      gradient: LinearGradient(
        colors: <Color>[Color(0xFF2277F6), Color(0xFF1364DD)],
        stops: <double>[0, 1],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
    ),
    buttonsShadowDecoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      gradient: LinearGradient(
        colors: <Color>[Color(0xFF2277F6), Color(0xFF1364DD)],
        stops: <double>[0, 1],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Color.fromRGBO(255, 255, 255, 0.25),
          offset: Offset(0, 1),
          blurStyle: BlurStyle.inner,
        ),
        BoxShadow(
          color: Color.fromRGBO(0, 0, 0, 0.25),
          offset: Offset(0, -1),
          blurStyle: BlurStyle.inner,
        ),
      ],
    ),
    favoriteButtonStyle: ButtonStyle(
      backgroundColor: MaterialStatePropertyAll(
        Color.fromRGBO(0, 0, 0, 0.4),
      ),
      fixedSize: MaterialStatePropertyAll(
        Size.square(24),
      ),
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      padding: MaterialStatePropertyAll(EdgeInsets.zero),
    ),
  );

  static const ThemeCustomShapes dark = ThemeCustomShapes(
    circleBorder: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(32)),
      side: BorderSide(color: Color.fromRGBO(255, 255, 255, 0.05)),
    ),
    topRectangleBorder: CustomRectangleBorder(
      isTop: true,
      side: BorderSide(color: Color(0xFF343434)),
    ),
    bottomRectangleBorder: CustomRectangleBorder(
      isBottom: true,
      side: BorderSide(color: Color(0xFF343434)),
    ),
    buttonDecoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      gradient: LinearGradient(
        colors: <Color>[Color(0xFF2277F6), Color(0xFF1364DD)],
        stops: <double>[0, 1],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
    ),
    buttonsShadowDecoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      gradient: LinearGradient(
        colors: <Color>[Color(0xFF2277F6), Color(0xFF1364DD)],
        stops: <double>[0, 1],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Color.fromRGBO(255, 255, 255, 0.25),
          offset: Offset(0, 1),
          blurStyle: BlurStyle.inner,
        ),
        BoxShadow(
          color: Color.fromRGBO(0, 0, 0, 0.25),
          offset: Offset(0, -1),
          blurStyle: BlurStyle.inner,
        ),
      ],
    ),
    favoriteButtonStyle: ButtonStyle(
      backgroundColor: MaterialStatePropertyAll(
        Color.fromRGBO(0, 0, 0, 0.4),
      ),
      fixedSize: MaterialStatePropertyAll(
        Size.square(24),
      ),
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      padding: MaterialStatePropertyAll(EdgeInsets.zero),
    ),
  );

  @override
  ThemeExtension<ThemeCustomShapes> copyWith({
    CustomRectangleBorder? topRectangleBorder,
    CustomRectangleBorder? bottomRectangleBorder,
    Decoration? buttonDecoration,
    Decoration? buttonsShadowDecoration,
    ButtonStyle? favoriteButtonStyle,
  }) =>
      ThemeCustomShapes(
        topRectangleBorder: topRectangleBorder ?? this.topRectangleBorder,
        bottomRectangleBorder:
            bottomRectangleBorder ?? this.bottomRectangleBorder,
        buttonDecoration: buttonDecoration ?? this.buttonDecoration,
        buttonsShadowDecoration:
            buttonsShadowDecoration ?? this.buttonsShadowDecoration,
        favoriteButtonStyle: favoriteButtonStyle ?? this.favoriteButtonStyle,
      );

  @override
  ThemeExtension<ThemeCustomShapes> lerp(
    ThemeExtension<ThemeCustomShapes>? other,
    double t,
  ) {
    if (other is! ThemeCustomShapes) {
      return this;
    }
    return ThemeCustomShapes(
      circleBorder: OutlinedBorder.lerp(other.circleBorder, circleBorder, t),
      favoriteButtonStyle: ButtonStyle.lerp(
        other.favoriteButtonStyle,
        favoriteButtonStyle,
        t,
      )!,
      topRectangleBorder: OutlinedBorder.lerp(
        other.topRectangleBorder,
        topRectangleBorder,
        t,
      ),
      bottomRectangleBorder: OutlinedBorder.lerp(
        other.bottomRectangleBorder,
        bottomRectangleBorder,
        t,
      ),
      buttonDecoration: Decoration.lerp(
        other.buttonDecoration,
        buttonDecoration,
        t,
      )!,
      buttonsShadowDecoration: Decoration.lerp(
        other.buttonsShadowDecoration,
        buttonsShadowDecoration,
        t,
      )!,
    );
  }
}
