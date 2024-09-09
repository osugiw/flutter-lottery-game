import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TTextTheme{
  static TextTheme lightTextTheme = TextTheme(
    displayMedium: GoogleFonts.poppins(
      color: Colors.black87,
    ),
    titleSmall: GoogleFonts.poppins(
      color: Colors.black54,
      fontSize: 24,
    )
  );

  static TextTheme darkTextTheme = TextTheme(
    displayMedium: GoogleFonts.poppins(
      color: Colors.white70,
    ),
    titleSmall: GoogleFonts.poppins(
      color: Colors.white60,
      fontSize: 24,
    )
  );

  static TextTheme buttonTextTheme = TextTheme(
    titleSmall: GoogleFonts.poppins(
      color: Colors.white70,
      fontSize: 15,
    )
  );
}

// Page Title Style
class PageTitleStyle extends StatelessWidget{
  const PageTitleStyle({super.key, required this.textValue});
  final String textValue;

  @override
  Widget build(BuildContext context) {
    return Text(
      textValue,
      style: GoogleFonts.poppins(
      color: const Color.fromARGB(255, 255, 255, 255),
      fontSize: 50,
      fontWeight: FontWeight.w900
      )
    ); 
  }
}

// Card Text Style for Home Size Box
TextStyle buttonTextOptionStyle = GoogleFonts.poppins(
  color: Colors.white,
  fontSize: 30.0,
  fontWeight: FontWeight.w600
);

// Card Text Style for Participant List
TextStyle participantListStyle = GoogleFonts.poppins(
  color: Colors.white,
  fontSize: 20.0,
);

// Button Text Style for Submit new Data
TextStyle submitButtonTextStyle = GoogleFonts.poppins(
  color: Colors.white,
  fontSize: 20.0,
);

// Table Header Style
TextStyle headerTextStyle = GoogleFonts.poppins(
  color: Colors.white,
  fontSize: 25.0,
  fontWeight: FontWeight.w300
);

// Error Text Style
TextStyle errorTextStyle = GoogleFonts.poppins(
  color: Colors.red,
  fontSize: 25.0,
);

// Card Text Style for Shuffle Button
TextStyle shuffleTextStyle = GoogleFonts.poppins(
  color: Colors.white,
  fontSize: 70.0,
  fontWeight: FontWeight.w600
);


// Empty Data
TextStyle emptyTextStyle = GoogleFonts.poppins(
  color: Colors.red,
  fontSize: 25.0,
);

class TAppTheme{
  TAppTheme._();

  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    textTheme: TTextTheme.lightTextTheme,
     
  );

   static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    textTheme: TTextTheme.darkTextTheme,
  );
}