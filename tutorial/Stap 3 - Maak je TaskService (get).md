### Wat ga je leren in deze stap?
In de eerste tutorial stond alles in één bestand:
- UI
- data
- logica
In grotere apps wordt dat gescheiden.

Daarom maken we een service, deze:
- beheert data
- bevat logica
- wordt gebruikt door de UI
- Later zal deze service met Firebase praten.
- Maar in deze stap gebruiken we nog lokale data.

---
### 3.1 Open het service-bestand
Open:

```
lib/services/task_service.dart
```

Dit bestand hebben we in stap 1 al aangemaakt. Hier gaan we alle logica voor taken plaatsen.

---
### 3.2 Denk eerst na
In de huidige app kunnen we:
- taken bekijken
- taken afstrepen

Later willen we ook:
- taken toevoegen
- taken verwijderen
- taken afvinken
- taken aanpassen

> Welke functies zou een `TaskService` dus kunnen bevatten?

---
### 3.3 Maak de basis van de service
Maak eerst een klasse. Deze klasse gaat alle **task-logica** bevatten.

```dart 
class TaskService {

}
```

---
### 3.4 Waarom gebruiken we een service?
Als alle data **direct in de UI** wordt gelezen en aangepast, moet je bij elke verandering in de app op meerdere plekken code aanpassen. Door een **service** te gebruiken staat alle logica op één plek: `task_service.dart`.

De UI vraagt alleen **informatie op** of **roept functies aan** in de service. Hierdoor blijft de UI overzichtelijk en wordt de code makkelijker te onderhouden.

Als we later **Firebase** toevoegen, hoeven we alleen de code in de service aan te passen.

> Dit is een belangrijk principe in softwareontwikkeling: **Scheid de UI van de data-logica.**
> De UI zorgt voor **wat de gebruiker ziet**.
> De service zorgt voor **hoe de data wordt beheerd**.

---
### 3.5 Voeg een lijst met taken toe
Voor nu slaan we taken nog lokaal in memory op. Voeg dit toe aan de klasse:

```dart
class TaskService {
  final List<Task> _tasks = [
    Task(id: "1", title: "Boodschappen doen", done: false),
    Task(id: "2", title: "Huiswerk maken", done: true),
    Task(id: "3", title: "Flutter oefenen", done: false),
  ];
}
```

> `_tasks` begint met een underscore. In Dart betekent dit dat de variabele privé is en alleen in het bestand zelf mag worden gebruikt of aangepast.

> Vergeet niet de _juiste_ import toe te voegen! In welke map staat de klasse: `Task`?

---
### 3.6 Taken ophalen
De UI moet de lijst met taken kunnen ophalen.
Voeg de functie `getTasks` toe aan de klasse: `TaskService`:

```dart 
List<Task> getTasks() {
  return _tasks;
}
```

> Waarom is het veiliger om taken via een functie zoals `getTasks()` op te halen, in plaats van de lijst `_tasks` direct openbaar te maken?
>
> Antwoord:
> - Zo kan niet elke plek in de app de lijst zomaar aanpassen
> - De service blijft verantwoordelijk voor de data
> - Het maakt het makkelijker om later Firebase toe te voegen

---
### 3.7 Gebruik de service in de UI
Nu gaan we de `TaskService` gebruiken in de **UI**.

Open het bestand:

```
/lib/pages/task_home_page.dart
```

Importeer de `service`, `model` en `widget`:

```dart
import 'package:todo/services/task_service.dart';
import 'package:todo/models/task.dart' as model;
import 'package:todo/widgets/task.dart' as widget;
```

Vervang de oude `tasksJson` code:

```dart
  class _TaskHomePageState extends State<TaskHomePage> {
	  final List<Map<String, dynamic>> tasksJson = [
	    {'title': 'Boodschappen doen', 'done': false},
	    {'title': 'Huiswerk maken', 'done': true},
	    {'title': 'Flutter oefenen', 'done': false},
	  ];
	  ...
```

Met onze nieuwe `service` code:

```dart
class _TaskHomePageState extends State<TaskHomePage> {
  final taskService = TaskService();

  @override
  Widget build(BuildContext context) {
    List<model.Task> tasks = taskService.getTasks();  

    return Scaffold(
	    ...
```

> Het was niet zo handig om het model `Task` en de widget `Task` dezelfde naam te geven. Dit kun je oplossen door de `as ___` achter de import te plaatsen. Zie in het voorbeeld hierboven hoe we `model.Task` gebruiken i.p.v. `Task` zodat Flutter begrijpt dat we het niet over de `widget` hebben.

> Als je goed kijkt hebben we de naam van de variabele `tasksJson` verandert naar `tasks`. Fix de errors die daardoor worden veroorzaakt!

---
## ## 3.8 Controlepunt
Controleer of:
- Taken nog steeds worden weergegeven
- Taken kunnen worden afgevinkt

Als je vastloopt kun je hier je [code vergelijken]([https://github.com/markvanmeerten/todo/tree/tut-2-stap-2](https://github.com/markvanmeerten/todo/tree/tut-2-stap-3))

> De status van de taak verandert nog wel via de `widget` zelf. Die functie gaan we verplaatsen in de volgende stap!

---
### 3.8 Reflectie
Je bestand `task_service.dart` bevat nu:
- een class `TaskService`
- een lijst `_tasks`
- een functie `getTasks`

Waarom kan het handig zijn dat `TaskPage` niet direct met de data werkt, maar via `TaskService`?
- De code wordt overzichtelijker
- Logica staat op één plek
- De UI hoort niet te weten waar de data vandaan komt
- Het is makkelijker om later Firebase toe te voegen of een geheel andere database

Bekijk hier [[Stap 4 - Breid je TaskService uit (toggle)]]