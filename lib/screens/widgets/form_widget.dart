import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studentlist_firebase/models/student.dart';
import 'package:studentlist_firebase/providers/student_provider.dart';

class FormScreen extends StatefulWidget {
  final Student? student;

  const FormScreen({super.key, this.student, required bool isEdit});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _namaController;
  late TextEditingController _nimController;
  late TextEditingController _prodiController;
  late TextEditingController _angkatanController;

  @override
  void initState() {
    super.initState();
    _namaController = TextEditingController(text: widget.student?.nama ?? '');
    _nimController = TextEditingController(text: widget.student?.nim ?? '');
    _prodiController = TextEditingController(text: widget.student?.prodi ?? '');
    _angkatanController = TextEditingController(text: widget.student?.angkatan ?? '');
  }

  @override
  void dispose() {
    _namaController.dispose();
    _nimController.dispose();
    _prodiController.dispose();
    _angkatanController.dispose();
    super.dispose();
  }

  void _saveStudent() {
    if (_formKey.currentState!.validate()) {
      final student = Student(
        id: widget.student?.id,
        nama: _namaController.text,
        nim: _nimController.text,
        prodi: _prodiController.text,
        angkatan: _angkatanController.text,
      );

      final provider = Provider.of<StudentProvider>(context, listen: false);

      if (widget.student == null) {
        provider.addItem(student);
      } else {
        provider.updateItem(student);
      }
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.student != null;
    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? 'Edit Mahasiswa' : 'Tambah Mahasiswa'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _namaController,
                decoration: const InputDecoration(labelText: 'Nama'),
                validator: (value) => value!.isEmpty ? 'Wajib diisi' : null,
              ),
              TextFormField(
                controller: _nimController,
                decoration: const InputDecoration(labelText: 'NIM'),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'Wajib diisi' : null,
              ),
              TextFormField(
                controller: _prodiController,
                decoration: const InputDecoration(labelText: 'Program Studi'),
                validator: (value) => value!.isEmpty ? 'Wajib diisi' : null,
              ),
              TextFormField(
                controller: _angkatanController,
                decoration: const InputDecoration(labelText: 'Angkatan'),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'Wajib diisi' : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveStudent,
                child: Text(isEdit ? 'Edit' : 'Tambah'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
