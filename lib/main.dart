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
      title: 'Passage de paramètres entre deux interfaces',
      theme: ThemeData(
          primarySwatch: Colors.lightGreen,
      ),
      home: const PremiereInterface(title: 'Première interface'),
    );
  }
}

class PremiereInterface extends StatefulWidget {
  const PremiereInterface({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<PremiereInterface> createState() => _PremiereInterfaceState();
}

class _PremiereInterfaceState extends State<PremiereInterface> {
  String valeur = '';
  final paramEnvoiController = TextEditingController();
  final paramRecuController = TextEditingController();


  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    paramEnvoiController.dispose();
    paramRecuController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Interface 1'),
        centerTitle: true,
      ),
        body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: paramEnvoiController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Envoi Paramètre',
                      hintText: 'Ecrire un text à passer à la deuxième interface'),
                ),

            const SizedBox(height: 32),
      ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 24,vertical: 12),
          textStyle: TextStyle(fontSize: 28),
        ),
        child: Text('Passer données'),
        onPressed: () async {
          final nouvelleValeur = await Navigator.of(context).push(MaterialPageRoute(builder: (context)=> DeuxiemeInterface(valeur: paramEnvoiController.text),));
          setState(() {
            paramEnvoiController.text = "";
            this.valeur = nouvelleValeur;

          });
        },
),
                const SizedBox(height: 32),
            Text(
              'L\'élément envoyé depuis la deuxième interface est : ' + this.valeur,
              style: TextStyle(fontSize: 14),
            ),
            ]
    ))
    );}
}
class DeuxiemeInterface extends StatefulWidget {
  final String valeur;

  const DeuxiemeInterface({Key? key, required this.valeur}) : super(key: key);


  @override
  State<DeuxiemeInterface> createState() => _DeuxiemeInterfaceState();
}
class _DeuxiemeInterfaceState extends State<DeuxiemeInterface> {

  final paramController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Interface 2'),
          centerTitle: true,
        ),
        body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'L\'élément envoyé depuis la première interface est : ' +   widget.valeur,
                  style: TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 32),
                TextField(
                  controller: paramController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Envoi Paramètre',
                      hintText: 'Ecrire un text à passer à la première interface'),
                ),

                const SizedBox(height: 32),



            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 24,vertical: 12),
                textStyle: TextStyle(fontSize: 28),
              ),
              child: Text('Retouner données'),
              onPressed: () {
                Navigator.of(context).pop(paramController.text);
              },
            )
              ],
            )
    ));
  }
}