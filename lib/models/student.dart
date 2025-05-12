class Student {
  final String? id;
  final String nama;
  final String nim;
  final String prodi;
  final String angkatan;

  Student({
    this.id,
    required this.nama,
    required this.nim,
    required this.prodi,
    required this.angkatan,
  });

  factory Student.fromJson(Map<String, dynamic> json, String id) {
    return Student(
      id: id,
      nama: json['nama'] ?? '',
      nim: json['nim'] ?? '',
      prodi: json['prodi'] ?? '',
      angkatan: json['angkatan'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {'nama': nama, 'nim': nim, 'prodi': prodi, 'angkatan': angkatan};
  }
}
