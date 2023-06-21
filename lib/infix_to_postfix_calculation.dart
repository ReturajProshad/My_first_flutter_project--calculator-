import 'dart:collection';
import 'dart:math';

class InfixToPostfixNote {
  String infixExpression;
  List<String> postfixExpression = [];

  InfixToPostfixNote(this.infixExpression) {
    postfixExpression = infixToPostfix(infixExpression);
  }

  bool isOperator(String token) {
    return token == '+' ||
        token == '-' ||
        token == '*' ||
        token == '/' ||
        token == '^';
  }

  int precedence(String token) {
    if (token == '+' || token == '-') {
      return 1;
    } else if (token == '*' || token == '/') {
      return 2;
    } else if (token == '^') {
      return 3;
    }
    return 0;
  }

  List<String> infixToPostfix(String infixExpression) {
    List<String> postfix = [];
    List<String> tokens = infixExpression.split(' ');

    Queue<String> operatorStack = Queue<String>();

    for (String token in tokens) {
      if (isOperator(token)) {
        while (operatorStack.isNotEmpty &&
            isOperator(operatorStack.last) &&
            precedence(operatorStack.last) >= precedence(token)) {
          postfix.add(operatorStack.removeLast());
        }
        operatorStack.addLast(token);
      } else if (token == '(') {
        operatorStack.addLast(token);
      } else if (token == ')') {
        while (operatorStack.isNotEmpty && operatorStack.last != '(') {
          postfix.add(operatorStack.removeLast());
        }
        if (operatorStack.isNotEmpty && operatorStack.last == '(') {
          operatorStack.removeLast();
        }
      } else {
        postfix.add(token);
      }
    }

    while (operatorStack.isNotEmpty) {
      postfix.add(operatorStack.removeLast());
    }
    // print("Postfix= $postfix");
    return postfix;
  }

  double calculatePostfix() {
    List<double> stack = [];

    for (String token in postfixExpression) {
      // print("token= $token");
      if (isOperator(token)) {
        double operand2 = stack.removeLast();
        double operand1 = stack.removeLast();
        double result = performOperation(token, operand1, operand2);
        stack.add(result);
      } else if (!token.isEmpty) {
        if (token != "(" || token != ")") {
          double value = double.parse(token);
          stack.add(value);
        }
      }
    }
    if (stack.isEmpty) {
      return 0;
    } else {
      return stack.first;
    }
  }

  double performOperation(String operator, double operand1, double operand2) {
    switch (operator) {
      case '+':
        return operand1 + operand2;
      case '-':
        return operand1 - operand2;
      case '*':
        return operand1 * operand2;
      case '/':
        return operand1 / operand2;
      case '^':
        return pow(operand1, operand2).toDouble();
      default:
        throw Exception('Invalid operator: $operator');
    }
  }
}
