
import 'package:amall/Provider/NavigatorProv.dart';
import 'package:amall/Views/MainContainer.dart';
import 'package:amall/Widget/Loadinglogo.dart';
import 'package:amall/bussines_logic/SliderBloc/SliderBloc_bloc.dart';
import 'package:amall/bussines_logic/aljenanBloc/AljenanBloc_bloc.dart';
import 'package:amall/bussines_logic/kuranBloc/KuranBloc_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'Builder/themeBuilder.dart';
import 'Provider/ManageProvider.dart';
import 'Provider/ThemeUtils.dart';
import 'bussines_logic/categorybloc/DataBloc_bloc.dart';
import 'Views/home.dart';

Future<void> main() async { 
   WidgetsFlutterBinding.ensureInitialized();
   final appDocumentDir = await getApplicationDocumentsDirectory();

      Hive..init(appDocumentDir.path);
      
  runApp(MyApp());}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp>  {

  @override
  void initState() {
    super.initState();
     SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
  statusBarColor: Colors.black87,
));
  }

  @override
  Widget build(BuildContext context) {
     return  
     MultiProvider(providers: [
     
           ChangeNotifierProvider<ManagProvider>(
          create: (_) => ManagProvider()),
           ChangeNotifierProvider<ThemeUtils>(
          create: (_) => ThemeUtils(themeBuilder(1))),

           ChangeNotifierProvider<NavigateProv>(
          create: (_) => NavigateProv()),
           ChangeNotifierProvider<AnimationProvider>(
          create: (_) => AnimationProvider()),
     ],
  child:  MultiBlocProvider(
      providers: [
        BlocProvider<DataBlocBloc>(
          create: (BuildContext context) => DataBlocBloc(),  ),
          BlocProvider<SliderBlocBloc>(
          create: (BuildContext context) => SliderBlocBloc(),  ),
            BlocProvider<KuranBloc>(
          create: (BuildContext context) => KuranBloc(),  ),
           BlocProvider<AljenanBloc>(
          create: (BuildContext context) => AljenanBloc(),  ),

       ],
      child: MainView())
    );
  }
  
}

class MainView extends StatelessWidget {
  const MainView({
    Key key,
  }) : super(key: key);

  

  @override
  Widget build(BuildContext context) {
     final theme = Provider.of<ThemeUtils>(context);
    return MaterialApp(

          localizationsDelegates: [
   // ... app-specific localization delegate[s] here
   GlobalMaterialLocalizations.delegate,
   GlobalWidgetsLocalizations.delegate,

  GlobalCupertinoLocalizations.delegate,
  DefaultCupertinoLocalizations.delegate

 ],
 supportedLocales: [
      const Locale('en'), // English
      const Locale('ar'), // Hebrew
      // Chinese *See Advanced Locales below*
      // ... other locales the app supports
  ], // Chinese *See Advanced
 locale:  Locale("ar"),
     themeMode: ThemeMode.system,
     theme:  themeBuilder(1),
darkTheme: themeBuilder(0),
        title: 'خير الزاد',
       
        debugShowCheckedModeBanner: false,
        home:  MainContainer()
          
        
    );
  }
}


