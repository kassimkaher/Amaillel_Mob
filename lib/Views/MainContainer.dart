import 'dart:ui';

import 'package:amall/Provider/NavigatorProv.dart';
import 'package:amall/Views/KuranView.dart';
import 'package:amall/Views/MenuView.dart';
import 'package:amall/Views/MoreView.dart';
import 'package:amall/Views/WorkDay.dart';
import 'package:amall/Views/home.dart';
import 'package:amall/Widget/BlureEffect.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';


class MainContainer extends StatefulWidget{
  @override
  _MainContainer createState()=>_MainContainer();

  
} 



class _MainContainer extends State<MainContainer>   {
 
  
  bool first=true;
  @override
  Widget build(BuildContext context) {

     final navigatProv = Provider.of<NavigateProv>(context);
    
     if(first){
        
          first=false;
        
     }
    return Scaffold(
     
      body: Stack(children: [
        
  BlurFilter(sigmaX: 20,sigmaY: 20,
    child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage(
               SchedulerBinding.instance.window.platformBrightness==Brightness.light? "images/bac.jpg":
                "images/bk2.jpg"),
              fit: BoxFit.fill
              )
            ),
          
          ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: double.infinity,
           color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.0),
            
          
          ),
          
        navigatProv.view,
           _buildBottomNavigation(context,navigatProv),
         
        ],
      ),
   
      // floatingActionButton: FloatingActionButton(child: Icon(EvaIcons.tv),
      
      // onPressed: (){
      //     SystemChrome.setPreferredOrientations([
      //     //     DeviceOrientation.portraitUp,
      //     // DeviceOrientation.portraitDown,
           
      //      DeviceOrientation.landscapeRight,
      //      DeviceOrientation.landscapeLeft,
         
      //   ]);
      // },
      // ),

    );
  }

Widget _buildBottomNavigation(BuildContext context ,NavigateProv navigatProv) => Visibility(
  visible: MediaQuery.of(context).viewInsets.bottom==0,
  child:   Align(
            alignment: FractionalOffset.bottomCenter,
            //this is very important, without it the whole screen will be blurred
            child: Container(
                 
decoration: BoxDecoration(
color: Theme.of(context).backgroundColor,
borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10))

),
          child:         BottomNavigationBar(
                            elevation: 0,
                            unselectedItemColor: Colors.black38,
                            selectedItemColor: Theme.of(context).cardColor,
                            showSelectedLabels: false,
                            showUnselectedLabels: false,
                            selectedLabelStyle: Theme.of(context).textTheme.bodyText2,
                             unselectedLabelStyle: Theme.of(context).textTheme.bodyText1,
                             backgroundColor: Colors.transparent,
    
                            // Color(0xffEFF9FA),
    
                            type: BottomNavigationBarType.fixed,
                            items: <BottomNavigationBarItem>[
                              BottomNavigationBarItem(
                                  icon: bottomItem( "الرئيسية","home.png",0),
                                  label: "الرئيسية",
                                  activeIcon: bottomItem( "الرئيسية","home.png",1),),
                                   BottomNavigationBarItem(
                                  icon:  bottomItem( "القرآن","quran.png",0),
                                  label:"القرآن",
                                  activeIcon:  bottomItem( "القرآن","quran.png",1),),
                                  BottomNavigationBarItem(
                                  icon: bottomItem( "الاعمال",'islam.png',0),
                                  label: "الاعمال",
                                  activeIcon: bottomItem( "الاعمال","islam.png",1),),
                             
                          BottomNavigationBarItem(
                                  icon: bottomItem( "المزيد",'more.png',0),
                                  label: "المزيد",
                                  activeIcon: bottomItem( "المزيد","more.png",1),),
                             
                          
                           
                            ],
    
                            currentIndex: navigatProv.selctedIndex,
    
                            selectedFontSize: 0,
                            onTap: (index) {
                              // sc.jumpTo(0);
                              switch (index) {
                                case 0:
                                navigatProv.navigateView(HomePage(), index, "الرئيسية");
                                 
                                  break;
                                 case 2:
                                navigatProv.navigateView(DayWork(), index, "الاعمال اليومية");
                                 
                                  break;

                                case 1:
                                navigatProv.navigateView(KuranView(), index, "القرءان");
                                 
                                  break;
                                    case 3:
                                navigatProv.navigateView(MenuView(), index, "المزيد");
                                 
                                  break;
                                // case 3:
                                //  navigatProv.navigateView(SectionView(), index, dataProv.trans.cat);
                                 
                                 
    
                                //   break;
                                // case 4:
                                //  navigatProv.navigateView(ProfileView(), index, dataProv.trans.profile);
                                 
    
                                //   break;
                              
                                default:
                              }
                            },
                          ),
                    
                  ),
                
  ),
          
        
        
);

Widget bottomItem(title ,icon,isselect) {
  return 
  
  //  Icon(
  //                                   icon,
  //                                   size: 25,
  //                                   color:Theme.of(context).textTheme.bodyText2.color ,
  //                                 ):
  Container(
    height: 50,
    
    child: Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 0,
      color: isselect==0?Colors.transparent:
      Theme.of(context).canvasColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(width: 5,),
     
          Image.asset("images/$icon",
          width: 20,
          height: 20,
color:Theme.of(context).textTheme.subtitle1.color,
          ),
                                  SizedBox(width: 5,),
   isselect==1?      Text(title,style: Theme.of(context).textTheme.subtitle1.copyWith(fontSize: 12),):SizedBox(),
        SizedBox(width: 5,)
     
      ],)));
      
} 

  // Widget buildClipRRect(BuildContext context ,DataProvider dataProv,NavigateProv navigatProv) {
    

  @override
  void deactivate() {
    print("disposeeeeeeeeeeeeeee=========\n\n0039u589372675626");
    super.deactivate();
  }
 
}
