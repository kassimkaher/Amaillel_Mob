import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TackeDesition {
  TackeDesition();

  Future<bool> showM(
      {@required String title,
      String agree = "تاكيد",
      String refuse = "لا",
      @required String msg,
      @required Icon icon,
      void Function() onAgree,
      void Function() onRefuse,
      BuildContext context}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).cardColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: icon != null ? icon : SizedBox(),
              ),
              Expanded(
                flex: 10,
                child: ListTile(
                  title: Text(
                    title,
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1
                        .copyWith(fontSize: 18),
                  ),
                  subtitle: Text(
                    msg != null ? msg : "لا توجد ",
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
              )
            ],
          ),
          content: Wrap(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 3,
                    child: Container(
                      height: 30,
                      child: ElevatedButton(
                        child: Text(
                          agree,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              .copyWith(fontSize: 13),
                        ),
                        onPressed: () {
                          onAgree();
                          Navigator.pop(context, true);
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: SizedBox(),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      height: 30,
                      child: ElevatedButton(
                        child: Text(
                          refuse,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              .copyWith(fontSize: 13),
                        ),
                        onPressed: () {
                          onRefuse();
                          Navigator.pop(context, false);
                        },
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
