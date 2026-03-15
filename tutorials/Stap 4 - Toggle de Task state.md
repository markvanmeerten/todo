### Wat ga je leren in deze stap?
In de vorige stap heb je een **service** gemaakt om de UI en de data-logica van elkaar te scheiden.
Dat is een belangrijk principe in softwareontwikkeling.

In deze stap gaan we iets nieuws leren: **immutability**. Dit is een belangrijk concept in veel moderne component libraries zoals **Flutter, React, etc.**

Het idee is simpel:
> In plaats van een `object` aan te passen, maak je een **nieuwe versie van het object**.

Frameworks kunnen daardoor **sneller zien dat er iets veranderd is** en weten dan dat de UI opnieuw moet worden opgebouwd.

---
### 4.1 Een taak togglen
De app moet ook taken kunnen afronden of opnieuw openen.
Voeg daarom de functie `"toggleTask"` toe aan de klasse: `TaskService`.

Probeer eerst zelf te bedenken:
> Wat moet deze functie doen?

Controleer of jouw functie vergelijkbare code bevat:
```dart
void toggleTask(Task task) {
	final index = _tasks.indexOf(task);
	
	_tasks[index] = Task(
		id: task.id,
		title: task.title,
		done: !task.done,
	);
}
```

Misschien zou je dit willen doen:

```dart
void toggleTask(Task task) {
	final index = _tasks.indexOf(task);
	
	_tasks[index].done = !task.done,
}
```

Maar dat mag dus niet. In plaats daarvan vervangen we het oude object in de lijst met een geheel nieuw `Task` object.

Door een nieuw `Task` object te maken in plaats van het oude aan te passen kan Flutter makkelijker zien dat er iets veranderd is. Dat concept noemen we `immutable data` en veel moderne libraries/frameworks vereisen nou eenmaal dat je zo werkt.

**Immutability** betekent:
> Een object verandert niet meer nadat het is gemaakt.

Dus als iets anders moet worden:
- verander je niet het oude object
- maar maak je een nieuwe versie

Immutability heeft voordelen:
- meerdere Widgets gebruiken altijd dezelfde consistente data
- state management libraries kunnen makkelijker zien dat data veranderd is
- bugs door gedeelde mutable state worden voorkomen

---
### 4.2 Koppel de toggle-functie aan de UI
Ga naar:

```
lib/pages/task_home_page.dart
```

Zoek waar je de `Task` widget gebruikt en zorg dat bij het veranderen van de checkbox niet de widget zelf de state bewaart, maar dat de pagina de service aanroept.

Bijvoorbeeld:
```dart
onChanged: () {
	setState(() {
		taskService.toggleTask(task);
	});
}
```

Hiermee verplaats je de logica uit de widget naar de service.

---
### 4.3 Controlepunt
Controleer of:
- `toggleTask()` in `TaskService` staat
- je een **nieuw `Task` object** maakt
- de checkbox nog steeds werkt
- de UI via `setState()` opnieuw wordt opgebouwd

Als je vastloopt kun je hier je [code vergelijken](https://github.com/markvanmeerten/todo/tree/tut-2-stap-4/lib)

---
### 4.4 Reflectie
>**Reflectievraag:** Waarom is het handig om code te verdelen over meerdere bestanden? Noem minstens twee voordelen.

Bekijk hier [[Stap 5 - Voeg nieuwe Tasks toe]]