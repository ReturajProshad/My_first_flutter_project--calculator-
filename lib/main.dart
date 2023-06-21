import 'package:flutter/material.dart';
import 'Appbar.dart';
import 'infix_to_postfix_calculation.dart';

void main() {
  runApp(const Calculator2());
}

class Calculator2 extends StatelessWidget {
  const Calculator2({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'My Calculator',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double ans = 0;
  String labell = "Enter the expression";
  final TextEditingController _textEditingController = TextEditingController();
  String inputed = "";
  String InputedInfix = "";
  int currentInput = 0;
  String saveText = "";
  // ignore: non_constant_identifier_names
  int SaveCurrentInput = 0;
  List<String> pfx = [];
  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppbar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              "answer = $ans",
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: _textEditingController,
              readOnly: true,
              decoration: InputDecoration(
                  labelText: labell, border: OutlineInputBorder()),
              textInputAction: TextInputAction.none,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const SizedBox(
                  width: 12,
                ),
                NumberButtons(context, 1),
                const SizedBox(
                  width: 12,
                ),
                NumberButtons(context, 2),
                const SizedBox(
                  width: 12,
                ),
                NumberButtons(context, 3),
                const SizedBox(
                  width: 12,
                ),
                ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.red),
                    ),
                    onPressed: () {
                      ans = 0;
                      inputed = "";
                      InputedInfix = inputed;
                      labell = "Enter the expression";
                      currentInput = 0;
                      _textEditingController.clear();
                      saveText = "";
                      setState(() {});
                    },
                    child: const Text("Clear"))
              ],
            ),
            Row(
              children: [
                const SizedBox(
                  width: 12,
                ),
                NumberButtons(context, 4),
                const SizedBox(
                  width: 12,
                ),
                NumberButtons(context, 5),
                const SizedBox(
                  width: 12,
                ),
                NumberButtons(context, 6),
                const SizedBox(
                  width: 12,
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Color.fromARGB(255, 52, 14, 12)),
                  ),
                  onPressed: () {
                    if (inputed.isEmpty) {
                      ans = 0;
                      inputed = "";
                      labell = "Enter the expression";
                      currentInput = 0;
                      _textEditingController.clear();

                      setState(() {});
                    } else {
                      if (inputed.endsWith(" ")) {
                        inputed = inputed.substring(0, inputed.length - 3);
                      } else {
                        inputed = inputed.substring(0, inputed.length - 1);
                      }
                      _textEditingController.text = inputed;
                      setState(() {});
                    }
                    InputedInfix = inputed;
                  },
                  child: const Text("C"),
                ),
              ],
            ),
            Row(
              children: [
                const SizedBox(
                  width: 12,
                ),
                NumberButtons(context, 7),
                const SizedBox(
                  width: 12,
                ),
                NumberButtons(context, 8),
                const SizedBox(
                  width: 12,
                ),
                NumberButtons(context, 9),
                const SizedBox(
                  width: 12,
                ),
                ExpressionButton(context, '^'),
              ],
            ),
            Row(
              children: [
                const SizedBox(
                  width: 12,
                ),
                NumberButtons(context, 0),
                const SizedBox(
                  width: 12,
                ),
                ExpressionButton(context, '+'),
                const SizedBox(
                  width: 12,
                ),
                ExpressionButton(context, '-'),
                const SizedBox(
                  width: 12,
                ),
                ExpressionButton(context, '÷'),
              ],
            ),
            Row(
              children: [
                const SizedBox(
                  width: 12,
                ),
                ExpressionButton(context, '('),
                const SizedBox(
                  width: 12,
                ),
                ExpressionButton(context, ')'),
                const SizedBox(
                  width: 12,
                ),
                ExpressionButton(context, 'X'),
                const SizedBox(
                  width: 12,
                ),
                ExpressionButton(context, '='),
              ],
            ),
            const SizedBox(height: 20.8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  "Created By Returaj",
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.teal),
                    ),
                    onPressed: () {
                      InfixToPostfixNote infixToPostfixNote =
                          InfixToPostfixNote(InputedInfix.trim());
                      pfx = infixToPostfixNote.postfixExpression;
                      showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            String pfxString = pfx.join(" ");
                            return Container(
                              height: 200,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                color: Colors.red,
                              )),
                              padding: const EdgeInsets.all(50),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text("The Postfix Expression Is:"),
                                  const SizedBox(
                                    height: 12.0,
                                  ),
                                  Text(
                                    pfxString,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      backgroundColor:
                                          Color.fromARGB(176, 130, 112, 34),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          });
                    },
                    child: const Text("Show Posfix"))
              ],
            )
          ],
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget NumberButtons(BuildContext context, int Number) {
    return ElevatedButton(
        onPressed: () {
          UpdateInputedEx(Number.toString(), "N");
        },
        child: Text("$Number"));
  }

  // ignore: non_constant_identifier_names
  Widget ExpressionButton(BuildContext context, String ex) {
    return ElevatedButton(
        onPressed: () {
          if (ex == '=') {
            InfixToPostfixNote infixToPostfixNote = InfixToPostfixNote(inputed);
            ans = infixToPostfixNote.calculatePostfix();
            InputedInfix = inputed;
            if (_textEditingController.text.isEmpty) {
              labell = "Enter the expression";
            } else {
              labell = _textEditingController.text;
            }
            _textEditingController.clear();
            saveText = "";
            inputed = "";
            currentInput = 0;
            setState(() {});
          } else {
            if (ex == 'X') ex = '*';
            if (ex == '÷') ex = '/';
            UpdateInputedEx(ex, "E");
            currentInput = 0;
          }
        },
        child: Text(ex));
  }

  // ignore: non_constant_identifier_names
  void UpdateInputedEx(String Val, String wt) {
    if (wt == "E") {
      _textEditingController.text += " $Val ";
    } else {
      _textEditingController.text += Val;
    }
    inputed = _textEditingController.text;
    InputedInfix = inputed;
    _textEditingController.text = inputed;

    setState(() {});
  }
}
