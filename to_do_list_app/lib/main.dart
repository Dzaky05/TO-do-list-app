import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final TextEditingController _controller = TextEditingController();

  // ⭐ List tugas + status selesai
  final List<Map<String, dynamic>> _tasks = [];

  void add() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        _tasks.add({
          "title": _controller.text,
          "done": false,
        });
        _controller.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Text("To-Do App"),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [

            /// ⭐ INPUT + TOMBOL TAMBAH
            Row(
              children: [

                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: "Input tugas",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),

                const SizedBox(width: 10),

                ElevatedButton(
                  onPressed: add,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(16),
                    minimumSize: const Size(50, 50),
                  ),
                  child: const Icon(Icons.add),
                ),
              ],
            ),

            const SizedBox(height: 20),

            /// ⭐ DAFTAR TUGAS
            Expanded(
              child: _tasks.isEmpty
                  ? const Center(
                      child: Text("Belum ada tugas"),
                    )
                  : ListView.builder(
                      itemCount: _tasks.length,
                      itemBuilder: (context, index) {
                        final task = _tasks[index];

                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              task["done"] = !task["done"];
                            });
                          },

                          child: Card(
                            color: task["done"]
                                ? Colors.green[200]
                                : Colors.white,

                            child: ListTile(
                              leading: Icon(
                                task["done"]
                                    ? Icons.check_circle
                                    : Icons.circle_outlined,
                                color: task["done"]
                                    ? Colors.green
                                    : Colors.grey,
                              ),

                              title: Text(
                                task["title"],
                                style: TextStyle(
                                  decoration: task["done"]
                                      ? TextDecoration.lineThrough
                                      : null,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
