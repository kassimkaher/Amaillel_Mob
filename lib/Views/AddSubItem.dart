import 'package:amall/Model/AmallModel.dart';
import 'package:amall/Provider/ManageProvider.dart';
import 'package:amall/Widget/TxFild.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';

class AddSubItem extends StatefulWidget {
  String title;
  ItemsAmal dataAmal;
  int index;
  AddSubItem(this.title, {this.dataAmal, this.index});
  @override
  _AddSubItemState createState() => _AddSubItemState();
}

class _AddSubItemState extends State<AddSubItem> {
  final adderqarValidation = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController descController = TextEditingController();

  TextEditingController linkController = TextEditingController();
  TextEditingController imageController = TextEditingController();

  bool inputtype = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  bool first = true;
  @override
  Widget build(BuildContext context) {
    final info = Provider.of<ManagProvider>(context);
    if (first) {
      first = false;
      if (widget.dataAmal != null) {
        nameController.text = widget.dataAmal.name;
        descController.text = widget.dataAmal.desc;
        linkController.text = widget.dataAmal.link.toString();
        imageController.text = widget.dataAmal.images[0];
      }
    }
    return Scaffold(
      appBar: AppBar(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        brightness: Brightness.light,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          widget.title,
          style: Theme.of(context).textTheme.headline2,
        ),
        leading: IconButton(
          icon: Icon(
            Icons.cancel,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
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
                    "عنوان العمل",
                    nameController,
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
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 4),
                          child: TxFild(
                            null,
                            "رقم الدعاء او السورة المرتبطة",
                            linkController,
                            true,
                            "",
                            ["هذا الحقل مطلوب", "الادخال غير صحيح"],
                            bkColor: Theme.of(context).cardColor,
                            border_color: Colors.transparent,
                            radius: 10,
                            readonly: false,
                            lineType: inputtype,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(
                  height: 15,
                ),

                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 15,
                  ),
                  child: TxFild(
                    null,
                    "رابط صورة",
                    imageController,
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

                // end of depth and width and daigonals feild
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 15,
                  ),
                  child: TxFild(
                    null,
                    "الوصف",
                    descController,
                    true,
                    "text",
                    ["هذا الحقل مطلوب", "الادخال غير صحيح"],
                    bkColor: Theme.of(context).cardColor,
                    border_color: Colors.transparent,
                    radius: 10,
                    maxline: 4,
                    readonly: false,
                    lineType: inputtype,
                  ),
                ),
              ],
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
                  nameController.text,
                  descController.text,
                  int.tryParse(linkController.text),
                  imageController.text,
                  info);
            }
          },
          child: Text(
            "حفظ",
            style: Theme.of(context).textTheme.subtitle2,
          ),
        ),
      ),
    );
  }

  submitPost(String title, String desc, int link, String image,
      ManagProvider info) async {
    ItemsAmal itemData =
        ItemsAmal(name: title, desc: desc, link: link, images: [image]);

    FocusScope.of(context).unfocus();
    if (info.dataAmal != null && info.dataAmal.length > 0) {
      if (widget.dataAmal != null) {
        info.dataAmal[widget.index] = itemData;
      } else {
        info.dataAmal.add(itemData);
      }
    } else {
      info.dataAmal = [itemData];
    }
    info.notifyListeners();
    Navigator.pop(context, itemData);

    setState(() {
      adderqarValidation.currentState?.reset();
      nameController.clear();
      descController.clear();
      linkController.clear();
      imageController.clear();
    });
  }
}
