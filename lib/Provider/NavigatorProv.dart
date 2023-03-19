

import 'package:amall/Views/home.dart';
import 'package:flutter/material.dart';


class NavigateProv extends ChangeNotifier{
  int selctedIndex = 0;
  String title = "";
  Widget view=HomePage();
  ini(){
    view=HomePage();
    notifyListeners();
  }
  navigateView(Widget view1,int index1,String title1){
    selctedIndex = index1;
                title = title1;
                view = view1;
                notifyListeners();
  }

  

}