import 'contact_model.dart';
import 'contact_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ContactProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController cName = TextEditingController();
  TextEditingController cNumber = TextEditingController();

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> contacts = [
      {
        "name": "Ann",
        "number": 3,
      },
      {
        "name": "Hani",
        "number": 2,
      },
      {
        "name": "Shua",
        "number": 3,
      },
      {
        "name": "Bini",
        "number": 5,
      }
    ];
    return Scaffold(
        appBar: AppBar(
          title: const Text('Contact Page'),
        ),
        body: ListView.builder(
          itemCount: contacts.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: const Icon(Icons.person),
              trailing: const Icon(Icons.phone),
              title: Text(contacts[index]["name"]),
              subtitle: Text(contacts[index]['number'].toString()),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              addDialog(context);
            },
            child: const Icon(Icons.add)));
  }

  Future<dynamic> addDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Add Name"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: cName,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: cNumber,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel')),
            ElevatedButton(
                onPressed: () async {
                  var todo = Contact(name: cName.text, number: cNumber.text);
                  context.watch<ContactProvider>().addContact(todo);

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.green[900],
                      content: const Text(
                        "Contact added successfully",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  );
                  Navigator.pop(context);
                },
                child: const Text('Add')),
          ],
        );
      },
    );
  }
}
