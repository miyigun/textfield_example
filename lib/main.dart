import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TextField Örneği',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: const MyHomePage(title: 'TextField Örneği'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  String girilenMetin="";
  int maxLine=1;
  late FocusNode _focusEdit ;
  late var messageController=TextEditingController();

  @override
  void initState() {
    super.initState();

    _focusEdit=FocusNode();

    _focusEdit.addListener((){
      setState(() {
        if(_focusEdit.hasFocus){
          maxLine = 2;
        }else{
          maxLine =1;
        }
      });
    });
  }

  @override
  void dispose() {
    _focusEdit.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body:
        ListView(
          children: <Widget>[

            const Divider(
              color: Colors.black,
            ),

            const SizedBox(height: 10.0,),

            Padding(
              padding: const EdgeInsets.only(left:50, right: 50, bottom: 20),
              child: TextField(
                decoration: InputDecoration(
                    border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    prefixIcon: const Icon(Icons.text_fields),
                    hintText: "Mesajınızı yazın",
                    filled: true,
                    fillColor: Colors.lightBlueAccent[100]
                ),
              ),
            ),

            const Divider(
              color: Colors.black,
            ),

            const SizedBox(height: 10.0,),

            Padding(
              padding: const EdgeInsets.only(left:50, right: 50, bottom: 20),
              child: TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  prefixIcon: Icon(Icons.arrow_right, size: 40),
                  hintText: "Mesajınızı yazın",
                ),

                onSubmitted: (String anlikVeri){
                  debugPrint("On Submit : $anlikVeri");
                  girilenMetin = anlikVeri;
                },
              ),
            ),

            const Divider(
              color: Colors.black,
            ),

            const SizedBox(height: 10.0,),

            Padding(
              padding: const EdgeInsets.only(left:50, right: 50, bottom: 20),
              child: TextField(
                controller: messageController,
                textInputAction: TextInputAction.done,
                focusNode: _focusEdit,
                maxLines: maxLine,
                autofocus: false,

                decoration: InputDecoration(
                  border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  hintText: "Mesajınızı yazın",
                  suffixIcon: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: (){
                        setState(() {
                          messageController.clear();
                        });
                      },
                  )
                ),
              ),
            ),

            const Divider(
              color: Colors.black,
            ),

          ],
        ),

      floatingActionButton: FloatingActionButton(
        onPressed: (){
          FocusScope.of(context).requestFocus(_focusEdit);
        },

          mini: true,
          backgroundColor: Colors.lightBlueAccent,

        tooltip: "En Son TextField'a Odaklan",

        child: const Icon(Icons.edit),

      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
