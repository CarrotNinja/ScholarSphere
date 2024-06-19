import 'package:flutter/material.dart';

class AppearancePage extends StatefulWidget {
  @override
  _AppearancePageState createState() => _AppearancePageState();
}

class _AppearancePageState extends State<AppearancePage> {
  List<List<Color>> gradients = [
    [Colors.purple, Colors.pink],
    [Colors.blue, Colors.green],
    [Colors.red, Colors.orange],
    [Colors.yellow, Colors.green],
    [Colors.teal, Colors.cyan],
  ];

  List<Color> selectedGradient = [Colors.purple, Colors.pink];

  @override
  void initState() {
    super.initState();
    // Set the first gradient as selected by default
    selectedGradient = gradients[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Appearance'),
        backgroundColor: Colors.white,
      ),
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const Text(
                'THEME',
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 9,
                    crossAxisSpacing: 9,
                  ),
                  itemCount: gradients.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedGradient = gradients[index];
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: gradients[index],
                          ),
                          border: Border.all(
                            color: selectedGradient == gradients[index]
                                ? Colors.black
                                : Color.fromARGB(255, 111, 0, 255),
                            width: selectedGradient == gradients[index] ? 6 : 3,
                          ),
                          borderRadius: BorderRadius.circular(9),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
