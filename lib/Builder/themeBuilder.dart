import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData themeBuilder(int a) {
  double big = 22;
  double mid = 16;
  double sm = 14;
  double vsm = 12;
  final ThemeData base = a == 0
      ? ThemeData.dark()
      : a == 1
          ? ThemeData.light()
          : ThemeData.dark();

  TextTheme _txtTheme(TextTheme base) {
    return base.copyWith(
      headline1: base.headline1.copyWith(
          color: Colors.white,
          fontFamily:'Ku',height: 1.5,
          fontSize: big),
      headline2: base.headline2.copyWith(
          color: Colors.black,
          fontFamily:'Ku',height: 1.5,
          fontSize: big),
      headline3: base.headline3.copyWith(
          color: Colors.black,
          fontFamily: 'Ku',
          fontSize: mid,
          fontWeight: FontWeight.bold),
      headline4: base.headline4.copyWith(
        color: Colors.white,
        fontFamily: 'Ku',
        fontSize: mid,
      ),
//for smal title
      headline5: base.headline5.copyWith(
          color: Colors.black,
          fontFamily:'Ku',height: 1.5,
          fontSize: vsm,
          fontWeight: FontWeight.normal),
      headline6: base.headline3.copyWith(
          color: Colors.white,
          fontFamily:'Ku',height: 1.5,
          fontSize: sm,
          fontWeight: FontWeight.normal),
      subtitle1: base.subtitle1.copyWith(
        color: Colors.black.withOpacity(0.8),
        fontFamily:'Ku',height: 1.5,
        fontSize: mid,
      ),
      subtitle2: base.subtitle2.copyWith(
        color: Colors.black.withOpacity(0.8),
        fontFamily:'Am',height: 2,
        fontSize: mid+4,
      ),
      bodyText1: base.bodyText1.copyWith(
          color: Colors.grey[600],
          fontFamily:'Ku',height: 1.5,
          fontSize: sm,
          fontWeight: FontWeight.normal),
      bodyText2: base.bodyText2.copyWith(
          color: Colors.white70,
          fontFamily:'Ku',height: 1.5,
          fontSize: sm,
          fontWeight: FontWeight.normal),

      button: base.bodyText1.copyWith(
          color: Colors.white,
          fontFamily:'Ku',height: 1.5,
          fontSize: sm,
          fontWeight: FontWeight.normal),
    );
  }

  TextTheme _txtThemeD(TextTheme base) {
    return base.copyWith(
      headline1: base.headline1.copyWith(
          color: Colors.white,
          fontFamily:'Ku',height: 1.5,
          fontSize: big),
      headline2: base.headline2.copyWith(
          color: Colors.white,
          fontFamily:'Ku',height: 1.5,
          fontSize: big),
           headline3: base.headline3.copyWith(
          color: Colors.white,
          fontFamily:'Ku',height: 1.5,
          fontWeight: FontWeight.bold,
          fontSize: big),
          
      subtitle1: base.subtitle1.copyWith(
        color: Colors.white,
        fontFamily:'Ku',height: 1.5,
        fontSize: mid,
      ),
     subtitle2: base.subtitle2.copyWith(
        color: Colors.white70,
        fontFamily:'Am',height: 2,
        fontSize: mid+4,
      ),
      bodyText1: base.bodyText1.copyWith(
        color: Colors.white54,
        fontFamily:'Ku',height: 1.5,
        fontSize: sm,
      ),
      bodyText2: base.bodyText2.copyWith(
          color: Colors.white,
          fontFamily:'Ku',height: 1.5,
          fontSize: sm,
          fontWeight: FontWeight.normal),
      button: base.bodyText1.copyWith(
          color: Colors.white,
          fontFamily:'Ku',height: 1.5,
          fontSize: sm,
         ),
    );
  }

  TextTheme _txtThemec(TextTheme base) {
    return base.copyWith(
      button: base.button.copyWith(
          color: Colors.white,
          fontFamily:'Ku',height: 1.5,
          fontSize: mid,
          fontWeight: FontWeight.normal),
      headline1: base.headline1.copyWith(
          color: Colors.white,
          fontFamily:'Ku',height: 1.5,
          fontSize: big),
      headline2: base.headline2.copyWith(
          color: Colors.black,
          fontFamily:'Ku',height: 1.5,
          fontSize: big),
      subtitle1: base.subtitle1.copyWith(
        color: Colors.black,
        fontFamily:'Ku',height: 1.5,
        fontSize: 16,
      ),
      subtitle2: base.subtitle2.copyWith(
        color: Colors.white,
        fontFamily:'Ku',height: 1.5,
        fontSize: 16,
      ),
      bodyText1: base.bodyText1.copyWith(
          color: Colors.grey[500],
          fontFamily:'Ku',height: 1.5,
          fontSize: sm,
          fontWeight: FontWeight.normal),
      bodyText2: base.bodyText2.copyWith(
          color: Colors.white,
          fontFamily:'Ku',height: 1.5,
          fontSize: sm,
          fontWeight: FontWeight.normal),
    );
  }

  return a == 0
      ? base.copyWith(
          textTheme: _txtThemeD(base.textTheme),
          primaryColor: Color(0xff141414),
          scaffoldBackgroundColor: Color(0xff0A0A0A),
          cardColor: Color(0xff141414),
backgroundColor: Colors.black,
          buttonTheme: ButtonThemeData(
              height: 45,
              padding: EdgeInsets.only(left: 15,right: 15),
              minWidth: big,
              buttonColor: Color(0xffB10404)),
          tabBarTheme: base.tabBarTheme.copyWith(
              labelStyle: TextStyle(
                  color: Colors.white,
                  fontFamily:'Ku',height: 1.5,
                  fontSize: mid),
              unselectedLabelStyle: TextStyle(
                  color: Colors.white70,
                  fontFamily:'Ku',height: 1.5,
                  fontSize: sm)),
                   
          canvasColor: Color(0x5500A8B8),
          accentColor:Color(0xff00A8B8),
          indicatorColor:Color(0xff00A8B8),
          bottomAppBarColor: Colors.black
          
          )
      : a == 1
          ? base.copyWith(
              textTheme: _txtTheme(base.textTheme),
              brightness: Brightness.dark,
              primaryColor: Color(0xff00A8B8),
              
              scaffoldBackgroundColor:Color(0xffffffff),
             appBarTheme: AppBarTheme(elevation: 20,
             centerTitle: true,
            titleTextStyle: TextStyle(color: Colors.white),),
              accentColor:Color(0xff00A8B8),
              // Color(0xffffabig0),
              //bottom bar
              canvasColor: Color(0x4400A8B8),
              iconTheme: IconThemeData(color: Colors.grey, size: big),
              indicatorColor: Colors.grey[800],
              bottomAppBarColor: Colors.black,
              backgroundColor:Colors.white,
              buttonColor:  Color(0xff21C063),
              cardColor: Color(0xffF3F5F7),
              hintColor: Colors.grey,
              buttonTheme: ButtonThemeData(
                height: big,
                padding: EdgeInsets.all(2),
                minWidth: big,
                textTheme: ButtonTextTheme.primary,
              ),
              tabBarTheme: base.tabBarTheme.copyWith()
              //blue dark color
              )
          : base.copyWith(
              textTheme: _txtTheme(base.textTheme),
              primaryColor: Color(0xff2d248a),
              indicatorColor: Colors.white,
              scaffoldBackgroundColor: Color(0xffF2F4F6),
              accentColor: Color(0xffe42c64),
              //bottom bar
              canvasColor: Colors.white,
            
              cardColor: Colors.amber,
              hintColor: Colors.black,
              buttonTheme: ButtonThemeData(
                  height: big,
                  padding: EdgeInsets.all(2),
                  minWidth: big,
                  buttonColor: Color(0xff616ad3),
                  textTheme: ButtonTextTheme.primary),
              tabBarTheme: base.tabBarTheme.copyWith(
                  labelStyle: TextStyle(
                      color: Colors.white,
                      fontFamily:'Ku',height: 1.5,
                      fontSize: mid),
                  unselectedLabelStyle: TextStyle(
                      color: Colors.white70,
                      fontFamily:'Ku',height: 1.5,
                      fontSize: sm))
              //blue dark color
              );
}
