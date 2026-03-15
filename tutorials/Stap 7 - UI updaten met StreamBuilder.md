### Wat ga je leren in deze stap?
In deze stap ga je:
- leren wat een `Stream<List<Task>>` is
- `StreamBuilder` gebruiken in de UI
- taken live uit `Firestore` tonen
- taken afvinken en direct in de UI zien veranderen

Na deze stap haalt je app de taken niet meer uit een lokale lijst, maar rechtstreeks uit `Firestore`.

---
### 7.1 Wat is er veranderd sinds stap 6?
In stap 6 heb je je `TaskService` aangepast.
Eerst gaf `getTasks()` waarschijnlijk dit terug:

```dart
List<Task> getTasks()
```

Een `List<Task>` is:
- één lijst
- op één moment

Maar nu krijgen we de `List` in een `Stream` terug:

```dart
Stream<List<Task>> getTasks()
```

Een `Stream<List<Task>>` is:
- een stroom van data
- die opnieuw kan veranderen
- bijvoorbeeld als er iets in `Firestore` verandert

---
### 7.2 Waarom werkt je oude UI nu niet meer?
We gebruikten eerst:

```dart
_tasks = taskService.getTasks();
```

Dat werkte, omdat `getTasks()` een gewone lijst terug gaf, maar nu krijgen we een `Steam` terug.
Daarom hebben we een widget nodig die naar een stream kan luisteren. Die widget heet `StreamBuilder`.

Een `StreamBuilder` luistert naar een stream.
Elke keer dat de stream nieuwe data geeft:
- krijgt de widget die data
- en bouwt Flutter de UI opnieuw op

Als de `Firestore` data verandert, moet onze lijst automatisch mee veranderen.

---
### 7.3 Vervang de `List` met `Stream`
Open:

```
lib/pages/task_home_page.dart
```

Verwijder de volgende regel code (die zal rood onderstreept zijn):

```dart
List<model.Task> tasks = taskService.getTasks();
```

Vervang je huidige `body` door deze code:

```dart
body: StreamBuilder<List<model.Task>>(
	stream: taskService.getTasks(),
	builder: (context, snapshot) {
		if (snapshot.connectionState == ConnectionState.waiting) {
			return const Center(
				child: CircularProgressIndicator(),
			);
		}
		
		if (snapshot.hasError) {
			return Center(
				child: Text('Er ging iets mis: ${snapshot.error}'),
			);
		}
		
		final tasks = snapshot.data ?? [];
		
		if (tasks.isEmpty) {
			return const Center(
				child: Text('Nog geen taken'),
			);
		}
		
		return ListView.builder(
			itemCount: tasks.length,
			itemBuilder: (context, index) {
				final task = tasks[index];
				
				return Padding(
					padding: const EdgeInsets.all(8.0),
					child: widget.Task(
						task: task,
						onChanged: () async {
							await taskService.toggleTask(task);
						},
					),
				);
			},
		);
	},
),
```

---
### 7.6 Lees de code rustig
We bekijken deze code in kleine stukjes.
#### Deel 1 – luisteren naar de stream
```dart
stream: taskService.getTasks(),
```

Hier zeg je:
> Luister naar de taken uit `Firestore`.

Elke keer dat `Firestore` verandert, krijgt de UI nieuwe data.

---
#### Deel 2 – `snapshot`
```dart
builder: (context, snapshot)
```

`snapshot` bevat de huidige stand van de stream.

Daarin kan zitten:
- nog geen data
- een fout
- een lijst met taken

---
#### Deel 3 – laadicoon tonen
```dart
if (snapshot.connectionState == ConnectionState.waiting)
```

Dit betekent:
> We wachten nog op data uit `Firestore`.

Zolang dat zo is, tonen we een laadicoon.

---
#### Deel 4 – foutmelding tonen
```dart
if (snapshot.hasError)
```

Als er iets misgaat met `Firestore`, tonen we een foutmelding. Dat is beter dan een leeg scherm.

---
#### Deel 5 – taken ophalen
```dart
final tasks = snapshot.data ?? [];
```

Hier halen we de taken uit de stream.
Als er nog geen data is, gebruiken we een lege lijst.

---
#### Deel 6 – lege lijst tonen
```dart
if (tasks.isEmpty)
```

Als er nog geen taken zijn, tonen we de boodschap: `Nog geen taken`.

---
### 7.7 Waarom gebruiken we hier geen `setState()` meer?
In de vorige stappen gebruikten we vaak:
```dart
setState(() {
...
});
```

Maar nu is dat niet meer nodig voor de lijst, omdat `Firestore` zelf al nieuwe data doorstuurt via de stream. De flow is nu:

```
Firestore verandert
↓
stream geeft nieuwe data
↓
StreamBuilder bouwt opnieuw
↓
UI verandert automatisch
```

---
### 7.8 Pas ook je `Toevoegen` knop aan
In stap 5 gebruikte je misschien nog:

```dart
onPressed: () {
	// ...
	
	setState(() {
		taskService.addTask(controller.text);
	});
	
	// ...
}
```

Pas dat aan naar:

```dart
onPressed: () async {
	// ...
	
	await taskService.addTask(controller.text);
	
	// ...
},
```

Waarom werkt dat? Omdat:
- `addTask()` iets toevoegt in `Firestore`.
- `Firestore` de stream automatisch vernieuwt.
- `StreamBuilder` de UI vanzelf opnieuw opbouwt.

---
### 7.9 Controlepunt
Controleer of:
- de app start zonder fouten
- bestaande taken uit `Firestore` zichtbaar zijn
- een nieuwe taak direct in de lijst verschijnt
- een taak afvinken meteen zichtbaar is

Als je vastloopt kun je hier je [code vergelijken](https://github.com/markvanmeerten/todo/tree/tut-2-stap-7/lib)

---
### 7.10 Reflectie
>**Reflectievraag:** Wat wil je nog meer leren bouwen met Flutter?

Bekijk hier: [[Stap 8 - Afronden]]