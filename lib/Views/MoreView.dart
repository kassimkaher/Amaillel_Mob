import 'dart:ui';
import 'package:amall/Model/AmallModel.dart';
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

class MenuViewold extends StatefulWidget {
  _MenuViewold createState() => _MenuViewold();
}

class _MenuViewold extends State<MenuViewold> with TickerProviderStateMixin {
  AnimationController _animationcontroller;
  bool first = true;
  double squareScaleA = 0.0;
  Animation<double> animation;
  String index = "";
   List<String> im=["quran.png","dua.png","prayer.png","kut.png","ts.png"];
    List<String> name=["القرآن","ادعية","الصلوات","الخطب","التسبيحات"];
    List<Color> c=[Colors.cyan,Colors.orange,Colors.indigo,Colors.blueGrey,Colors.pink,Colors.purple];
 
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationcontroller = AnimationController(
        vsync: this,
        lowerBound: 0.0,
        upperBound: 1.0,
        duration: Duration(milliseconds: 500));

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
      first=false;
      _animationcontroller.forward();
    }
    return Scaffold(
     
      body: 
       Center(
         child: Container(
      
          
             
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15)),
                  color: Theme.of(context).cardColor,),
              padding: EdgeInsets.all(100-(squareScaleA*100)),
              child:GridView.builder(itemCount: name.length,
 itemBuilder: (context,i){
   return InkWell

(
    onTap: ()=>showCupertinoModalPopup(
      
      context: context, builder: (c){
    return ClipRRect(
    borderRadius: BorderRadius.circular(20),
      child: MufatehView(name[i]));
  }),
  child: Container( 
  child:   Container(
  padding: EdgeInsets.all(30),
    child:  ListTile(title: Container(
  decoration: BoxDecoration(color: c[i],
  
  borderRadius: BorderRadius.circular(100)),
      padding: const EdgeInsets.all(25.0),
      child: Image.asset("images/${im[i]}",color: Colors.white,),
    ),
      subtitle: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(name[i] ,textAlign: TextAlign.center,style: Theme.of(context).textTheme.subtitle1,),
      ),),
    ),
),);
 },
  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    
      crossAxisCount: MediaQuery.of(context).orientation ==
            Orientation.landscape ? 3: 2,
      crossAxisSpacing: 110-(squareScaleA*100),
      mainAxisSpacing: 110-(squareScaleA*100),
    childAspectRatio: (2 / 2),
    
  ),
 
)
),
       )
        
      
    );
  }

}
