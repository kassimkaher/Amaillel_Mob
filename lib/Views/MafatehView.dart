
import 'package:amall/Model/MufatehCatM.dart';
import 'package:amall/Model/MufatehItemM.dart';
import 'package:amall/Widget/Loadinglogo.dart';
import 'package:amall/bussines_logic/aljenanBloc/AljenanBloc_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:md2_tab_indicator/md2_tab_indicator.dart';

class MufatehView extends StatefulWidget {
  
String title;
MufatehView(this.title);
  @override
  _MufatehViewState createState() =>
      _MufatehViewState();
}

class _MufatehViewState extends State<MufatehView>
    with SingleTickerProviderStateMixin {
  String title;
  MufatehCatModel catModel;
  MufatehItemModel data;
  bool isnotData = true;
  String msg = "";
  GlobalKey<RefreshIndicatorState> _ref_Subcat =
      new GlobalKey<RefreshIndicatorState>();
  bool loading = false;
 
  TabController tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   
  }
bool first=true;
int catId=0;
  @override
  Widget build(BuildContext context) {

    if(first){
first=false;
  BlocProvider.of<AljenanBloc>(context).add(GetMufData(catTag: "mufCat.json", dataTag: "muf.json"));
    }
    return BlocConsumer<AljenanBloc,AljenanBlocState>(builder:(context ,s){

    return 
   s is  AljenanBlocLoding?
 Center(
                      child: LoadingLogo(
                          size: MediaQuery.of(context).size.width * 0.3))

   :s is AljenanBlocLoaded?
    
    DefaultTabController(
      length: s.mufatehCatModel.datac.length,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
         title: Text(widget.title),
          bottom: TabBar(
              controller: tabController,
              onTap: (a) {
              
                setState(() {
                  catId=s.mufatehCatModel.datac[a].id;
                });
              },
              labelStyle: Theme.of(context).textTheme.subtitle1,
              indicatorSize: TabBarIndicatorSize.label,
              labelColor: Theme.of(context).textTheme.headline1.color,
              unselectedLabelColor:Theme.of(context).textTheme.bodyText1.color,
              isScrollable: true,
              indicator: MD2Indicator(
                indicatorHeight: 3,
                indicatorColor: Theme.of(context).indicatorColor,
                indicatorSize: MD2IndicatorSize.full,
              ),
              tabs: s.mufatehCatModel.datac .map((e) {
                return Tab(
                  text: e.title,
                );
              }).toList()),
        ),

      
        body:  Container(
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.only(top: 10),
          width: double.infinity,
          child: ListView(
              children: s.mufatehItemModel.datam.where((a) => a.catId==catId)   .map((e) {
            return Container(

                // height: e.id == index
                //     ? MediaQuery.of(context).size.height * 0.4
                //     : MediaQuery.of(context).size.height * 0.07,
                child: Card(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: InkWell(
                          onTap: () {
                            showCupertinoModalPopup(
                                context: context,
                                builder: (context) =>
                                    SafeArea(child: cardAmaal(e, context)));
                            // setState(() {
                            //   index = e.name;
                            // });
                          
                          },
                          child: ListTile(title: Text(
                                  e.title,
                                  style: Theme.of(context).textTheme.subtitle1,
                                ),
                                trailing: Icon(
                                  Icons.arrow_forward_ios,
                                  size: 20,
                                  color: Theme.of(context)
                                                .textTheme
                                                .subtitle1.color,
                                ),
                                )
                          
                          // Padding(
                          //   padding: const EdgeInsets.all(8.0),
                          //   child: Row(
                          //     children: [
                          //       SizedBox(
                          //         width: 10,
                          //       ),
                          //       Text(
                          //         e.title,
                          //         style: Theme.of(context).textTheme.subtitle1,
                          //       ),
                          //       Spacer(),
                          //       Text(
                          //         "ss",
                          //         style: Theme.of(context).textTheme.bodyText1,
                          //       ),
                          //       Icon(
                          //         Icons.arrow_forward_ios,
                          //         size: 20,
                          //         color: Theme.of(context)
                          //                       .textTheme
                          //                       .subtitle1.color,
                          //       ),
                          //     ],
                          //   ),
                          // ),
                        )));
          }).toList()))
      )
    ):SizedBox();
    },
    
    listener: (c,i){
if(i is AljenanBlocLoaded){
  setState(() {
    catId=i.mufatehCatModel.datac[0].id;
  });
}
    },);
  
  
  }
   Card cardAmaal(Datam data, BuildContext context) {
    return 
    
    
   Card(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: SafeArea(
        
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column( children: [
                Container(
                
       
                  child: ListTile(
title:Text(
                        data.title,
                        style: Theme.of(context).textTheme.subtitle1,
                      ) ,
                      trailing:InkWell(
                       onTap: ()=>Navigator.pop(context),
                        child: Icon(
                                                  Icons.close,
                                                  size: 20,
                                                  color: Colors.cyan,
                                                ),
                      ) ,

                  )
                  
                  // Row(
                  //   children: [
                  //     // Container(
                  //     //   alignment: Alignment.topCenter,
                  //     //   width: 5,
                  //     //   height: 30,
                  //     //   color: Colors.cyan,
                  //     // ),
                  //     SizedBox(
                  //       width: 10,
                  //     ),
                  //     Text(
                  //       data.title,
                  //       style: Theme.of(context).textTheme.subtitle1,
                  //     ),Spacer(),
                  //    InkWell(
                  //      onTap: ()=>Navigator.pop(context),
                  //       child: Icon(
                  //                                 Icons.close,
                  //                                 size: 20,
                  //                                 color: Colors.cyan,
                  //                               ),
                  //     ),
                  //   ],
                  // ),
                ),
      
      Divider(),
                     SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(data.content,
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1.copyWith(height: 2)),
                        ),
                      ),
                SizedBox(
                  height: 10,
                )
              ]),
            ),
          ),
        ),
      
    );
  }
}
