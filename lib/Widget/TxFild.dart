
import 'package:flutter/material.dart';





class TxFild extends StatefulWidget {
void Function()onClick;
void Function(dynamic value)onChange;
String title;
Icon icon;
String type;
Color border_color;
TextEditingController tcontroller;
List<String>msg;
bool enable;
bool readonly=false;
double radius;
Color bkColor;
bool lineType;
bool isEmail;
int maxline;
  TxFild(this.icon,this.title,this.tcontroller ,this.enable,this.type,this.msg,{this.radius,this.border_color,this.bkColor,this.onClick,this.readonly,this.isEmail,this.maxline,this.lineType=false,this
  .onChange} );

  @override
  State<StatefulWidget> createState() => _TxFildState(title,icon,tcontroller,enable,type,msg,radius: this.radius,
  bordercolor: this.border_color,bkColor: this.bkColor,onClick: this.onClick,readonly: this.readonly,isEmail: this.isEmail,maxline: this.maxline,lineType: this.lineType,
  onChange: this.onChange);
}

class _TxFildState extends State<TxFild>{ 
  String title;
Icon icon;
void Function()onClick;
void Function(dynamic value)onChange;
TextEditingController tcontroller;
bool enable;
bool readonly=false;
bool ispassword=false;
bool isEmail;
String type;
List<String>msg;
double radius;
Color bordercolor;
Color bkColor;
bool lineType;
int maxline;

_TxFildState(this.title,this.icon , this.tcontroller,this.enable,this.type,this.msg,{this.onChange,this.radius,this.bordercolor,this.bkColor,this.onClick,this.readonly,this.isEmail,this.maxline,this.lineType=false});

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    type=="pass"?ispassword=true:false;

   
  }
  @override
  Widget build(BuildContext context) {
    return   TextFormField(
      onTap: onClick,
      onChanged: (a)=>onChange!=null?onChange(a):null,
      readOnly: readonly,
      
      maxLines:maxline!=null?maxline: 1,
      maxLength: type=="verf"?6:null,
                          controller: tcontroller,
                          enabled: enable,
                          textAlign: TextAlign.start,
                          obscureText:ispassword,
                          
      // The validator receives the text that the user has entered.
       
        
        decoration: lineType? InputDecoration(
    
    
     hintText: title,
   
    
   
    prefixText: ' ',
   
    suffixStyle: const TextStyle(color: Colors.green),
    
    
    ):InputDecoration(
           hintStyle:Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 14),
       
        hintText: title,
        fillColor:lineType?null: bkColor!=null?bkColor: Theme.of(context).scaffoldBackgroundColor,

       
              
    
     
     prefixIcon: icon,
        filled: !lineType,
        suffixIcon: type=="pass" || type=="re_pass"?IconButton(icon: Icon(Icons.remove_red_eye),color: icon.color, onPressed: (){
setState(() {
  ispassword=!ispassword;
});
        }):null,
       contentPadding: const EdgeInsets.only(
            left: 10,
            right: 10,
           top: 8,
            bottom: 8,
          ),
          enabledBorder: lineType?InputBorder.none: OutlineInputBorder(
                // width: 0.0 produces a thin "hairline" border
                borderSide:  BorderSide(color:bordercolor!=null?bordercolor:Colors.white, width: 0.5),
                borderRadius: BorderRadius.circular(radius!=null?radius:3)
              ),
        border:  OutlineInputBorder(
          
              borderRadius: BorderRadius.circular(radius!=null?radius:3)
        ),
    ),
        textAlignVertical: TextAlignVertical.center,
        
                  keyboardType:type=="number" || type=="verf" || type=="phone" || type=="price" ?TextInputType.number:type=="pass"|| type=="re_pass"?TextInputType.visiblePassword:
                  type=="email"?TextInputType.emailAddress:
                  TextInputType.text,
      validator: (value) {
        if (value.isEmpty ) {
         
        return msg[0];
        }else   if(!validate(value,type)){
     return msg[1];
                  }
        return null;
      },
    );
    
  }
   bool validate(String value , String  type){
               if (type=="text") {
                  // RegExp exp= new RegExp(r'^(?=.*?[a-z])');
             var a    =value.replaceAll(" ", "");
                 var b =a.replaceAll("\n", "");
                 var c=b.length>2?true:false;

                   bool matches =b=="" || !c ?false: true;

                    return matches;
               }else if (type=="phone") {
                  
                 RegExp exp= RegExp(r'^[0-9]+$');
                   bool matches = exp.hasMatch(value);

                    return value.length>10 && value.length<13 ?matches:false;
               }else if (type=="number") {
                  
                 RegExp exp= RegExp(r'^[0-9]+$');
                   bool matches = exp.hasMatch(value);

                    return matches;
               }
               else if (type=="price") {
                  
                 RegExp exp= RegExp(r'^[0-9]+$');
                   bool matches = exp.hasMatch(value);
int p=0;
try {
 p=  int.parse(value);
} catch (e) {
}
                    return p<999000000000&& p>0? matches:false;
               }
               
               else if (type=="pass"||type=="re_pass") {
                 
        // String  pattern = r'^(?=.*?[a-z])(?=.*?[0-9])';
        // RegExp regExp = new RegExp(pattern);
        // return regExp.hasMatch(value);

        return value.length>7?true:false;
  
             

                   
               }else if(type=="email"){


                     Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);


   return regex.hasMatch(value.replaceAll(" ", ""));


            
               }else if(type=="verf"){

 RegExp exp= RegExp(r'^[0-9]+$');
                   bool matches = exp.hasMatch(value);

                    return value.length==6?matches:false;
               }
               else{
                 return true;
               }
              }
         bool validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return false;
    else
      return true;
  }

             datevailid (String value) {
                          if (value?.isEmpty ?? true) {
                            return 'Please fill filed';
                          }
                        }



                        
          

 
   

    

 
  
}