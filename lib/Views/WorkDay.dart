import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:amall/Model/AmallModel.dart';
import 'package:amall/Provider/ManageProvider.dart';
import 'package:amall/Widget/AlertDailogDes.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

import 'AddItem.dart';
import '../bussines_logic/categorybloc/DataBloc_bloc.dart';

class DayWork extends StatefulWidget {
  @override
  _DayWorkState createState() => _DayWorkState();
}

class _DayWorkState extends State<DayWork> {
  bool first = true;
  String title = "خزينة السماء";
  @override
  Widget build(BuildContext context) {
    final info = Provider.of<ManagProvider>(context);
    if (first) {
      if (BlocProvider.of<DataBlocBloc>(context).state is DataBlocInitial) {
        BlocProvider.of<DataBlocBloc>(context).add(GetData());

        first = false;
      }
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
          IconButton(
              onPressed: () {
                if (BlocProvider.of<DataBlocBloc>(context).state
                    is DataBlocLoaded) {
                  var d = BlocProvider.of<DataBlocBloc>(context).state
                      as DataBlocLoaded;
                  info.shareFile(d.data.toJson());
                }
              },
              icon: Icon(EvaIcons.share)),
          IconButton(
              onPressed: () async {
                FilePickerResult result = await FilePicker.platform.pickFiles(
                    type: FileType.custom, allowedExtensions: ["json"]);

                if (result != null) {
                  File file = File(result.files.single.path);
                  info.readJson(file);
                } else {
                  // User canceled the picker
                }
              },
              icon: Icon(EvaIcons.fileAdd))
        ],
      ),
      body: Stack(
        children: [
          BlocBuilder<DataBlocBloc, DataBlocState>(
            builder: (context, state) {
              return state is DataBlocLoaded
                  ? Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15)),
                          color: Theme.of(context).scaffoldBackgroundColor),
                      padding: EdgeInsets.only(top: 15),
                      child: ListView.builder(
                          itemCount: state.data.dataAmal.length,
                          itemBuilder: (context, i) {
                            return Column(
                              children: [
                                i == 0
                                    ? ElevatedButton(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text("اضافة عمل"),
                                        ),
                                        onPressed: () async {
                                          info.dataAmal = [];
                                          await Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      AddItem()));

                                          BlocProvider.of<DataBlocBloc>(context)
                                              .add(GetData());
                                        })
                                    : SizedBox(),
                                Card(
                                  child: ListTile(
                                    onTap: () async {
                                      await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => AddItem(
                                                    dataAmal:
                                                        state.data.dataAmal[i],
                                                  )));

                                      BlocProvider.of<DataBlocBloc>(context)
                                          .add(GetData());
                                    },
                                    title: Text(
                                      state.data.dataAmal[i].title,
                                      style:
                                          Theme.of(context).textTheme.subtitle1,
                                    ),
                                    leading: IconButton(
                                        onPressed: () {
                                          TackeDesition().showM(
                                              context: context,
                                              icon: Icon(
                                                EvaIcons.trash,
                                                color: Colors.red,
                                              ),
                                              title: "مسح الفقرة",
                                              msg: "هل انت متاكد",
                                              onAgree: () {
                                                BlocProvider.of<DataBlocBloc>(
                                                        context)
                                                    .add(DeletData(
                                                        id: i,
                                                        ammalModel:
                                                            state.data));
                                              },
                                              onRefuse: () => print("object"));
                                        },
                                        icon: Icon(
                                          EvaIcons.trash,
                                        )),
                                    subtitle: Text(
                                      "عدد الاعمال :  " +
                                          state.data.dataAmal[i].itemsAmal
                                              ?.length
                                              .toString(),
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                    ),
                                    trailing: Column(
                                      children: [
                                        Text(
                                          state.data.dataAmal[i].monthName,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          (state.data.dataAmal[i].month + 1)
                                                  .toString() +
                                              " / " +
                                              (state.data.dataAmal[i].day + 1)
                                                  .toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }),
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
          ),
        ],
      ),
    );
  }
}
