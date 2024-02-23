import 'package:flutter/material.dart';
import 'package:tmdb/shared/themes/colors.dart';

const blackTextStyle = TextStyle(color: blackColor);
const whiteTextStyle = TextStyle(color: whiteColor);
const greyTextStyle = TextStyle(color: greyNeutral30Color);

final labelTextFormStyle = blackTextStyle.copyWith(
  fontSize: 15,
  fontWeight: FontWeight.w600,
);
final fieldTextFormStyle = blackTextStyle.copyWith(
  fontSize: 15,
  fontWeight: FontWeight.w500,
);
const hintTextFormStyle = TextStyle(
  color: hintTextColor,
  fontSize: 15,
  fontWeight: FontWeight.w500,
);
const errorTextFormStyle = TextStyle(
  color: redDanger3Color,
  fontSize: 12,
);

final rowsTitleStyle = blackTextStyle.copyWith(
  fontSize: 24,
  fontWeight: FontWeight.w600,
);
final movieTitleStyle = blackTextStyle.copyWith(
  fontSize: 16,
  fontWeight: FontWeight.w600,
);
const movieDateStyle = TextStyle(
  color: black70Color,
  fontSize: 16,
  fontWeight: FontWeight.w400,
);
