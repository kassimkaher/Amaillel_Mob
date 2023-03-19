
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class LoadingLogo extends StatefulWidget {
  final double size;
  LoadingLogo({@required this.size = 80});
  @override
  _LoadingLogo createState() => _LoadingLogo();
}

class _LoadingLogo extends State<LoadingLogo> with TickerProviderStateMixin {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  bool first = true;
  AnimationProvider an;
  @override
  Widget build(BuildContext context) {
    an = Provider.of<AnimationProvider>(context);
    if (first) {
      first = false;
      an.ini(this);
    }
    return Card(
      color: Colors.transparent,
      elevation: 10,
      shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(widget.size / 2),),
      child: Container(
        height: widget.size,
        width: widget.size,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(widget.size / 2),
          gradient: LinearGradient(begin: Alignment.topLeft,end: Alignment.bottomRight,
        colors:[Theme.of(context).scaffoldBackgroundColor .withOpacity(an.scalvalue), 
       Theme.of(context).primaryColor .withOpacity(0.2),]
// colors: [Theme.of(context).accentColor,Theme.of(context).accentColor],

          ),
    //       boxShadow: [
    //   BoxShadow(
    //     color: Colors.grey.withOpacity(0.5),
    //     spreadRadius: 3,
    //     blurRadius: 7,
    //     offset: Offset(0, 3), // changes position of shadow
    //   ),
    // ],
        ),
        child: Image.asset("images/logo.png",scale: 3,),
      ),
    );
  }

  @override
  void dispose() {
    an._animationcontroller.dispose();
    super.dispose();
  }
}

class AnimationProvider extends ChangeNotifier {
  AnimationController _animationcontroller;

  Animation<double> animation;
  Animation<double> animation1;
  double scalvalue = 0;

  ini(TickerProviderStateMixin a) {
    _animationcontroller = AnimationController(
        vsync: a,
        lowerBound: 0.0,
        upperBound: 1.0,
        duration: Duration(milliseconds: 700));

    animation = Tween(begin: -500.0, end: 1.0).animate(_animationcontroller);
    animation1 = Tween(begin: 0.1, end: 1.0).animate(_animationcontroller);

    _animationcontroller.addListener(() {
      scalvalue = _animationcontroller.value;
      if (scalvalue == 1) {
        _animationcontroller.animateBack(0);
      } else if (scalvalue == 0) {
        _animationcontroller.forward();
      }
      notifyListeners();
    });
    _animationcontroller.forward();
  }
}
