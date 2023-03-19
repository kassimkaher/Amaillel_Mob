import 'dart:convert';

import 'package:amall/Model/MufatehCatM.dart';
import 'package:amall/Model/MufatehItemM.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;
import 'package:amall/Provider/ManageProvider.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:file/memory.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

class MoreView extends StatefulWidget {
  @override
  _MoreViewState createState() => _MoreViewState();
}

class _MoreViewState extends State<MoreView> {
  bool first = true;
  String title = "خزينة السماء";
  TextEditingController searchController;
  bool loading = true;
  @override
  Widget build(BuildContext context) {
    final info = Provider.of<ManagProvider>(context);
    if (first) {
      first = false;
      searchController = TextEditingController(text: 'Your initial value');
    }

    return new Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          title,
          style: Theme.of(context).textTheme.headline1,
        ),
        actions: [
          loading ? Icon(Icons.local_dining) : SizedBox(),
          InkWell(
              onTap: () async {
                showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return Scaffold(
                          body: TextFormField(
                        controller: searchController,
                        keyboardType: TextInputType.number,
                        maxLines: 200,
                        decoration: InputDecoration(
                            prefixIcon: Padding(
                              padding: EdgeInsets.all(0.0),
                              child: Icon(Icons.person,
                                  size: 40.0, color: Colors.white),
                            ),
                            hintText: "Input your opinion",
                            hintStyle: TextStyle(color: Colors.black),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                    new Radius.circular(25.0))),
                            labelStyle: TextStyle(color: Colors.white)),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 25.0,
                        ),
                      ));
                    });
              },
              child: Text("cat")),
          IconButton(
              onPressed: () async {
                searchController.text = json.encode(item.toJson());
              },
              icon: Icon(EvaIcons.fileText)),
          IconButton(
              onPressed: () async {
                getData();
              },
              icon: Icon(EvaIcons.activity))
        ],
      ),
      body: Stack(children: [
        Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15)),
                color: Theme.of(context).primaryColor),
            padding: EdgeInsets.only(top: 15),
            child: ListView.builder(
                itemCount: catModel != null ? catModel.datac.length : 0,
                itemBuilder: (context, i) {
                  return Card(
                      child: ListTile(
                          onTap: () {
                            showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return Scaffold(
                                    body: SingleChildScrollView(
                                      child: Column(
                                        children: item.datam
                                            .asMap()
                                            .map((ii, e) {
                                              return MapEntry(
                                                  ii,
                                                  Card(
                                                    child: ListTile(
                                                      onTap: () {
                                                        showModalBottomSheet(
                                                            context: context,
                                                            builder: (context) {
                                                              return Scaffold(
                                                                body: SingleChildScrollView(
                                                                    child: Card(
                                                                        child: ListTile(
                                                                  title: Text(
                                                                      e.title),
                                                                  subtitle: Text(
                                                                      e.content),
                                                                ))),
                                                              );
                                                            });
                                                      },
                                                      title: Text(e.title),
                                                      subtitle:
                                                          Text(e.subtitle),
                                                     
                                                    
                                                    ),
                                                  ));
                                            })
                                            .values
                                            .toList(),
                                      ),
                                    ),
                                  );
                                });
                          },
                          title: Text(catModel.datac[i].title),
                          subtitle: Text(catModel.datac[i].url)));
                }))
      ]),
    );
  }

  int page = 10;
  MufatehCatModel catModel;
  getData() async {
    Response data = await http.get(Uri.parse(
        "https://alseraj.net/%d9%86%d9%87%d8%ac-%d8%a7%d9%84%d8%a8%d9%84%d8%a7%d8%ba%d8%a9/"));

    if (data.statusCode == 200) {
  
        var main = parse(data.body).getElementsByClassName("elementor-post");
        catModel = MufatehCatModel(datac: []);
        for (int i = 0; i < main.length; i++) {
          var a = main[i].getElementsByTagName("a");

          var title = a[0].innerHtml;
          var url = a[0].attributes.keys.first == "href"
              ? a[0].attributes.values.first
              : "33";
          // var url=main[i].getElementsByTagName("span")[0].innerHtml;
var id=DateTime.now().millisecondsSinceEpoch;
          Datac d = Datac(
              id: id,
              url: url,
              content: main[i].innerHtml,
              title: title);

           setState(() {
            catModel.datac.add(d);
            // getDataitem(d.id, d.content);
          
        
      });
      await getDatadetails(id,title,url);
        }
    }
  }

  MufatehItemModel item = MufatehItemModel(datam: []);
  getDataitem(int id, String content) async {
    // Response data = await http.get(Uri.parse(
    //     "https://alseraj.net/%d9%85%d9%81%d8%a7%d8%aa%d9%8a%d8%ad-%d8%a7%d9%84%d8%ac%d9%86%d8%a7%d9%86/"));

    if (content != null) {
      setState(() {
        // var q =
        //     parse(content).getElementsByClassName("elementor-post__title");
        var a = parse(content);

        var aTag = a.getElementsByTagName("a");

        for (int i = 0; i < aTag.length; i++) {
          var url = aTag[i].attributes.keys.first == "href"
              ? aTag[i].attributes.values.first
              : "33";
          var title = aTag[i].innerHtml;

          if (title != null) {
            var data = Datam(
                title: removeAllHtmlTags(title),
                catId: id,
                subtitle: url,
                content: "---");

            item.datam.add(data);
            getDatadetails(id,data.title, url);
          } else {
            var data = Datam(
              title: aTag[i].innerHtml,
              catId: id,
            );

            item.datam.add(data);
          }
        }
        setState(() {
          loading = false;
        });
      });
    }
  }

  getDatadetails(id, title, url) async {
    Response data = await http.get(Uri.parse(url));
print(url);
    if (data.statusCode == 200) {
     
        var main = parse(data.body).getElementById("the-post");
     
        var subtitle ="";
        try { 
         subtitle= removeAllHtmlTags( main.getElementsByClassName("entry-sub-title").first.innerHtml);
          
        } catch (e) {
        }
       
    
         var content =removeAllHtmlTags(main.getElementsByClassName("entry-content").first.innerHtml);

     Datam datam= Datam(id: id.toString(),title:title,subtitle: subtitle,content: content.replaceAll("nbsp", " ").replaceAll("&", "") .replaceAll(";", ""));
     item.datam.add(datam);
      
    }
  }

  String removeAllHtmlTags(String htmlText) {
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);

    return htmlText.replaceAll(exp, '');
  }
}
