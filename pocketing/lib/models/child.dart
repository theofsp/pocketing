class Child {
  final String? id;
  final String name;
  final String gender; // "male" atau "female"
  final int age;
  final String currency; // contoh: "IDR", "USD"
  final double monthlyAllowance;
  final int cycleStartDay; // tanggal mulai cycle, contoh: 25
  final String? avatarEmoji;
  final double balance; // saldo uang jajan saat ini

  Child({
    this.id,
    required this.name,
    required this.gender,
    required this.age,
    required this.currency,
    required this.monthlyAllowance,
    required this.cycleStartDay,
    this.avatarEmoji,
    this.balance = 0,
  });

  // Ubah data Child jadi format Map, supaya bisa disimpan ke Firestore
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'gender': gender,
      'age': age,
      'currency': currency,
      'monthlyAllowance': monthlyAllowance,
      'cycleStartDay': cycleStartDay,
      'avatarEmoji': avatarEmoji,
      'balance': balance,
    };
  }

  // Ubah data dari Firestore (format Map) jadi objek Child
  factory Child.fromMap(String id, Map<String, dynamic> map) {
    return Child(
      id: id,
      name: map['name'] ?? '',
      gender: map['gender'] ?? '',
      age: map['age'] ?? 0,
      currency: map['currency'] ?? 'IDR',
      monthlyAllowance: (map['monthlyAllowance'] ?? 0).toDouble(),
      cycleStartDay: map['cycleStartDay'] ?? 25,
      avatarEmoji: map['avatarEmoji'],
      balance: (map['balance'] ?? 0).toDouble(),
    );
  }
}