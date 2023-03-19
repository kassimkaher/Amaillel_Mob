import 'package:amall/Model/AmallModel.dart';
import 'package:amall/Provider/ManageProvider.dart';
import 'package:amall/Views/AddSubItem.dart';
import 'package:amall/Widget/AlertDailog.dart';
import 'package:amall/Widget/DropDownField.dart';
import 'package:amall/Widget/TxFild.dart';
import 'package:amall/utlils/data.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';

class AddItem extends StatefulWidget {
  DataAmal dataAmal;
  AddItem({this.dataAmal});
  @override
  _AddItemState createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  final adderqarValidation = GlobalKey<FormState>();

  TextEditingController titleController = TextEditingController();
  String monthController;

  String dayController;
  TextEditingController descController = TextEditingController();
  bool first = true;
  bool inputtype = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final info = Provider.of<ManagProvider>(context);
    if (first) {
      first = false;
      if (widget.dataAmal != null) {
        titleController.text = widget.dataAmal.title;
        monthController = Months[widget.dataAmal.month];
        dayController = Days[widget.dataAmal.day];

        descController.text = widget.dataAmal.desc;
        Provider.of<ManagProvider>(context).dataAmal =
            widget.dataAmal.itemsAmal;
      }
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "اضف عمل",
          style: Theme.of(context).textTheme.headline1,
        ),
      ),
      body: LoadingOverlay(
        isLoading: info.addLoading,
        child: Container(
          child: Form(
            key: adderqarValidation,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: TxFild(
                      null,
                      "العنوان",
                      titleController,
                      true,
                      "text",
                      ["هذا الحقل مطلوب", "الادخال غير صحيح"],
                      bkColor: Theme.of(context).cardColor,
                      border_color: Colors.transparent,
                      radius: 10,
                      readonly: false,
                      lineType: inputtype,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                      ),
                      child: DropField(
                        hint: "تسلسل الشهر الهجري",
                        bkColor: Theme.of(context).cardColor,
                        radius: 10,
                        onChange: (value) {
                          setState(() {
                            monthController = value;
                          });
                        },
                        value: monthController,
                        data: Months,
                      )),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                      ),
                      child: DropField(
                        hint: "اليوم",
                        bkColor: Theme.of(context).cardColor,
                        radius: 10,
                        onChange: (value) {
                          setState(() {
                            dayController = value;
                          });
                        },
                        value: dayController,
                        data: Days,
                      )),

                  // Padding(
                  //   padding: EdgeInsets.symmetric(
                  //     horizontal: 15,
                  //   ),
                  //   child: TxFild(
                  //     null,
                  //     "اليوم",
                  //     dayController,
                  //     true,
                  //     "number",
                  //     ["هذا الحقل مطلوب", "الادخال غير صحيح"],
                  //     bkColor: Theme.of(context).cardColor,
                  //     border_color: Colors.transparent,
                  //     radius: 10,
                  //     readonly: false,
                  //     lineType: inputtype,
                  //   ),
                  // ),
                  SizedBox(
                    height: 15,
                  ),

                  SizedBox(
                    height: 15,
                  ),

                  // end of depth and width and daigonals feild
                  Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 15,
                      ),
                      child: TxFild(
                        null,
                        "وصف",
                        descController,
                        true,
                        "text",
                        ["هذا الحقل مطلوب", "الادخال غير صحيح"],
                        bkColor: Theme.of(context).cardColor,
                        border_color: Colors.transparent,
                        radius: 10,
                        readonly: false,
                        maxline: 5,
                        lineType: inputtype,
                      )),

                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 15,
                    ),
                    child: Visibility(
                      visible: titleController.text.isNotEmpty,
                      child: ListTile(
                        title: Text("اضف فقرة"),
                        trailing: Icon(EvaIcons.plusCircle),
                        onTap: () async {
                          showCupertinoDialog(
                              context: context,
                              builder: (context) {
                                return AddSubItem(titleController.text);
                              });
                        },
                      ),
                    ),
                  ),
                  info.dataAmal != null && info.dataAmal.length > 0
                      ? Column(
                          children: info.dataAmal
                              .asMap()
                              .map((i, e) => MapEntry(
                                  i,
                                  Card(
                                    child: ListTile(
                                      onTap: () {
                                        showCupertinoDialog(
                                            context: context,
                                            builder: (context) {
                                              return AddSubItem(
                                                titleController.text,
                                                dataAmal: e,
                                                index: i,
                                              );
                                            });
                                      },
                                      title: Text(e.name),
                                    ),
                                  )))
                              .values
                              .toList(),
                        )
                      : SizedBox()
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: Container(
        width: MediaQuery.of(context).size.width - 40,
        height: 50,
        child: ElevatedButton(
          onPressed: () {
            FocusScope.of(context).unfocus();
            if (adderqarValidation.currentState.validate()) {
              submitPost(
                  info.dataAmal,
                  titleController.text,
                  descController.text,
                  Months.indexWhere((e) => e == monthController),
                  Days.indexWhere((e) => e == dayController),
                  monthController,
                  info,
                  widget.dataAmal != null);
            }
          },
          child: Text(
            widget.dataAmal != null ? "تعديل" : "حفظ",
            style: Theme.of(context).textTheme.subtitle2,
          ),
        ),
      ),
    );
  }

  submitPost(List<ItemsAmal> dataAmal, String title, String disc, int month,
      int day, String monthName, ManagProvider info, bool isUpdate) async {
    DataAmal itemData = DataAmal(
        id: widget.dataAmal != null
            ? widget.dataAmal.id
            : DateTime.now().millisecondsSinceEpoch.toString(),
        itemsAmal: dataAmal,
        title: title,
        month: month,
        day: day,
        monthName: monthName,
        desc: disc);
    info.addLoading = true;
    info.notifyListeners();
    if (isUpdate) {
      info.updateData(itemData);
    } else {
      info.saveData(itemData);
    }

    FocusScope.of(context).unfocus();

    Navigator.pop(context);
    setState(() {
      adderqarValidation.currentState?.reset();
      titleController.clear();

      descController.clear();

      dataAmal = null;
    });
  }

  // getImage(int index) async {
  //   FocusScope.of(context).unfocus();
  //   // File image = await FilePicker.getFile(type: FileType.image);
  //   FilePickerResult filePickerResult = await FilePicker.platform
  //       .pickFiles(allowMultiple: false, type: FileType.image);

  //   if (filePickerResult.files != null) {
  //     File image = new File(filePickerResult.files[0].path);
  //     List<int> imageBytes = image.readAsBytesSync();

  //     String base64Image = base64Encode(imageBytes);

  //     if (index == -1) {
  //       setState(() {
  //         images.add("data:image/png;base64,$base64Image");
  //         imagesF.add(image);
  //       });
  //     } else {
  //       setState(() {
  //         images[index] = "data:image/png;base64,$base64Image";
  //         imagesF[index] = image;
  //       });
  //     }
  //   }
  // }
}
