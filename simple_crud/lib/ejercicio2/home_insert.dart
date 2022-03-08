import 'package:flutter/material.dart';
import 'package:simple_crud/database.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

class HomeState extends State<Home> {
  List<Courier> _list;
  DatabaseHelper _databaseHelper;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Examen"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              insert(context);
            },
          )
        ],
      ),
      body: _getBody(),
    );
  }

  void insert(BuildContext context) {
    Courier nNombre = new Courier();

    final _formKey = GlobalKey<FormState>();
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Nuevo"),
            content: Stack(
              overflow: Overflow.visible,
              children: <Widget>[
                Positioned(
                  right: -40.0,
                  top: -40.0,
                  child: InkResponse(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: CircleAvatar(
                      child: Icon(Icons.close),
                      backgroundColor: Colors.red,
                    ),
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TextFormField(
                          onChanged: (value) {
                            nNombre.title = value;
                          },
                          decoration: InputDecoration(labelText: "Nombre:"),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FlatButton(
                          child: Text("Cancelar"),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: FlatButton(
                            child: Text("Guardar"),
                            onPressed: () {
                              Navigator.of(context).pop();
                              _databaseHelper.insert(nNombre).then((value) {
                                updateList();
                              });
                            },
                          ))
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }

  void onDeletedRequest(int index) {
    Courier courier = _list[index];
    _databaseHelper.delete(courier).then((value) {
      setState(() {
        _list.removeAt(index);
      });
    });
  }

  void onUpdateRequest(int index) {
    Courier nNombre = _list[index];
    final controller = TextEditingController(text: nNombre.title);

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Modificar"),
            content: TextField(
              controller: controller,
              onChanged: (value) {
                nNombre.title = value;
              },
              decoration: InputDecoration(labelText: "Nombre:"),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text("Cancelar"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text("Actualizar"),
                onPressed: () {
                  Navigator.of(context).pop();
                  _databaseHelper.update(nNombre).then((value) {
                    updateList();
                  });
                },
              )
            ],
          );
        });
  }

  Widget _getBody() {
    if (_list == null) {
      return CircularProgressIndicator();
    } else if (_list.length == 0) {
      return Text("Está vacío");
    } else {
      return ListView.builder(
          itemCount: _list.length,
          itemBuilder: (BuildContext context, index) {
            Courier courier = _list[index];
            return CourierWidget(
                courier, onDeletedRequest, index, onUpdateRequest);
          });
    }
  }

  @override
  void initState() {
    super.initState();
    _databaseHelper = new DatabaseHelper();
    updateList();
  }

  void updateList() {
    _databaseHelper.getList().then((resultList) {
      setState(() {
        _list = resultList;
      });
    });
  }
}

typedef OnDeleted = void Function(int index);
typedef OnUpdate = void Function(int index);

class CourierWidget extends StatelessWidget {
  final Courier courier;
  final OnDeleted onDeleted;
  final OnUpdate onUpdate;
  final int index;
  CourierWidget(this.courier, this.onDeleted, this.index, this.onUpdate);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key("${courier.id}"),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Text(courier.title),
            ),
            IconButton(
              icon: Icon(
                Icons.edit,
                size: 30,
              ),
              onPressed: () {
                this.onUpdate(index);
              },
            )
          ],
        ),
      ),
      onDismissed: (direction) {
        onDeleted(this.index);
      },
    );
  }
}
