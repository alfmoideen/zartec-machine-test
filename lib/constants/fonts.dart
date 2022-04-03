import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle largeFont(Color color){
  return GoogleFonts.nunito(
    color: color,
    fontSize: 19,
    fontWeight: FontWeight.w600,
  );
}

TextStyle mediumFont(Color color){
  return GoogleFonts.nunito(
    color: color,
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );
}

TextStyle mediumFontWithLine(Color color){
  return GoogleFonts.nunito(
    color: color,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    decoration: TextDecoration.lineThrough,
  );
}

TextStyle smallFont(Color color){
  return GoogleFonts.nunito(
    color: color,
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );
}

TextStyle smallFontW600(Color color){
  return GoogleFonts.nunito(
    color: color,
    fontSize: 14,
    fontWeight: FontWeight.w600,
  );
}

TextStyle verySmallFont(Color color){
  return GoogleFonts.nunito(
    color: color,
    fontSize: 12,
    fontWeight: FontWeight.w500,
  );
}
TextStyle verySmallFontwithLine(Color color){
  return GoogleFonts.nunito(
    color: color,
    fontSize: 12,
    fontWeight: FontWeight.w500,
    decoration: TextDecoration.lineThrough,
  );
}

TextStyle verySmallFontW600(Color color){
  return GoogleFonts.nunito(
    color: color,
    fontSize: 12,
    fontWeight: FontWeight.w600,
  );
}