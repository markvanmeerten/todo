### Wat ga je leren in deze stap?
In grotere apps staat code niet in één groot bestand. Je leert hoe je een Flutter-project logisch opdeelt in meerdere bestanden en mappen.

Na deze stap:
- staat niet alles meer in **main.dart**
- is de structuur van de app duidelijker
- wordt het makkelijker om later Firebase toe te voegen

⚠️ In deze stap verandert het gedrag van de app nog niet. We verplaatsen alleen code.

---
### 1.1 Bekijk eerst je huidige project
Open je project in VS Code en ga naar:

``` 
lib
 └── main.dart
```

Momenteel staat alle code van de app in één bestand. Dat werkt voor kleine apps, maar wordt al snel onoverzichtelijk.

---
### 1.2 Welke onderdelen zitten in de app?
Bekijk `lib/main.dart` en probeer de volgende onderdelen aan te wijzen:
- De app zelf
- Het scherm met de lijst taken
- De widget die één taak weergeeft
- De data van een taak

Is het logisch dat alle code in hetzelfde bestand staat? Een volledige app als Thuisbezorgd zou dan een enorme main.dart bestand bevatten. Welke onderdelen zouden logisch in een eigen bestand kunnen staan?

---
### 1.3 Maak nieuwe mappen in lib
Open de map lib en maak de volgende mappen:
```lib 
├── models 
├── pages 
├── services 
└── widgets
```

| Map       | Bevat                                       |
| --------- | ------------------------------------------- |
| /models   | Data structuren                             |
| /pages    | Complete schermen van de app                |
| /widgets  | Kleine herbruikbare UI blokjes              |
| /services | Logica om data te bewaren / lezen / opslaan |

---
### 1.4 Maak de nieuwe bestanden
Maak nu de volgende bestanden aan.

In /models
```
lib/models/task.dart
```

In /pages
```
lib/pages/task_home_page.dart
```

In /services
```
lib/services/task_service.dart
```

In /widgets
```
lib/widgets/task.dart
lib/widgets/add_task_dialog.dart
```

---
### 1.5 Controleer of alles klopt
Je projectstructuur moet er nu zo uitzien:
```
/lib  
├── models  
	└── task.dart 
├── pages  
	└── task_home_page.dart 
├── services 
	└── task_service.dart 
└── widgets    
	├── add_task_dialog.dart
	└── task.dart    
└── main.dart
```

**Controleer:**
- staan alle bestanden in de juiste map?
- zijn de bestandsnamen exact hetzelfde?
- gebruik je snake_case (zoals `task_home_page.dart`)?

Flutter gebruikt de bestandsnamen voor imports. Een kleine fout kan later compile errors geven.

---
### 1.6 Verplaats de code naar de juiste files

Verplaats de code naar de juiste files.
Let er op dat je imports niet vergeet!

> De vorige tutorial was een beetje slordig en gebruikte de termen `task` en `todo` door elkaar. Dat is natuurlijk niet zo netjes, refactor alles waar todo staat met task.

---

### 1.7 Controlepunt
Controleer of je app nog werkt met het command:
```
flutter run
```

Als je vastloopt kun je hier je [code vergelijken](https://github.com/markvanmeerten/todo/tree/tut-2-stap-1/lib)

---
### 1.6 Reflectie
**Reflectievraag:** Waarom is het handig om code te verdelen over meerdere bestanden? Noem minstens twee voordelen.

Bekijk hier [[Stap 2 – Van Map naar een Task model]]