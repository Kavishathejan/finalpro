import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'BMI Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => CalculateScreen()),
        GetPage(name: '/info', page: () => InfoScreen()),
      ],
    );
  }
}

class CalculateScreen extends StatelessWidget {
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();

  void calculateBMI(BuildContext context) {
    double height = double.tryParse(heightController.text) ?? 0;
    double weight = double.tryParse(weightController.text) ?? 0;

    if (height <= 0 || weight <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter valid height and weight.'),
        ),
      );
      return;
    }

    double bmi = weight / ((height / 100) * (height / 100));
    Get.to(InfoScreen(), arguments: bmi);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculate Your  BMI'),
        centerTitle: true,
        toolbarHeight: kToolbarHeight + 40, 
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/exercise.png',
            fit: BoxFit.cover,
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: heightController,
                  keyboardType: TextInputType.number,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Height (cm)',
                    labelStyle: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(height: 50),
                TextField(
                  controller: weightController,
                  keyboardType: TextInputType.number,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Weight (kg)',
                    labelStyle: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(height: 50),
                ElevatedButton(
                  onPressed: () => calculateBMI(context),
                  child: Text('Calculate'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class InfoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double bmi = Get.arguments ?? 0;

    String getCategory(double bmi) {
      if (bmi < 16) {
        return 'Severe undernourishment';
      } else if (bmi >= 16 && bmi <= 16.9) {
        return 'Medium undernourishment';
      } else if (bmi >= 17 && bmi <= 18.4) {
        return 'Slight undernourishment';
      } else if (bmi >= 18.5 && bmi <= 24.9) {
        return 'Normal nutrition state';
      } else if (bmi >= 25 && bmi <= 29.9) {
        return 'Overweight';
      } else if (bmi >= 30 && bmi <= 39.9) {
        return 'Obesity';
      } else {
        return 'Pathological Obesity';
      }
    }

    String category = getCategory(bmi);

    String backgroundImage;
    switch (category) {
      case 'Severe undernourishment':
        backgroundImage = 'assets/severe.png';
        break;
      case 'Medium undernourishment':
        backgroundImage = 'assets/medium.png';
        break;
      case 'Slight undernourishment':
        backgroundImage = 'assets/slight.png';
        break;
      case 'Normal nutrition state':
        backgroundImage = 'assets/normal.png';
        break;
      case 'Overweight':
        backgroundImage = 'assets/over.png';
        break;
      case 'Obesity':
        backgroundImage = 'assets/obesity.png';
        break;
      case 'Pathological Obesity':
        backgroundImage = 'assets/patho.png';
        break;
      default:
        backgroundImage = 'assets/default_photo.jpg';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Your BMI and BMI Category'),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            backgroundImage,
            fit: BoxFit.cover,
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Your BMI: ${bmi.toStringAsFixed(3)}',
                  style: TextStyle(fontSize: 40, color: Colors.white),
                ),
                SizedBox(height: 20),
                Text(
                  'Category: $category',
                  style: TextStyle(fontSize: 40, color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
