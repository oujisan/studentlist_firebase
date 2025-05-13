import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studentlist_firebase/models/student.dart';
import 'package:studentlist_firebase/providers/student_provider.dart';
import 'package:studentlist_firebase/screens/widgets/form_widget.dart';
import 'package:studentlist_firebase/screens/widgets/appbar_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context){
    final studentProvider = Provider.of<StudentProvider>(context);

    return Scaffold(
      appBar: AppbarWidget(),
      body: StreamBuilder<List<Student>>(
        stream: studentProvider.studentData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: Text('Loading...'));
          }

          if (snapshot.hasError) {
            return Center(child: Text('Terjadi kesalahan: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Belum ada data mahasiswa.'));
          }

          final studentData = snapshot.data!;

          return ListView.builder(
            itemCount: studentData.length,
            itemBuilder: (context, index) {
              final student = studentData[index];

              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 4,
                  shadowColor: Colors.grey.withOpacity(0.3),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                student.nama,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(student.nim),
                              Text(student.prodi),
                              Text(student.angkatan),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit, color: Colors.blueAccent),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => FormScreen(
                                      isEdit: true,
                                      student: student,
                                    ),
                                  ),
                                ).then((_) => setState(() {}));
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.redAccent),
                              onPressed: () async {
                                final confirm = await showDialog<bool>(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: const Text('Konfirmasi Hapus'),
                                    content: const Text('Yakin ingin menghapus data ini?'),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.pop(context, false),
                                        child: const Text('Batal'),
                                      ),
                                      TextButton(
                                        onPressed: () => Navigator.pop(context, true),
                                        child: const Text('Hapus', style: TextStyle(color: Colors.red)),
                                      ),
                                    ],
                                  ),
                                );

                                if (confirm == true) {
                                  studentProvider.deleteItem(student.id!);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Data berhasil dihapus')),
                                  );
                                  setState(() {});
                                }
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}