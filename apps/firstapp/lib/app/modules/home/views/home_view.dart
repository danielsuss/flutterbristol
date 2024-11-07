import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController counterController = TextEditingController();

    counterController.addListener(() {
      final int? newValue = int.tryParse(counterController.text);
      if (newValue != null && newValue != controller.count.value) {
        controller.set(newValue);
      } else if (counterController.text.isEmpty) {
        counterController.text = '0';
        controller.set(0);
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeView'),
        centerTitle: true,
      ),
      
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: controller.increment,
                  child: const Text('Increment'),
                ),

                const SizedBox(width: 10),

                ElevatedButton(
                  onPressed: () => {
                    if (controller.count.value > 0) {
                      controller.decrement(),
                    } else {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Alert'),
                            content: const Text('Counter cannot be negative.'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          );
                        }
                      ),
                    }
                  },
                  child: const Text('Decrement'),
                ),
              ],
            ),

            const SizedBox(height: 10),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Counter:',
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(width: 5),
                Obx(() {
                  counterController.value = TextEditingValue(
                    text: controller.count.value.toString(),
                    selection: TextSelection.fromPosition(
                      TextPosition(offset: controller.count.value.toString().length),
                    ),
                  );
                  return SizedBox(
                    width: 80,
                    child: TextField(
                      controller: counterController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 20),
                    ),
                  );
                }),
              ],
            ),

            const SizedBox(height: 10,),

            ElevatedButton(
                  onPressed: () => {
                    controller.set(0),
                  } ,
                  child: const Text('Reset'),
                ),

          ],
        ),
      ),
    );
  }
}
