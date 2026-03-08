### Wat ga je leren in deze stap?
In de eerste tutorial gebruikten we een Map om taken op te slaan, bijvoorbeeld:

```dart
{
  "title": "Boodschappen doen",
  "done": false
}
```

Dit werkt, maar in grotere apps heeft dit nadelen. In deze stap ga je:
- een echte klasse `Task` maken
- begrijpen waarom dat beter is dan een Map
- de basis leggen voor Firebase later

---
### 2.1 Bekijk hoe taken nu opgeslagen zijn
Open:

```
/lib/main.dart
```

Zoek naar de lijst met taken. Je ziet waarschijnlijk iets dat lijkt op:
```dart
final List<Map<String, dynamic>> tasksJson = [
  {"title": "Boodschappen doen", "done": false},
  {"title": "Huiswerk maken", "done": true},
  {"title": "Flutter oefenen", "done": false},
];
```

Elke taak is dus een `Map`. Denk na over de volgende nadelen van een `Map`:
- Wat gebeurt er als je "titel" schrijft in plaats van "title"?
- Hoe weet Flutter welke velden een taak heeft?
- Kun je gemakkelijk functies toevoegen aan een taak?

---
### 2.2 Maak een Task model
Open het bestand:

```
lib/models/task.dart
```

**Opdracht:**
Maak hier een klasse die één taak beschrijft. Probeer eerst zelf te bedenken welke eigenschappen een taak moet hebben.

**Controleer je antwoord:**
Je klasse zou ongeveer deze structuur moeten hebben:

```dart
class Task {
  final String id;
  final String title;
  final bool done;
  
  Task({
    required this.id,
    required this.title,
    required this.done,
  });
}
```

**Wat gebeurt hier?**
- We maken een nieuw datatype: `class Task`
- We voegen properties toe die niet gewijzigd mogen worden: `final Type varnaam`
- We voegen een constructor toe die nieuwe objecten verplicht (`required`) waardes toekent

> Als we `title` of `done` willen wijzigen maken we een heel nieuw object met de nieuwe waardes. Hierover meer in [[Stap 3 - Maak je TaskService (get)]]

---
### 2.3 Maak een Task object
Nu gaan we testen of onze klasse werkt. Open `main.dart` en vervang alle code met:

```dart 
import 'package:flutter/material.dart';
import 'package:todo/pages/task_home_page.dart';
import 'package:todo/models/task.dart';

void main() {
  runApp(TaskApp());
}

class TaskApp extends StatelessWidget {
  TaskApp({super.key});
  
  final List<Map<String, dynamic>> tasksJson = [
    {"title": "Boodschappen doen", "done": false},
    {"title": "Huiswerk maken", "done": true},
    {"title": "Flutter oefenen", "done": false},
  ];
  
  final task = Task(id: "1", title: "Leren van mijn fouten", done: false);
  
  @override
  Widget build(BuildContext context) {

    print("Test1: " + task.titel);

    print("Test2: " + tasksJson[0]["titel"]);

    return const MaterialApp(
      home: TaskHomePage(),
    );
  }
}
```

Je hebt nu een object van type `Task` gemaakt. De code geeft wel een error!
Fix de error en run het command: ```

```
flutter run -d chrome
```

---
### 2.4 Vergelijk Map en Model
Vergelijk deze twee manieren:

```dart
// Model
print(task.title)

// Map
print(tasksJson["title"])
```

Stel dat je per ongeluk `"titel"` schrijft in plaats van `"title"` in een Map, wat zou er dan gebeuren? En zou dit probleem ook kunnen gebeuren bij een `Task` modelklasse?

---
### 2.5 Waarom we dit doen
Later in deze tutorial gaan we:
- taken opslaan in `Firebase`
- taken ophalen uit `Firestore`
- taken omzetten naar objecten (modellen)

Daarvoor hebben we een duidelijk model nodig:
- maakt code leesbaarder
- voorkomt typefouten
- werkt beter met `Firestore`

---
### 2.6 Controlepunt
Bestaat de file:

```
lib/models/task.dart
```

Bevat de klasse `Task` de properties:
- `id`
- `title`
- `done`

Heb je de test code uit stap 2.3 weer verwijderd?
Als dat zo is, ben je klaar voor de volgende stap.

Als je vastloopt kun je hier je [code vergelijken](https://github.com/markvanmeerten/todo/tree/tut-2-stap-2)

---
### 2.7 Reflectie
In de vorige tutorial gebruikten we een `Map` om taken op te slaan.
In deze stap hebben we een `Task` klasse gemaakt.

Waarom kan een modelklasse zoals `Task` handiger zijn dan een `Map` wanneer een app groter wordt?

Bekijk hier [[Stap 3 - Maak je TaskService (get)]]