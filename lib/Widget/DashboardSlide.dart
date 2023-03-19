

import 'dart:async';
import 'dart:math';
import 'package:amall/Model/SliderModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
class SliderPop extends StatefulWidget {

  TopModel dashboardM;
  SliderPop(this.dashboardM);
  @override
  _SliderPopState createState() => _SliderPopState(this.dashboardM);
}

class _SliderPopState extends State<SliderPop> {

  TopModel dashboardM;
_SliderPopState(this.dashboardM);
  PageController pageController;

  double viewportFraction = 0.5;
var currentPageValue = 0.0;
  int page = 0;
  int id = 0;
  Timer timer;
  double pageOffset = 0;
 startTimeout() {
    var duration = Duration(seconds: 4);
    timer = new Timer.periodic(duration, (s) {
      setState(() {
        try {
          page++;
          currentPageValue = page.toDouble();
          id = dashboardM.dataSlide[page % widget.dashboardM.dataSlide.length].id;
        } catch (e) {}
      });

      pageController.animateToPage(page,
          duration: Duration(milliseconds: 500), curve: Curves.fastOutSlowIn);
    });

    return timer;
  }






  @override
  void initState() {
    super.initState();
  
   
    pageController = PageController(
      initialPage: 0,viewportFraction: viewportFraction
    )..addListener(() {
        setState(() {
          pageOffset= pageController.page;
          page = pageController.page.toInt();
        });
      });
   // startTimeout();
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: pageController,
      itemBuilder: (context, index) {
        double scale = max(viewportFraction,
            (1 - (pageOffset - index).abs()) + viewportFraction);

        double angle = (pageOffset - index).abs();

        if (angle > 0.5) {
          angle = 1 - angle;
        }
        return SafeArea(
          child: Container(
          
           
            padding: EdgeInsets.only(
              right: 5,
              left: 10,
              top: 25 - scale * 12.5,
               bottom: 25 - scale * 12.5,
            ),
            child: Container(
            
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  
                

       Container(
          decoration: BoxDecoration( 
           
               gradient: LinearGradient(
                 begin: FractionalOffset.topRight,
                 end:FractionalOffset.bottomLeft ,
                 colors: [Colors.black87,Theme.of(context).primaryColor.withOpacity(
                   0.3
                 )]),
             borderRadius: BorderRadius.circular(100)
            
             ),
         child: Icon(Icons.ac_unit_outlined,size: 90,)
       ),
         Card(
           child: Padding(
             padding: const EdgeInsets.all(8.0),
             child: Text(dashboardM.dataSlide[index % widget.dashboardM.dataSlide.length].title
,style:pageOffset==index? Theme.of(context).textTheme.subtitle1.copyWith(fontSize: 18,fontWeight: FontWeight.bold):
pageOffset>index && pageOffset-index<1?Theme.of(context).textTheme.subtitle1.copyWith(fontSize: 18- (pageOffset%1)*10 ,fontWeight: FontWeight.bold):
pageOffset<index && index-pageOffset<=1?Theme.of(context).textTheme.subtitle1.copyWith(fontSize:(8+ (pageOffset%1)*10 ),fontWeight: FontWeight.bold):
Theme.of(context).textTheme.subtitle1.copyWith(fontSize: 20),),
           ),
         )
                ],
              ),)
          ),
        );
      },
    
    );
  }
}
      
     