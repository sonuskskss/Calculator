import 'package:flutter/material.dart';
import 'package:flutter_application_1/colors.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double firstNum = 0.0;
  double secondNum = 0.0;
  var input = '';
  var output = '';
  var operation = '';

  var hideInput = false;
  var outputsize = 34.0;

  onButtonClick(value) {
    if (value == 'AC') {
      input = '';
      output = '';
    } else if (value == 'DEL') {
      if (input.isNotEmpty) {
        input = input.substring(0, input.length - 1);
      }
    } else if (value == '=') {
      if (input.isNotEmpty) {
        var userInput = input;
        userInput = input.replaceAll('x', '*');

        Parser p = Parser();
        Expression expression = p.parse(userInput);
        ContextModel cm = ContextModel();
        var finalValue = expression.evaluate(EvaluationType.REAL, cm);
        output = finalValue.toString();

        if (output.endsWith(".0")) {
          output = output.substring(0, output.length - 2);
        }

        input = output;
        hideInput = true;
        outputsize = 52;
      }
    } else {
      input = input + value;
      hideInput = false;
      outputsize = 34;
    }
    setState(() {});
  }

  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
        ),
        body: Column(
          children: [
            Expanded(
                child: Container(
              height: 200,
            )),
            //
            //INPUT OUTPUT AREA

            Expanded(
                child: Container(
              decoration: BoxDecoration(
                  color: Colors.white70,
                  borderRadius: BorderRadius.circular(11)),
              width: double.infinity,
              padding: EdgeInsets.all(12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    hideInput ? '' : input,
                    style: TextStyle(
                      fontSize: 50,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: 22,
                  ),
                  Text(
                    output,
                    style: TextStyle(fontSize: outputsize, color: Colors.black),
                  ),
                ],
              ),
            )),
            SizedBox(
              height: 20,
            ),

            //
            //BUTTON AREA
            //
            Row(
              children: [
                button(
                  text: '+/-',
                  buttonBgColor: operatorColor,
                ),
                button(
                  text: 'DEL',
                ),
                button(
                  text: 'AC',
                ),
                button(text: '/ '),
              ],
            ),
            Row(
              children: [
                button(
                  text: '7',
                ),
                button(
                  text: '8',
                ),
                button(
                  text: '9',
                ),
                button(
                  text: 'x',
                ),
              ],
            ),
            Row(
              children: [
                button(
                  text: '4',
                ),
                button(
                  text: '5',
                ),
                button(
                  text: '6',
                ),
                button(
                  text: '+',
                ),
              ],
            ),
            Row(
              children: [
                button(
                  text: '1',
                ),
                button(
                  text: '2',
                ),
                button(
                  text: '3',
                ),
                button(
                  text: '-',
                ),
              ],
            ),
            Row(
              children: [
                button(
                  text: '%',
                ),
                button(
                  text: '0',
                ),
                button(
                  text: '.',
                ),
                button(
                  text: '=',
                ),
              ],
            ),
          ],
        ));
  }

  Widget button({text, tColor = Colors.white, buttonBgColor = buttonColor}) {
    return Expanded(
        child: Container(
      margin: EdgeInsets.all(8),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          padding: EdgeInsets.all(22),
          primary: buttonColor,
        ),
        onPressed: () => onButtonClick(text),
        child: Text(
          text,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
      ),
    ));
  }
}
