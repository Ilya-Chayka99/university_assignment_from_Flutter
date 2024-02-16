import 'dart:math';

import 'package:flutter/material.dart';

class TaskCalculate extends StatefulWidget {
  const TaskCalculate({super.key});

  @override
  State<TaskCalculate> createState() => _TaskCalculateState();
}

class _TaskCalculateState extends State<TaskCalculate> {
  String result = '0';
  String beforeResult = '';
  String currentOperation = '';
  void _addNumeric(int k){
    setState(() {
      if( k!=0 || result != '0') {
        if(k!=0 && result == '0'){
          result = '$k';
        }else {
          result+=k.toString();
        }
      }
    });
  }
  void _checkActions(){
     switch(currentOperation){
      case '+':
        double tmp = double.parse(beforeResult);
        tmp += double.parse(result.replaceAll(',', '.'));
        beforeResult = tmp.toString();
        break;
      case '-':
        double tmp = double.parse(beforeResult);
        tmp -= double.parse(result.replaceAll(',', '.'));
        beforeResult = tmp.toString();
        break;
      case '/':
        double tmp = double.parse(beforeResult);
        double tpm = double.parse(result.replaceAll(',', '.'));
        if(tpm == 0) break;
        tmp /= tpm;
        beforeResult = tmp.toString();
        break;
      case '*':
        double tmp = double.parse(beforeResult);
        tmp *= double.parse(result.replaceAll(',', '.'));
        beforeResult = tmp.toString();
        break;
    }
    setState(() {});
  }
  void _actionN(String d){
    bool flag = false;
    if(beforeResult == '') {
      beforeResult = result.replaceAll(',', '.');
      flag = true;
    }
    switch(d){
      case '+':
        if(!flag){
          if(currentOperation != d) {
            _checkActions();
          } else{
            double tmp = double.parse(beforeResult);
            tmp += double.parse(result.replaceAll(',', '.'));
            beforeResult = tmp.toString();
          }
        }
        result = '0';
        currentOperation = '+';
        break;
      case '-':
        if(!flag){
          if(currentOperation != d) {
            _checkActions();
          } else{
            double tmp = double.parse(beforeResult);
            tmp -= double.parse(result.replaceAll(',', '.'));
            beforeResult = tmp.toString();
          }
        }
        result = '0';
        currentOperation = '-';
        break;
      case '/':
      if(!flag){
          if(currentOperation != d) {
            _checkActions();
          } else{
            double tmp = double.parse(beforeResult);
            double tpm = double.parse(result.replaceAll(',', '.'));
            if(tpm == 0) break;
            tmp /= tpm;
            beforeResult = tmp.toString();
          }
        }
        result = '0';
        currentOperation = '/';
        break;
      case '*':
        if(!flag){
          if(currentOperation != d) {
            _checkActions();
          } else{
            double tmp = double.parse(beforeResult);
            tmp *= double.parse(result.replaceAll(',', '.'));
            beforeResult = tmp.toString();
          }
        }
        result = '0';
        currentOperation = '*';
        break;
    }
    setState(() {});
  }
  void _result(){
    switch(currentOperation){
      case '+':
        double tmp = double.parse(beforeResult);
        tmp += double.parse(result.replaceAll(',', '.'));
        beforeResult = tmp.toString();
        result = beforeResult;
        break;
      case '-':
        double tmp = double.parse(beforeResult);
        tmp -= double.parse(result.replaceAll(',', '.'));
        beforeResult = tmp.toString();
        result = beforeResult;
        break;
      case '/':
        double tmp = double.parse(beforeResult);
        double tpm = double.parse(result.replaceAll(',', '.'));
        if(tpm == 0) break;
        tmp /= tpm;
        beforeResult = tmp.toString();
        result = beforeResult;
        break;
      case '*':
        double tmp = double.parse(beforeResult);
        tmp *= double.parse(result.replaceAll(',', '.'));
        beforeResult = tmp.toString();
        result = beforeResult;
        break;
    }
    result = beforeResult;
    beforeResult = '';
    currentOperation = '';
    setState(() {});
  }
  void _sign(){
    if(result != '0'){
      if(result.contains(',') || result.contains('.')){
        result = (double.parse(result.replaceAll(',', '.')) * -1).toString();
      }else{
         result = (int.parse(result.replaceAll(',', '.')) * -1).toString();
      }
      setState(() {});
    }
  }
void _drob(){
  if(result == '0') return;
  result = (1/double.parse(result.replaceAll(',', '.'))).toString();
  setState(() {}); 
}

void _sqrt(){
  if(result == '0') return;
  result = (sqrt(double.parse(result.replaceAll(',', '.')))).toString();
  setState(() {}); 
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Color.fromARGB(255, 255, 255, 255)),
        centerTitle: true,
        title: const Text("Задание 2 - Калькулятор",style: TextStyle(
          color: Color.fromARGB(255, 255, 255, 255),
          fontWeight: FontWeight.w700,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 29, 28, 22),
        ),
        body: Center(
          child: Container(
            width: 340,
            height: 500,
            color: const Color.fromARGB(255, 29, 28, 22),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(30),
                  child: Container(
                    padding: const EdgeInsetsDirectional.all(10),
                    color: const Color.fromARGB(255, 219, 201, 10),
                    width: 280,
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(result,style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500
                          ),),
                      ],
                    ) 
                  )
                ),
                 
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        FloatingActionButton(
                          backgroundColor: const Color.fromARGB(255, 219, 201, 10),
                          onPressed:()=>{_addNumeric(1)},
                          child:const Text("1",style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 26,
                            color: Color.fromARGB(255, 54,49, 0)
                          ),)
                        ),
                        FloatingActionButton(
                          backgroundColor: const Color.fromARGB(255, 219, 201, 10),
                          onPressed:()=>{_addNumeric(2)},
                          child:const Text("2",style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 26,
                            color: Color.fromARGB(255, 54,49, 0)
                          ),)
                        ),
                        FloatingActionButton(
                          backgroundColor: const Color.fromARGB(255, 219, 201, 10),
                          onPressed:()=>{_addNumeric(3)},
                          child:const Text("3",style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 26,
                            color: Color.fromARGB(255, 54,49, 0)
                          ),)
                        ),
                        FloatingActionButton(
                          backgroundColor: const Color.fromARGB(255, 219, 201, 10),
                          onPressed:()=>{_actionN('+')},
                          child:const Text("+",style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 26,
                            color: Color.fromARGB(255, 54,49, 0)
                          ),)
                        )
                      ],
                    ),
                    const Padding(padding: EdgeInsets.only(top: 20)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        FloatingActionButton(
                          backgroundColor: const Color.fromARGB(255, 219, 201, 10),
                          onPressed:()=>{_addNumeric(4)},
                          child:const Text("4",style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 26,
                            color: Color.fromARGB(255, 54,49, 0)
                          ),)
                        ),
                        FloatingActionButton(
                          backgroundColor: const Color.fromARGB(255, 219, 201, 10),
                          onPressed:()=>{_addNumeric(5)},
                          child:const Text("5",style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 26,
                            color: Color.fromARGB(255, 54,49, 0)
                          ),)
                        ),
                        FloatingActionButton(
                          backgroundColor: const Color.fromARGB(255, 219, 201, 10),
                          onPressed:()=>{_addNumeric(6)},
                          child:const Text("6",style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 26,
                            color: Color.fromARGB(255, 54,49, 0)
                          ),)
                        ),
                        FloatingActionButton(
                          backgroundColor: const Color.fromARGB(255, 219, 201, 10),
                          onPressed:()=>{_actionN('-')},
                          child:const Text("-",style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 26,
                            color: Color.fromARGB(255, 54,49, 0)
                          ),)
                        )
                      ],
                    ),
                    const Padding(padding: EdgeInsets.only(top: 20)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [FloatingActionButton(
                          backgroundColor: const Color.fromARGB(255, 219, 201, 10),
                          onPressed:()=>{_addNumeric(7)},
                          child:const Text("7",style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 26,
                            color: Color.fromARGB(255, 54,49, 0)
                          ),)
                        ),
                        FloatingActionButton(
                          backgroundColor: const Color.fromARGB(255, 219, 201, 10),
                          onPressed:()=>{_addNumeric(8)},
                          child:const Text("8",style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 26,
                            color: Color.fromARGB(255, 54,49, 0)
                          ),)
                        ),
                        FloatingActionButton(
                          backgroundColor: const Color.fromARGB(255, 219, 201, 10),
                          onPressed:()=>{_addNumeric(9)},
                          child:const Text("9",style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 26,
                            color: Color.fromARGB(255, 54,49, 0)
                          ),)
                        ),
                        FloatingActionButton(
                          backgroundColor: const Color.fromARGB(255, 219, 201, 10),
                          onPressed:()=>{_actionN('/')},
                          child:const Text("/",style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 26,
                            color: Color.fromARGB(255, 54,49, 0)
                          ),)
                        )],
                    ),
                    const Padding(padding: EdgeInsets.only(top: 20)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        FloatingActionButton(
                          backgroundColor: const Color.fromARGB(255, 219, 201, 10),
                          onPressed:()=>{setState(() {result += ',';})},
                          child:const Text(",",style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 26,
                            color: Color.fromARGB(255, 54,49, 0)
                          ),)
                        ),
                        FloatingActionButton(
                          backgroundColor: const Color.fromARGB(255, 219, 201, 10),
                          onPressed:()=>{_addNumeric(0)},
                          child:const Text("0",style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 26,
                            color: Color.fromARGB(255, 54,49, 0)
                          ),)
                        ),
                        FloatingActionButton(
                          backgroundColor: const Color.fromARGB(255, 219, 201, 10),
                          onPressed:()=>{setState(() {result = '0'; beforeResult = ''; currentOperation = '';})},
                          child:const Text("C",style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 26,
                            color: Color.fromARGB(255, 54,49, 0)
                          ),)
                        ),
                        FloatingActionButton(
                          backgroundColor: const Color.fromARGB(255, 219, 201, 10),
                          onPressed:()=>{_actionN('*')},
                          child:const Text("*",style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 26,
                            color: Color.fromARGB(255, 54,49, 0)
                          ),)
                        )
                      ],
                    ),
                    const Padding(padding: EdgeInsets.only(top: 20)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        FloatingActionButton(
                          backgroundColor: const Color.fromARGB(255, 219, 201, 10),
                          onPressed:()=>{_sqrt()},
                          child:const Text("SQRT",style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                            color: Color.fromARGB(255, 54,49, 0)
                          ),)
                        ),
                        FloatingActionButton(
                          backgroundColor: const Color.fromARGB(255, 219, 201, 10),
                          onPressed:()=>{_drob()},
                          child:const Text("1/x",style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 26,
                            color: Color.fromARGB(255, 54,49, 0)
                          ),)
                        ),
                        FloatingActionButton(
                          backgroundColor: const Color.fromARGB(255, 219, 201, 10),
                          onPressed:()=>{_sign()},
                          child:const Text("+/-",style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 26,
                            color: Color.fromARGB(255, 54,49, 0)
                          ),)
                        ),
                        FloatingActionButton(
                          backgroundColor: const Color.fromARGB(255, 219, 201, 10),
                          onPressed:()=>{_result()},
                          child:const Text("=",style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 26,
                            color: Color.fromARGB(255, 54,49, 0)
                          ),)
                        )
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
    );
  }
}