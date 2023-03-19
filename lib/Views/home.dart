import 'dart:ui';
import 'package:amall/Model/AmallModel.dart';
import 'package:amall/Model/SliderModel.dart';
import 'package:amall/Views/slideshowPager.dart';
import 'package:amall/Widget/BlureEffect.dart';
import 'package:amall/Widget/Loadinglogo.dart';
import 'package:amall/bussines_logic/SliderBloc/SliderBloc_bloc.dart';
import 'package:amall/bussines_logic/categorybloc/DataBloc_bloc.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> with TickerProviderStateMixin {
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
   
  }

  @override
  Widget build(BuildContext context) {
    if (first) {
      BlocProvider.of<SliderBlocBloc>(context).add(GetSlider());
      BlocProvider.of<DataBlocBloc>(context).add(GetData());

      first = false;
    }
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: ListView(
        primary: true,
        children: [
          ListTile(
            leading: Icon(Icons.dark_mode,size: 40,color: Colors.amber,),
            title: Text("موعد صلاة المغرب ",style: Theme.of(context).textTheme.headline1,),
          trailing: Text(" ٠٧:٢٢ م",style: Theme.of(context).textTheme.headline1,),
          subtitle: Text("الخميس ٢٥ ذو الحجة",style: Theme.of(context).textTheme.bodyText1.copyWith(color: Colors.white70),),),
          BlocBuilder<SliderBlocBloc, SliderBlocState>(
            builder: (context, state) {
              return state is SliderBlocLoding
                  ? Center(
                      child: LoadingLogo(
                          size: MediaQuery.of(context).size.width * 0.3))
                  : state is SliderBlocLoaded
                      ? Container(
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height * 0.2,
                          child: Slideshow(
                            topModel: state.data.dataSlide,
                          ))
                      : state is SliderBlocError
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
          workDay(context)
        ],
      ),
    );
  }

  Widget workDay(
    BuildContext context,
  ) {
    return BlocConsumer<DataBlocBloc, DataBlocState>(
      listener: (context,state){
if(state is DataBlocLoaded){
  setState(() {
    index=state.data.dataAmal[0].id;
  });
  _animationcontroller.forward();
}
      },
      
      builder: (context, state) {
        return state is DataBlocLoaded
            ? Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child:  Container(
                   decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25),
                            topRight: Radius.circular(25)),
                    ),
                    margin: EdgeInsets.only(top: 10),
                    padding: EdgeInsets.only(top: 15),
height: MediaQuery.of(context).size.height,
width: MediaQuery.of(context).size.width,

                  ),
                ),
                Container(
                   height:MediaQuery.of(context).size.height,
                    padding: EdgeInsets.only(top: 20,left: 6,right: 6),
                   
                    width: double.infinity,
                    child: Column(
                        //  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                        children: state.data.dataAmal.map((e)
                            // padding: EdgeInsets.only(top: 0, right: 10, left: 10),
                            // itemCount: state.data.dataAmal.length,
                            {
                      return Container(

                          // height: e.id == index
                          //     ? MediaQuery.of(context).size.height * 0.4
                          //     : MediaQuery.of(context).size.height * 0.07,
                          child: e.id == index
                              ? Transform.scale(scale: squareScaleA,
                              child: cardAmaal(e, context))
                              : Card(
                                  elevation: 0,
                                  color: Theme.of(context).cardColor.withOpacity(0.8),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5)),
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        index = e.id;
                                      });
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
                                            e.title,
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle1,
                                          ),
                                          Spacer(),
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
                    }).toList()),
                  ),
              ],
            )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      "لم تظف اعمال بعد",
                      style: Theme.of(context).textTheme.headline2,
                    ),
                  )
                ],
              );
      },
    );
  }

  Card cardAmaal(DataAmal data, BuildContext context) {
    return 
    
    
    
    Card(
      elevation: 0,
        color: Theme.of(context).cardColor.withOpacity(0.8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column( children: [
          Container(
          
     
            child: Row(
              children: [
                // Container(
                //   alignment: Alignment.topCenter,
                //   width: 5,
                //   height: 30,
                //   color: Colors.cyan,
                // ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  data.title,
                  style: Theme.of(context).textTheme.subtitle1,
                ),Spacer(),
                Transform.rotate(angle:1.51,
                  child: Icon(
                                            Icons.arrow_back_ios,
                                            size: 20,
                                            color: Colors.cyan,
                                          ),
                ),
              ],
            ),
          ),
    
    Divider(),
          data.itemsAmal != null && data.itemsAmal.length > 0
              ?  Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: data.itemsAmal.map((e) {
                            return ListTile(
                              title: Row(
                                children: [
                                  Icon(
                                    Icons.circle,
                                    color: Colors.cyan,
                                    size: 10,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(e.name),
                                ],
                              ),
                              subtitle: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(e.desc,
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle1
                                        .copyWith(fontSize: 14)),
                              ),
                            );
                          }).toList()),
                    
                  
                )
              : SingleChildScrollView(
                  child: Text(data.desc,
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1
                          .copyWith(fontSize: 14)),
                ),
          SizedBox(
            height: 10,
          )
        ]),
      ),
    );
  }
}
