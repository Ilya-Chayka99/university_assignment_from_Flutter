
import 'package:flutter/material.dart';
import 'package:pedometer/pedometer.dart';
import 'package:permission_handler/permission_handler.dart';

class PedomertScreen extends StatefulWidget {
  const PedomertScreen({super.key});

  @override
  State<PedomertScreen> createState() => _PedomertScreenState();
}

class _PedomertScreenState extends State<PedomertScreen> {
  late Stream<StepCount> _stepCountStream;
  late Stream<PedestrianStatus> _pedestrianStatusStream;
  String _status = 'Нет разрешения', _steps = '0';
  bool flag = false;
  
  Future<void> Check() async {
    PermissionStatus status = await Permission.activityRecognition.request();
    if(status == PermissionStatus.granted){
      setState(() {
        flag = true;
        initPlatformState(); 
      });
    }
  }

  
  @override
  void initState() {
    super.initState();
    initPlatformState(); 
    Check(); 
  }

  void onStepCount(StepCount event) {
    setState(() {
      _steps = event.steps.toString();
    });
  }
  void onPedestrianStatusChanged(PedestrianStatus event) {
    setState(() {
      _status = event.status;
    });
  }
  void onPedestrianStatusError(error) {
    setState(() {
      _status = 'Нет разрешения';
    });
  }
  void onStepCountError(error) {
    setState(() {
      _status = 'Нет счетчика шагов\n на этом устройстве';
    });
  }

   void initPlatformState() {
    _pedestrianStatusStream = Pedometer.pedestrianStatusStream;
    _pedestrianStatusStream
        .listen(onPedestrianStatusChanged)
        .onError(onPedestrianStatusError);

    _stepCountStream = Pedometer.stepCountStream;
    _stepCountStream.listen(onStepCount).onError(onStepCountError);

    if (!mounted) return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 29, 28, 22),
         iconTheme: const IconThemeData(color: Color.fromARGB(255, 255, 255, 255)),
            centerTitle: true,
        title: const Text("Шагомер",style:TextStyle(
          color: Color.fromARGB(255, 255, 255, 255),
          fontWeight: FontWeight.w700,
        ),),
      ),
      body:Center(
        child: Column(
          children: [
            Image.asset("lib/image/run.jpg", width: MediaQuery.of(context).size.width,),
            SizedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(flag?_steps.toString():_status,style: TextStyle(
                    fontSize: (!flag)? 16 : 24,
                    fontWeight:FontWeight.w700,
                    color: Colors.white
                  ),),
                  const SizedBox(width: 30,),
                  flag?
                  Icon(
                    _status == 'walking'
                        ? Icons.directions_walk
                        : _status == 'stopped'
                            ? Icons.accessibility_new
                            : Icons.accessibility_new,
                    size: 50,
                    color: Colors.white,
                  ):const Icon(Icons.error,color: Colors.white,size: 50,)
                ],
              ),
            ),
            !flag&&_status=='Нет разрешения'&&_status!='Нет счетчика шагов\n на этом устройстве'?
            TextButton(
              onPressed:()  async {
                PermissionStatus status = await Permission.activityRecognition.request();
                if(status == PermissionStatus.permanentlyDenied){
                  openAppSettings();
                }
                if(status == PermissionStatus.granted){
                  setState(() {
                    flag = true;
                    initPlatformState(); 
                  });
                }
              }, 
              child: const Text("Зпросить доступ! / Обновить"),
            ):Container(),
          ],
        ),
      ),
    );
  }
}