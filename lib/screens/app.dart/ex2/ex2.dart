import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:page_transition/page_transition.dart';


class Ex2 extends StatefulWidget {
  // const Ex2({Key? key}) : super(key: key);
  // final String addMemo;
  // Ex2(this.addMemo);



  @override
  _Ex2State createState() => _Ex2State();
}

class _Ex2State extends State<Ex2> {
  List<String> memoList = [];
  List<String> list = ['a', 'b', 'c', 'd'];
  SharedPreferences? prefs;

  Future<void> setInstance() async{
    prefs = await SharedPreferences.getInstance();
    getData();
    setState(() {});
  }

  Future<void> setData() async{
    await prefs!.setStringList('memoList', memoList);
  }

  void getData() {
    memoList = prefs!.getStringList('memoList') ?? [];
  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setData();
    setInstance();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white70,
        centerTitle: true,
        title: Text('My Memos', style: TextStyle(color: Colors.black),),
        actions: <Widget>[
          TextButton(
            child: Icon(Icons.add, size: 30,),
            style: ButtonStyle(
              overlayColor: MaterialStateProperty.all<Color>(Colors.white24),
              foregroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                  if (states.contains(MaterialState.pressed)) {
                    return Colors.white70; //タップ中のテキストカラー
                  }
                  return Colors.blueAccent; //通常時のテキストカラー
                },
              ),
            ),
            onPressed: () async{
              final addMemo = await Navigator.of(context).push(
                MaterialPageRoute(builder: (context) {
                  return AddMemo();
                })
              );
              if(addMemo != null) {
                setState(() {
                  memoList.add(addMemo);
                });
              }
              // setState(() {});
              // Navigator.push(context, MaterialPageRoute(builder: (context) => AddMemo()));
              },

          ),
        ],
      ),
      body: ListView.builder(
        itemCount: memoList.length,
        itemBuilder: (context, index) {
          return Slidable(
            key: const ValueKey(0),
            endActionPane: ActionPane(
              extentRatio: 0.2,
              motion: const DrawerMotion(),
              children: [
                SlidableAction(
                  backgroundColor: Color(0xFFFE4A49),
                  icon: Icons.delete,
                  label: 'Delete',
                  onPressed: (context) {
                    setState(() {
                      memoList.remove(memoList[index]);
                    });
                  },
                ),
              ],
            ),
            child: TextButton(
              child: Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.black, width: 0.5)),
                  ),
                  child: ListTile(
                    title: Text(memoList[index]),
                    tileColor: Colors.white70,
                    trailing: Icon(Icons.arrow_forward_ios),
                  ),
                ),
              ),
              style: ButtonStyle(
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.zero),
                overlayColor: MaterialStateProperty.all<Color>(Colors.white24),
                foregroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                    if (states.contains(MaterialState.pressed)) {
                      return Colors.white24; //タップ中のテキストカラー
                    }
                    return Colors.blueAccent; //通常時のテキストカラー
                  },
                ),
              ),
              onPressed: () async{
                  String result = '';
                  String editMemo = memoList[index];
                  result = await Navigator.push(
                      context,
                      PageTransition(
                        child: EditMemo(editMemo),
                        type: PageTransitionType.rightToLeft,
                      ),
                  );
                      //MaterialPageRoute(builder: (context) => EditMemo(editMemo)));
                  setState(() {
                    memoList[index] = result;
                    setData();
                  });
              },
            ),
          );
        },
      ),
    );
  }
}

class AddMemo extends StatefulWidget {
  //const AddMemo({Key? key}) : super(key: key);

  @override
  _AddMemoState createState() => _AddMemoState();
}

class _AddMemoState extends State<AddMemo> {
  TextEditingController memoController = TextEditingController();
  String addMemo = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white70,
        centerTitle: true,
        title: Text('New Memo', style: TextStyle(color: Colors.black),),
        leadingWidth: 70,
        leading: TextButton(
          child: Text('Cancel', style: TextStyle(fontSize: 16),),
          style: ButtonStyle(
            overlayColor: MaterialStateProperty.all<Color>(Colors.white12),
            foregroundColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                if (states.contains(MaterialState.pressed)) {
                  return Colors.white70; //タップ中のテキストカラー
                }
                return Colors.blueAccent; //通常時のテキストカラー
              },
            ),
          ),
          onPressed: () {
              Navigator.pop(context);
            },
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Save', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
            style: ButtonStyle(
              overlayColor: MaterialStateProperty.all<Color>(Colors.white12),
              foregroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                  if (states.contains(MaterialState.pressed)) {
                    return Colors.white70; //タップ中のテキストカラー
                  }
                  return Colors.blueAccent; //通常時のテキストカラー
                },
              ),
            ),
            onPressed: () {
              setState(() {
                addMemo = memoController.text;
                print(addMemo);
              });
              Navigator.of(context).pop(addMemo);
            },

          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 30),
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(width: 2, color: Colors.white),

            ),
          ),
          height: 30,
          child: TextField(
            controller: memoController,
            decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(width: 0.01),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(width: 0.01),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class EditMemo extends StatefulWidget {
  //const EditMemo({Key? key}) : super(key: key);

  String editMemo;
  EditMemo(this.editMemo);

  @override
  _EditMemoState createState() => _EditMemoState();
}


class _EditMemoState extends State<EditMemo> {
  TextEditingController memoController = TextEditingController();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    memoController.text = widget.editMemo;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white70,
        centerTitle: true,
        title: Text('Edit Memo', style: TextStyle(color: Colors.black),),
        leadingWidth: 70,
        leading: TextButton(
          child: Text('Cancel', style: TextStyle(fontSize: 16),),
          style: ButtonStyle(
            overlayColor: MaterialStateProperty.all<Color>(Colors.white12),
            foregroundColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                if (states.contains(MaterialState.pressed)) {
                  return Colors.white70; //タップ中のテキストカラー
                }
                return Colors.blueAccent; //通常時のテキストカラー
              },
            ),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Save', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
            style: ButtonStyle(
              overlayColor: MaterialStateProperty.all<Color>(Colors.white12),
              foregroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                  if (states.contains(MaterialState.pressed)) {
                    return Colors.white70; //タップ中のテキストカラー
                  }
                  return Colors.blueAccent; //通常時のテキストカラー
                },
              ),
            ),
            onPressed: () {
              setState(() {
                widget.editMemo = memoController.text;
                print(widget.editMemo);
              });
              Navigator.of(context).pop(widget.editMemo);
            },

          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 30),
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(width: 2, color: Colors.white),

            ),
          ),
          height: 30,
          child: TextField(
            controller: memoController,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(width: 0.01),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(width: 0.01),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

