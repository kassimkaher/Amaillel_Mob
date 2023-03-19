import 'dart:ui';
import 'package:amall/Model/AmallModel.dart';
import 'package:amall/Model/MenuModel.dart';
import 'package:amall/Model/SliderModel.dart';
import 'package:amall/Views/slideshowPager.dart';
import 'package:amall/Widget/BlureEffect.dart';
import 'package:amall/Widget/Loadinglogo.dart';
import 'package:amall/bussines_logic/SliderBloc/SliderBloc_bloc.dart';
import 'package:amall/bussines_logic/categorybloc/DataBloc_bloc.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'MafatehView.dart';

class MenuView extends StatefulWidget {
  _MenuView createState() => _MenuView();
}

class _MenuView extends State<MenuView> with TickerProviderStateMixin {
  AnimationController _animationcontroller;
  bool first = true;
  double squareScaleA = 0.0;
  Animation<double> animation;
  String index = "";

  List<MenuModel>menu;
 

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    menu=[MenuModel(title: "القرآن", subtitle: "إِنَّ هَذَا الْقُرْآَنَ يَهْدِي لِلَّتِي هِيَ أَقْوَمُ وَيُبَشِّرُ الْمُؤْمِنِينَ الَّذِينَ يَعْمَلُونَ الصَّالِحَاتِ أَنَّ لَهُمْ أَجْرًا كَبِيرًا ",im: "quran.png",color:  Colors.cyan),
    
    MenuModel(title: "اعمال", subtitle: "زيارة الحسين (ع) , دعاء كميل بن زياد",im: "islam.png",color:  Colors.orange,),
    MenuModel(title: "ادعية", subtitle: "دعاء كميل بن زياد",im: "dua.png",color: Colors.indigo,),
    MenuModel(title: "الصلوات", subtitle: "صلاة الليل ",im: "prayer.png",color:    Colors.blueGrey,),
    MenuModel(title: "الخطب", subtitle: "خطبة الوداع",im: "kut.png",color:   Colors.pink,),
    MenuModel(title: "التسبيحات", subtitle: "استغفار و تسبيح العفو",im: "ts.png",color: Colors.purple),
    
    ];
    _animationcontroller = AnimationController(
        vsync: this,
        lowerBound: 0.0,
        upperBound: 1.0,
        duration: Duration(milliseconds: 400));

    _animationcontroller.addListener(() {
      setState(() {
        squareScaleA = _animationcontroller.value;
      });
    });
    animation = Tween(begin: -500.0, end: 1.0).animate(_animationcontroller);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _animationcontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (first) {
      first = false;
      _animationcontroller.forward();
    }
    return Scaffold(
      backgroundColor: Colors.transparent,
    appBar: AppBar(
      
      title: Text("القائمة"),),

        body: Center(
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15), topRight: Radius.circular(15)),
         
          ),
          padding: EdgeInsets.all(100 - (squareScaleA * 100)),
          child: ListView.builder(
            itemCount: menu.length,
            itemBuilder: (context, i) {
              return InkWell(
                onTap: () => showCupertinoModalPopup(
                    context: context,
                    builder: (c) {
                      return ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: MufatehView(menu[i].title));
                    }),
                child: Card(
                  elevation: 0,
                
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  child:  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                        leading: Container(
                          decoration: BoxDecoration(
                              color: menu[i].color,
                              borderRadius: BorderRadius.circular(100)),
                          padding: const EdgeInsets.all(15.0),
                          child: Image.asset(
                            "images/${menu[i].im}",
                            color: Colors.white,
                          ),
                        ),
                        title: Text(
                            menu[i].title,
                            textAlign: TextAlign.start,
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                          subtitle: Text(menu[i].subtitle),
                        
                      ),
                  ),
                  ),
                
              );
            },
          )),
    ));
  }
}
