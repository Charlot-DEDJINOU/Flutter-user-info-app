import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  String textPresentation = "My Presentation";
  final formKey = new GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController professionController = TextEditingController();
  TextEditingController ageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text("Presentation" , style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const Icon(Icons.person) ,
          Form(
            key : formKey,
            child: Column(
              children: [
                TextFormField(
                  keyboardType: TextInputType.name,
                  controller: nameController,
                  decoration: InputDecoration(
                    icon : Icon(Icons.person),
                    labelText: "Nom",
                    hintText: "Entrer votre nom & prenoms"
                  ),
                  validator: (value) {
                    return value == null  || value == "" ?
                        "Ce champ est obligatoire" : null;
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.name,
                  controller: professionController,
                  decoration: InputDecoration(
                      icon : Icon(Icons.work),
                      labelText: "Profession",
                      hintText: "Entrer votre profession"
                  ),
                  validator: (value) {
                    return value == null  || value == "" ?
                    "Ce champ est obligatoire" : null;
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: ageController,
                  decoration: InputDecoration(
                      icon : Icon(Icons.date_range),
                      labelText: "Age",
                      hintText: "Entrer votre age"
                  ),
                  validator: (value) {
                    return value == null  || value == "" ?
                    "Ce champ est obligatoire" : null;
                  },
                )
              ],
            ),
          ),
          ElevatedButton(onPressed: () {
            if(formKey.currentState!.validate()){
              setState(() {
                textPresentation = "Je m'appelle " + nameController.text + ".Je suis " + professionController.text + " et j'ai " + ageController.text +  " ans";
                nameController.text = "" ;
                ageController.text = "" ;
                professionController.text = "" ;
              });
            }

          }, child: Text("Valider" , style: TextStyle(color: Colors.green))),
          Text(textPresentation , style: TextStyle(fontSize: 15 , fontWeight: FontWeight.bold , fontStyle: FontStyle.italic)),
        ],
      ),
    );
  }
}
