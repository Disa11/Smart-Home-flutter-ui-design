import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

class FirebaseService {
  FirebaseDatabase? _rtdb;

  Future<void> initializeFirebase() async {
    await Firebase.initializeApp(); // Inicializamos Firebase
    _rtdb = FirebaseDatabase.instanceFor(
      app: Firebase.app(),
      databaseURL: 'https://test-flutter-9981e-default-rtdb.firebaseio.com',
    );
  }

  // Escuchar cambios en la referencia
  void listenStatus(String path, Function(dynamic) onDataChanged) {
    DatabaseReference databaseRef = _rtdb!.ref(path);
    databaseRef.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value;
      onDataChanged(data); // Llama a la función pasada cuando cambie el valor
    });
  }
}
