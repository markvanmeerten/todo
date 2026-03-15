### Wat ga je leren in deze stap?
In deze stap ga je:
- `Firebase project` maken
- `Firestore` als database gebruiken
- `TaskService` aanpassen zodat taken in de **cloud** worden opgeslagen

Na deze stap staan je taken niet meer alleen in de app, maar in `Firebase Firestore` en blijven ze ook bestaan als je de applicatie opnieuw opstart!

---
### 6.1 Wat is Firebase?
`Firebase` is een platform van Google waarmee apps:
- data kunnen opslaan
- gebruikers kunnen beheren
- real-time updates kunnen krijgen
- backend functionaliteit krijgen zonder zelf een server te bouwen

In deze tutorial gebruiken we `Firestore`. Dat is een **cloud database** waarin je documenten opslaat. Dit iets anders dan je gewend bent dan met SQL, het lijkt meer op JSON.

---
### 6.2 Maak een `Firebase` project
Ga naar: https://console.firebase.google.com
1. Log in met je Google account en klik op: `Create a new Firebase project`.
2. Geef je project een naam, bijvoorbeeld: `todo-flutter-app`.
3. Klik daarna een paar keer op: `Continue` (voor deze tutorial heb je geen **Google Analytics** nodig).
4. Klik daarna op: `Create project`.

Dit kan ongeveer **30 seconden duren**.

---
### 6.3 Zet `Firestore` aan
Ga naar: https://console.firebase.google.com en kies nu je project.

Klik in het linker menu op: `Databases and storage → Firestore`.
Klik nu op `Create database`.
- Start deze in `standaard mode`.
- Configureer deze in `test mode`.

We zouden hier handmatig data aan kunnen toevoegen, maar dat doen we later via onze app zelf.

---
### 6.4 Geef toegang aan iedereen
`Firestore` gebruikt **beveiligingsregels** om te bepalen wie data mag lezen of schrijven. Voor deze tutorial gebruiken we eenvoudige regels zodat iedereen data kan lezen en schrijven.

Ga naar:

```
Build → Firestore Database → Rules
```

Daar zie je de huidige regels van je database. Vervang de bestaande regels door:

```ts
rules_version = '2';

service cloud.firestore {
	match /databases/{database}/documents {
		match /{document=**} {
			allow read, write: if true;
		}
	}
}
```

Klik daarna op:

```
Publish
```

---
### 6.5 Installeer `FlutterFire`
Open een terminal in je projectmap en voer uit:

```
dart pub global activate flutterfire_cli
```

Controleer daarna of het werkt:

```
flutterfire --version
```

Zie je een versie verschijnen?
Dan werkt alles goed.

---
### 6.6 Koppel Firebase aan je app
Voer nu uit:

```
flutterfire configure
```

Selecteer het `Firebase project` dat je zojuist hebt gemaakt.
Daarna vraagt `FlutterFire` welke platforms je wilt gebruiken.

```
Kies: Android of Web
```

`FlutterFire` maakt nu automatisch een configuratiebestand in:

```
lib/firebase_options.dart
```

---
### 6.7 Voeg Firebase packages toe
Open:

```
pubspec.yaml
```

Voeg onder **dependencies** toe (tip: let op de spaties):

```yaml
dependencies:
  firebase_core: ^4.5.0
  cloud_firestore: ^6.1.3
  flutter:
    sdk: flutter
```

Run het volgende command om deze packages te installeren:

```
flutter pub get
```

---
### 6.8 `Firebase` initialiseren
Open:

```
lib/main.dart
```

Voeg bovenin toe:

```dart
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
```

Pas daarna je `main()` functie aan:

```dart
void main() async {
	WidgetsFlutterBinding.ensureInitialized();
	
	await Firebase.initializeApp(
		options: DefaultFirebaseOptions.currentPlatform,
	);
	
	runApp(const TaskApp());
}
```

Firebase maakt nu eerst verbinding met het project in de cloud voordat de app start.
Tip: Check of je app nog kan builden zonder errors!

---
### 6.9 Pas de `TaskService` aan voor `Firestore`
Open:

```
lib/services/task_service.dart
```

Voeg bovenin toe:

```dart
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/task.dart';
```

Vervang de volgende code:

```dart
final List<Task> _tasks = [
	Task(id: "1", title: "Boodschappen doen", done: false),
	Task(id: "2", title: "Huiswerk maken", done: true),
	Task(id: "3", title: "Flutter oefenen", done: false),
];

// Met deze regel:

final CollectionReference<Map<String, dynamic>> _tasksCollection = FirebaseFirestore.instance.collection('tasks');
```

Dit verwijst naar een `Firestore collectie` met de naam: `tasks`

---
### 6.10 Taken ophalen uit
Vervang je oude `getTasks()` functie door deze:

```dart
Stream<List<Task>> getTasks() {
	return _tasksCollection
		.orderBy('createdAt')
		.snapshots()
		.map((snapshot) {
			return snapshot.docs.map((doc) {
				final data = doc.data();
				
				return Task(
					id: doc.id,
					title: data['title'] ?? '',
					done: data['done'] ?? false,
				);
			}).toList();
	});
}
```

Deze functie luistert live naar `Firestore`.

---
### 6.11 Taken aanpassen
Vervang je oude `toggleTask()` functie door deze:

```dart
Future<void> toggleTask(Task task) async {
	await _tasksCollection.doc(task.id).update({
		'done': !task.done,
	});
}
```

Dit verandert het veld `done` in `Firestore`.

---
### 6.12 Taken toevoegen
Vervang je oude `addTask()` functie door deze:

```dart
Future<void> addTask(String title) async {
	await _tasksCollection.add({
		'title': title,
		'done': false,
		'createdAt': FieldValue.serverTimestamp(),
	});
}
```

Hiermee wordt een nieuw document toegevoegd aan `Firestore`.

---
### 6.13 Controlepunt
Je kunt je app nog niet runnen. Daarvoor moeten we de UI nog updaten. Dat doen we in de volgende stap.

Als je vastloopt kun je hier je [code vergelijken](https://github.com/markvanmeerten/todo/tree/tut-2-stap-6/lib)

---
### 6.14 Reflectie
Bekijk hier: [[Stap 7 - UI updaten met StreamBuilder]]