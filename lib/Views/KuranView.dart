import 'dart:ui';
import 'package:amall/Model/AmallModel.dart';
import 'package:amall/Model/KuranModel.dart';
import 'package:amall/Views/slideshowPager.dart';
import 'package:amall/Widget/BlureEffect.dart';
import 'package:amall/Widget/Loadinglogo.dart';
import 'package:amall/bussines_logic/kuranBloc/KuranBloc_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class KuranView extends StatefulWidget {
  _KuranView createState() => _KuranView();
}

class _KuranView extends State<KuranView> with TickerProviderStateMixin {
  AnimationController _animationcontroller;
  bool first = true;
  double squareScaleA = 0.0;
  Animation<double> animation;
  String index = "";
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
      BlocProvider.of<KuranBloc>(context).add(GetKuranData());

      first = false;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "القرآن الكريم",
          style: Theme.of(context).textTheme.headline2,
        ),
      ),
   
      body: BlocBuilder<KuranBloc, KuranBlocState>(
        builder: (context, state) {
          return state is KuranBlocLoding
              ? Center(
                  child: LoadingLogo(
                      size: MediaQuery.of(context).size.width * 0.3))
              : state is KuranBlocLoaded
                  ? workDay(context, state.data)
                  : state is KuranBlocError
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              state.msg[0],
                              style: Theme.of(context).textTheme.headline1,
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              state.msg[1],
                              style: Theme.of(context).textTheme.subtitle1,
                              textAlign: TextAlign.center,
                            )
                          ],
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              " dataProv.trans.error_ser_title",
                              style: Theme.of(context).textTheme.headline1,
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              " dataProv.trans.error_ser_subtitle",
                              style: Theme.of(context).textTheme.subtitle1,
                              textAlign: TextAlign.center,
                            )
                          ],
                        );
        },
      ),
    );
  }

  Widget workDay(BuildContext context, KuranModel data) {
    return Stack(children: [
      ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BlurFilter(
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25)),
                color:
                    Theme.of(context).scaffoldBackgroundColor.withOpacity(0.6)),
            margin: EdgeInsets.only(top: 10),
            padding: EdgeInsets.only(top: 10),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
          ),
        ),
      ),
      Container(
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.only(top: 10),
          width: double.infinity,
          child: ListView(
              children: data.suar.map((e) {
            return Container(

                // height: e.id == index
                //     ? MediaQuery.of(context).size.height * 0.4
                //     : MediaQuery.of(context).size.height * 0.07,
                child: e.name == index
                    ? Transform.scale(
                        scale: squareScaleA, child: cardAmaal(e, context))
                    : Card(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4)),
                        child: InkWell(
                          onTap: () {
                            showCupertinoModalPopup(
                                context: context,
                                builder: (context) =>
                                    SafeArea(child: cardAmaal(e, context)));
                            // setState(() {
                            //   index = e.name;
                            // });
                            _animationcontroller.forward(from: 0);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "سورة ${e.name}",
                                  style: Theme.of(context).textTheme.subtitle1,
                                ),
                                Spacer(),
                                Text(
                                  "${e.ayat.length - 1} آية",
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  size: 20,
                                  color: Theme.of(context)
                                                .textTheme
                                                .subtitle1.color,
                                ),
                              ],
                            ),
                          ),
                        )));
          }).toList()))
    ]);
  }

  Card cardAmaal(Suar data, BuildContext context) {
    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: SingleChildScrollView(
        child: Column(children: [
          SizedBox(
            height: 10,
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                Text(
                  data.name,
                  style: Theme.of(context).textTheme.headline2,
                ),
                Spacer(),
                Text(
                  "${data.ayat.length - 1} آية",
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                SizedBox(
                  width: 10,
                ),
                InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Icon(
                    Icons.close,
                    size: 20,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
              ],
            ),
          ),
          // Container(
          //   height: 1,
          //   color: Colors.grey,
          //   child: Text(""),
          //   ),
          ListTile(
            tileColor: Theme.of(context).scaffoldBackgroundColor,
            title: Text(
              "بِسْمِ اللَّهِ الرَّحْمَنِ الرَّحِيمِ",
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .subtitle2
                  .copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          data.ayat != null && data.ayat.length > 0
              ? Padding(
                  padding: const EdgeInsets.only(bottom: 0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: data.ayat
                          .asMap()
                          .map((i, e) {
                            return MapEntry(
                                i,
                                e
                                            .replaceAll(data.name, " ")
                                            .replaceAll(" ", "")
                                            .length >
                                        0
                                    ? ListTile(
                                        tileColor: i % 2 == 0
                                            ? Theme.of(context)
                                                .primaryColor
                                                .withOpacity(0.04)
                                            : Theme.of(context)
                                                .scaffoldBackgroundColor,
                                        title: RichText(
                                          textAlign: TextAlign.start,
                                          text: TextSpan(children: [
                                            TextSpan(
                                              text: e
                                                  .replaceAll(data.name, " ")
                                                  .replaceAll("0", ""),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle2
                                                  .copyWith(height: 3),
                                            ),
                                            WidgetSpan(
                                                alignment:
                                                    PlaceholderAlignment.middle,
                                                child: SizedBox(
                                                    width: 30,
                                                    height: 30,
                                                    child: Container(
                                                      alignment: Alignment.center,
                                                      decoration: BoxDecoration(
                                                          image: DecorationImage(
                                                            
                                                              image: AssetImage(
                                                        "images/star.png",
                                                        
                                                        
                                                      ),
                                                       colorFilter: new ColorFilter.mode(Theme.of(context).accentColor, BlendMode.dstIn),
               
                                                     )),
                                                      child: Text(
                                                        arN((i + 1).toString()),
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                          fontFamily: 'Am',
                                                          color: Colors.white,
                                                          fontSize: 11,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    )

                                                    // Stack(children: [
                                                    //   Align(
                                                    //     alignment: Alignment.center,
                                                    //     child: Image.asset("images/star.png",fit: BoxFit.fill,)),
                                                    //   Align(
                                                    //       alignment: Alignment.center,
                                                    //     child: Text(arN((i+1).toString()),
                                                    //   textAlign: TextAlign.center,
                                                    //   style: TextStyle(color: Colors.white,fontSize: 12,fontWeight: FontWeight.bold,),
                                                    //   ),

                                                    //   )

                                                    // ],),
                                                    ))
                                          ]),
                                        ))
                                    : SizedBox());
                          })
                          .values
                          .toList()),
                )
              : SizedBox(),
          SizedBox(
            height: 10,
          )
        ]),
      ),
    );
  }

  String arN(String input) {
    const english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
    const farsi = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];

    for (int i = 0; i < english.length; i++) {
      input = input.replaceAll(english[i], farsi[i]);
    }

    return input;
  }
}
