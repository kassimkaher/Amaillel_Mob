import 'dart:async';
import 'dart:math';

import 'package:amall/Model/SliderModel.dart';
import 'package:amall/Widget/BlureEffect.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class Slideshow extends StatefulWidget {
  List<DataSlide> topModel;
  Slideshow({@required this.topModel});
  @override
  _SlideshowState createState() => _SlideshowState();
}

class _SlideshowState extends State<Slideshow> {
  PageController pageController = new PageController();
  var currentPageValue = 0.0;
  int page = 0;
  int id = 0;
  Timer timer;

  startTimeout() {
    var duration = Duration(seconds: 5);
    timer = new Timer.periodic(duration, (s) {
      setState(() {
        try {
          page++;
          currentPageValue = page.toDouble();
          id = widget.topModel[page % widget.topModel.length].id;
        } catch (e) {}
      });

      pageController.animateToPage(page,
          duration: Duration(milliseconds: 500), curve: Curves.fastOutSlowIn);
    });

    return timer;
  }

  bool loading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    pageController = PageController(
      initialPage: 0,
    )..addListener(() {
        setState(() {
          page = pageController.page.toInt();
        });
      });
    startTimeout();
  }

  @override
  void dispose() {
    timer != null ? timer.cancel() : null;
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void deactivate() {
    timer != null ? timer.cancel() : null;
    super.deactivate();
  }

  bool first = true;

  double pageOffset = 0;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return PageView.builder(
      controller: pageController,
      itemBuilder: (context, index) {
        // double scale = max(viewportFraction,
        //     (1 - (pageOffset - index).abs()) + viewportFraction);

        // double angle = (pageOffset - index).abs();

        // if (angle > 0.5) {
        //   angle = 1 - angle;
        // }
        return SafeArea(
          child: Container(

          
              margin: EdgeInsets.all(8),
          
            
                 decoration: BoxDecoration(color: Theme.of(context).scaffoldBackgroundColor,
                 borderRadius: BorderRadius.circular(15)
                 ),
                  
                    child: Stack(
                      children: [
                        //   Container(
                        //    width: MediaQuery.of(context).size.width,
                        
                        //           child: ClipRRect(
                        //             borderRadius: BorderRadius.circular(15),
                        //             child: Opacity(
                        //               opacity: 0.8,
                        //               child: Image.asset("images/a.jpeg",fit: BoxFit.fill,)))
                              
                        
                        // ),
                      

                            Align(child: 
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                              widget
                                    .topModel[index % widget.topModel.length].title,
                                    maxLines: 4,
                              style: Theme.of(context).textTheme.subtitle1.copyWith(wordSpacing: 2,
                              ),
                              textAlign: TextAlign.center,
                          ),
                            ),),
                            Align(alignment: Alignment.bottomLeft,
                              child: ListTile(
                                trailing: Icon(Icons.arrow_forward_ios,size: 12,),
                                title: Text("المزيد",style: Theme.of(context).textTheme.bodyText2,),),
                            )
                      ],
                    ),
                    
                  
              )
        );
      },
    );
    // :Center(child: SpinKitCircle(color: Theme.of(context).accentColor,),);
  }
}
