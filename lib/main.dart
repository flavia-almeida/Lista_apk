import 'package:flutter/material.dart';
//import 'package:social_share/social_share.dart'; // dependencies: social_share: ^2.0.5

void main() {
  runApp(MaterialApp(
    title: 'Lista',
    debugShowCheckedModeBanner: false,
    home: MainApp(),
  ));
}

class MainApp extends StatefulWidget {
  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final _formKey = GlobalKey<FormState>();
  var _itemController = TextEditingController();
  var _itemControllerValue = TextEditingController();
  var _itemControllerAmount = TextEditingController();
  List _lista = [];
  List _listaValue = [];
  List _listaAmount = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Compras'),
        centerTitle: true,
      ),
      body: Scrollbar(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 8),
          children: [
            for (int i = 0; i < _lista.length; i++)
              ListTile(
                  leading: ExcludeSemantics(
                    child: CircleAvatar(child: Text('${i + 1}')),
                  ),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Row(
                            children: [
                              Text(_lista[i].toString()),
                              Text(" -  "),
                              Text(_listaAmount[i].toString()),
                              Text(" - R\$"),
                              Text(_listaValue[i].toString()),
                            ]
                          //_lista[i].toString(),
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.delete,
                          size: 20.0,
                          color: Colors.red[900],
                        ),
                        onPressed: () {
                          setState(() {
                            _lista.removeAt(i);
                          });
                        },
                      ),
                    ],
                  )),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _displayDialog(context),
      ),
    );
  }

  _displayDialog(context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _itemController,
                    validator: (s) {
                      if (s.isEmpty)
                        return "Digite o item!";
                      else
                        return null;
                    },
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(labelText: "Item"),
                  ),

                  TextFormField(
                    controller: _itemControllerValue,
                    validator: (s) {
                      if (s.isEmpty)
                        return "Digite o valor!";
                      else
                        return null;
                    },
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(labelText: "Valor"),
                  ),

                  TextFormField(
                    controller: _itemControllerAmount,
                    validator: (s) {
                      if (s.isEmpty)
                        return "Digite a quantidade!";
                      else
                        return null;
                    },
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(labelText: "Quantidade"),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: new Text('CANCEL'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: new Text('SALVAR'),
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    setState(() {
                      _lista.add(_itemController.text);
                      _itemController.text = "";

                      _listaValue.add(_itemControllerValue.text);
                      _itemControllerValue.text = "";

                      _listaAmount.add(_itemControllerAmount.text);
                      _itemControllerAmount.text = "";
                    });
                    Navigator.of(context).pop();
                  }
                },
              )
            ],
          );
        });
  }
}
