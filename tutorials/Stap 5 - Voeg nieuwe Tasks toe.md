### Wat ga je leren in deze stap?
In deze stap leer je:
- hoe je een taak toevoegt via `TaskService`
- hoe je een **FloatingActionButton** gebruikt
- hoe je een **dialoogvenster** opent
- hoe je tekst invoert met een `TextField`
- hoe je een nieuwe taak toevoegt aan de lijst

---
### 5.1 Service controleren
Open de Service:

```
lib/services/task_service.dart
```

Controleer of je service al heeft:
- `_tasks`
- `getTasks()`
- `toggleTask()`

In deze stap gaan we daar een nieuwe functie aan toevoegen: `addTask()`.

---
### 5.2 Een taak toevoegen
De app moet ook taken kunnen toevoegen.
Voeg daarom de functie `"AddTask"` toe aan de klasse: `TaskService`.

Probeer eerst zelf te bedenken:
> Wat moet deze functie doen?

Controleer of jouw functie vergelijkbare code bevat:

```dart
import '../models/task.dart'; 

...

void addTask(String title) {
  _tasks.add(
    Task(
      id: DateTime.now().toString(),
      title: title,
      done: false,
    ),
  );
}
```

---
### 5.3 Voeg een `FloatingActionButton` toe
Open:

```
lib/pages/task_home_page.dart
```

Voeg in je `Scaffold` toe:

```dart
floatingActionButton: FloatingActionButton(
	onPressed: () {
		print("Nieuwe taak toevoegen");
	},
	child: const Icon(Icons.add),
),
```

---
### 5.4 Wat is een `AlertDialog`?
Wanneer de gebruiker op de **+ knop** klikt, willen we een klein venster openen waarin hij een nieuwe taak kan invoeren. Zo’n venster noemen we een **dialoogvenster** (dialog).

Een dialog verschijnt **bovenop de huidige pagina**, om bijvoorbeeld:
- een actie te bevestigen
- een waarschuwing tonen
- een formulier laten invullen

Flutter heeft een standaard widget voor dialogen:

```dart
AlertDialog
```

Een `AlertDialog` is een klein venster met meestal:
- een **titel**
- **inhoud**
- **knoppen**

Flutter opent een dialog met de functie:

```dart
showDialog()
```

---
### 5.5 Open het dialoogvenster
Vervang je `FloatingActionButton onPressed` event met de volgende code:

```dart
onPressed: () {  
	showDialog(  
		context: context,  
		builder: (context) {  
			return AlertDialog(
				title: Text("Nieuwe taak"),
				content: TextField(
					decoration: InputDecoration(
						hintText: "Type een nieuwe taak",
					),
				),
			); 
		},  
	);  
}
```

Run de app en klik op de **+ knop**. Zie je een dialog verschijnen met de titel **Nieuwe taak**?
Je zou ook een `TextField` moeten zien met de placeholder tekst: **Type een nieuwe taak**.

---
### 5.6 Voeg een `TextEditingController` toe
Op dit moment kan de gebruiker tekst typen in het `TextField`, maar onze app **weet nog niet wat er getypt is**. We moeten de tekst dus ergens opslaan. In Flutter doen we dat met een **TextEditingController**.

Een `TextEditingController` is een object dat:
- de tekst van een `TextField` bijhoudt
- ons laat **uitlezen wat de gebruiker heeft getypt**

Voeg bovenin je widget toe:

```dart
final controller = TextEditingController();
```

Deze controller houdt de tekst bij van het invoerveld.

---
### 5.7 Koppel de `TextFieldController` aan de `TextField`
Pas je `TextField` aan zodat deze de controller gebruikt die we net hebben aangemaakt:

```dart
TextField(
	controller: controller,
	decoration: InputDecoration(
		hintText: "Typ een nieuwe taak",
	),
)
```

Nu gebeurt het volgende:
- de gebruiker typt tekst
- de controller bewaart die tekst
- wij kunnen die tekst later uitlezen met: `controller.text`

⚠️ Let op: Het kan zijn dat je een error krijgt dat `controller null` is. Run dan het command `flutter run -d chrome` opnieuw.

---
### 5.8 Knoppen toevoegen aan de dialoog
De dialoog heeft nog de volgende knoppen nodig:
- **Annuleren**
- **Toevoegen**

Voeg deze in de `AlertDialog` als lijst van `actions` toe:

```dart
actions: [
	TextButton(
		onPressed: () {
			Navigator.pop(context);
		},
		child: Text("Annuleren"),
	),
	ElevatedButton(
		onPressed: () {
			print(controller.text);
			Navigator.pop(context);
		},
		child: Text("Toevoegen"),
	),
]
```

Wat gebeurt hier?
- `controller.text` leest de tekst uit het invoerveld en print deze in de console (om te testen).
- `Navigator.pop(context)` sluit de dialog. De dialog is namelijk bovenop de huidige pagina geplaatst. Met `Navigator.pop()` halen we hem weer weg.

---
### 5.9 Gebruik de `TaskService` en update de `State`
Kun je nu zelf deze stap afmaken?

De knop `Toevoegen` moet 3 dingen doen:
1. de tekst uit de controller lezen (`controller.text`)
2. `addTask()` aanroepen in de `TaskService`
3. `setState()` gebruiken zodat de UI opnieuw wordt opgebouwd

Je kunt je oplossing verder verbeteren door:
- `controller.clear();` te gebruiken zodat het `TextField` leeg is na het toevoegen
- `autofocus: true` toe te voegen aan het `TextField`
- te controleren of het `TextField` niet leeg is voordat je een taak toevoegt met (`controller.text.isEmpty`)

### **Extra uitdaging (refactor)**
Deze stap is al vrij uitgebreid. Om het simpel te houden plaatsen we alle code in `task_home_page.dart`, maar eigenlijk hoort deze natuurlijk in `add_task_dialog.dart` thuis. De dialog kan dan een waarde teruggeven aan de pagina met:

```dart
Navigator.pop(context, controller.text);
```

Daarvoor moet je `showDialog()` wel gebruiken met `async/await`. Dat leggen we hier niet uit, maar een voorbeeld van deze aanpak kun je [hier](https://github.com/markvanmeerten/todo/blob/tut-2-stap-5/lib/pages/task_home_page.dart) bekijken.

---
### 5.10 Controlepunt
Controleer of:
- de **+ knop** zichtbaar is
- de dialog opent
- je tekst kunt typen
- de **Toevoegen** knop werkt
- de nieuwe taak in de lijst verschijnt

Als je vastloopt kun je hier je [code vergelijken](https://github.com/markvanmeerten/todo/tree/tut-2-stap-5/lib)

---
### 5.11 Reflectie
>**Reflectievraag:** Waarom is het beter dat de pagina alleen `taskService.addTask()` aanroept, in plaats van zelf een nieuwe `Task` te maken?

Bekijk hier: [[Stap 6 - Service koppelen aan de Firestore]]