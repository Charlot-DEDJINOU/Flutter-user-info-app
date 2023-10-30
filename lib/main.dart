import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
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

  int _selectedIndex = 0 ;
  final _nameController = TextEditingController() ;
  final _passwordController = TextEditingController() ;
  String? sexe;
  bool? _football = false ;
  bool? _music = false ;
  bool?  _mangas = false ;
  final formKey = new GlobalKey<FormState>() ;
  String _name = "Charlot DEDJINOU";
  bool loading = false ;
  bool _displayInfo = false ;
  bool visible = true ;

  _displayDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Alert Dialog"),
            content: Text("Etes-vous sûr de vouloir soumettre le formulaire ?"),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context , "Cancel"),
                child: const Text("Cancel"),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context , "OK");
                    setState(() {
                      loading = true ;
                    }) ;
                    Future.delayed(const Duration(seconds: 5) , () {
                      setState(() {
                        loading = false ;
                        _name = _nameController.text ;
                        _displayInfo = true ;
                      }) ;
                    });
                  },
                  child: const Text("Ok")
              )
            ],
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home" , style: TextStyle(color: Colors.white , fontWeight: FontWeight.bold , fontSize: 25)),
        backgroundColor: Colors.green ,
        actions: [
          IconButton(onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Mes notifications"))
            );
          }, icon: Icon(Icons.add_alert , color: Colors.white) , tooltip: "Mes notifications") ,
          IconButton(onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Rechercher"))
            );
          }, icon: Icon(Icons.search , color: Colors.white))
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.green ,
              ),
                child: Text(_name , style: TextStyle(color: Colors.white))
            ),
            ListTile(
              leading: Icon(Icons.email , color: Colors.green,),
              title: Text("Messages"),
            ),
            ListTile(
              leading: Icon(Icons.person,color: Colors.green),
              title: Text("Profil"),
            ),
            ListTile(
              leading: Icon(Icons.settings,color: Colors.green),
              title: Text("Parametre"),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (int index) {
          setState(() {
            _selectedIndex = index ;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.person) , label: "Inscription"),
          BottomNavigationBarItem(icon: Icon(Icons.info) , label: "Informations"),
          BottomNavigationBarItem(icon: Icon(Icons.settings) , label: "Parametres")
        ],
      ),
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.green,
        child: Icon(Icons.add),
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Float action cliqued'))
          );
        },
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children : [
            Text("Informations de l'utilisateur" , style : TextStyle(color: Colors.green , fontWeight: FontWeight.bold , fontSize: 20)) ,
            SizedBox(height: 15.0),
            Center(
              child: Image.asset("assets/images/user.png", scale: 4,),
            ),
            SizedBox(height: 20.0),
            Form(
              key : formKey ,
              child: Column(
                children: [
                   TextFormField(
                     controller: _nameController,
                     keyboardType: TextInputType.name,
                     decoration: InputDecoration(
                       label: Text("Nom & Prenom"),
                       icon: Icon(Icons.person),
                       hintText: "Entrez votre nom et orenom"
                     ),
                     validator: (String? value) {
                        return value == null || value == "" ? "Ce champ est obligatoire" : null ;
                     },
                   ),
                   TextFormField(
                    controller: _passwordController,
                    obscureText: visible,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        label: Text("Password"),
                        icon: Icon(Icons.lock),
                        hintText: "Entrer votre mot de passe"
                    ),
                    validator: (String? value) {
                      return value == null || value == "" ? "Ce champ est obligatoire" : null ;
                    },
                  ),
                   DropdownButtonFormField(
                     style: TextStyle(
                       color : Colors.white
                     ),
                      decoration: new InputDecoration(
                        icon : Icon(Icons.transgender),
                        hintText: "Quel est votre sexe",
                        labelText: "Sexe"
                      ),
                      items: <String>['Masculin' , 'Feminin' , 'Autre']
                          .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value : value ,
                                child: Text(value , style: TextStyle(color: Colors.black),),
                              );
                      }).toList() ,
                      onChanged: (String? value) async {
                        setState(() {
                          sexe = value ;
                        });
                      },
                     validator: (str) => str == null ? "Ce champ est obligatoire" : null,
                   ),
                   SizedBox(height: 15.0),
                   Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Quels sont vos passe temps ?" , style: TextStyle(fontSize: 16.0 , fontWeight: FontWeight.bold)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Checkbox(
                                value: _mangas ,
                                checkColor: Colors.white ,
                                onChanged: (bool? b) {
                                  setState(() {
                                    _mangas = b ;
                                  });
                                }
                            ),
                            Text("Mangas" , style: TextStyle(color : Colors.black),)
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Checkbox(
                                value: _music ,
                                checkColor: Colors.white ,
                                onChanged: (bool? b) {
                                  setState(() {
                                    _music = b ;
                                  });
                                }
                            ),
                            Text("Music" , style: TextStyle(color : Colors.black),)
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Checkbox(
                                value: _football ,
                                checkColor: Colors.white ,
                                onChanged: (bool? b) {
                                  setState(() {
                                    _football = b ;
                                  });
                                }
                            ),
                            Text("Football" , style: TextStyle(color : Colors.black),)
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 5.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {
                       if(formKey.currentState!.validate()) {
                         _displayDialog(context);
                       }
                    },
                    child: Text("Valider" , style: TextStyle(color: Colors.green))
                ),
                SizedBox(width: 5.0,),
                loading ? CircularProgressIndicator(color: Colors.green,strokeWidth: 5) : SizedBox()
              ],
            ),
            _displayInfo ? Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.person),
                    title: RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(text : "Je m'appelle ", style: TextStyle(color : Colors.black)) ,
                          TextSpan(text : _name , style: TextStyle(fontWeight: FontWeight.bold , color: Colors.black))
                        ]
                      ),
                    ),
                    subtitle: Text("Voici mes passions : "),
                  ),
                  _football == true ? Text("Football") : SizedBox(),
                  _mangas == true ? Text("Mangas") : SizedBox(),
                  _music == true ? Text("Music") : SizedBox(),
                ],
              ),
            ) : SizedBox()
          ]
        ),
      ),
    );
  }
}
