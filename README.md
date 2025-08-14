<div align="center">
  <h1>🏈 Fantasy Football Simulator 🎮</h1>
  <p>A comprehensive football management and simulation system.</p>
</div>

---

## 📚 Project Background & Requirements

This project was developed as part of the **OOP Project in the GSG Coding to Career Course**.

### 📝 Project: Football Game Simulator – Project 1

**"Design the Game. Code Your Imagination!"**

#### 🎯 Objective
Build a console-based football game simulator in Dart to master Object-Oriented Programming (OOP) by modeling a football match, designing custom classes and actors, and using game theory to simulate strategic competition. Creativity is encouraged—add features, actors, or rules as you wish!

#### 📋 Main Requirements

1. **Core Classes (Actors):**
   - **Player:** name, position, id, power (random), plus extra properties (age, nationality, stamina, skills, jersey number, etc.)
   - **Trainer:** name, experience (random), plus extra properties (strategy specialty, motivation, etc.)
   - **Team:** team name, trainer, list of players, plus extra properties (mascot, city, colors, motto, etc.)
   - **Stadium:** name, location, plus extra properties (capacity, weather, altitude, turf type, etc.)
   - **Game:** manages team creation, stadium setup, simulation logic, and match outcome. Includes helper classes and match events.
   - **Other Actor(s):** At least one invented actor/system (e.g., referee, fans, weather system, match event, commentator, media, etc.) integrated into the simulation.

2. **Strategic Decision-Making (Game Theory):**
   - Trainers choose strategies (Offensive, Defensive, Balanced, etc.).
   - Strategies interact via a payoff matrix, affecting team effectiveness.
   - Custom matrix designed and balanced for fairness.

3. **Team & Player Creation:**
   - Input for team name, trainer, strategy, number of players, and all properties.

4. **Stadium Creation:**
   - Input for stadium name, location, and extra properties.

5. **Invented Actor/System/Feature:**
   - At least one new actor/system/feature, with input and integration into the simulation.

6. **Game Simulation:**
   - Calculate team power: sum of player powers + trainer power + strategy bonus + random factor + bonuses from innovations.
   - Print all teams, strategies, powers, stadium info, match events, and winner.
   - Creative outputs: commentary, goals, cards, injuries, etc.

7. **Creativity:**
   - Unlimited extra properties, actors, rules, or features.
   - Description of new actors/systems/logic at the top of the code.

#### ✅ Submission Checklist
- Dart code file (.dart) with all classes and properties (required + extras).
- At least one invented actor/system/feature, described at the top.
- User input for all properties and game decisions (including strategy selection).
- Console output showing all teams, strategies, actors, events, and the winner.
- Sample output included as a comment.
- Bonus: creative features or innovations for extra credit!

#### 🏆 Evaluation Criteria
- OOP design: clear classes, relationships, encapsulation, extensibility.
- Game theory: strategic choices and a working payoff matrix.
- Input/output: interactive and complete.
- Simulation logic: creativity and fairness.
- Integration: use of invented actor/system and open features.
- Code readability and comments.

> If you do not fully understand any part of the requirements or have difficulty implementing a specific instruction, you may create your own mini-project idea instead, following OOP principles and demonstrating creativity in class design and output.

---

## 🏗️ Technologies & Architecture Used

- **Dart Language**
- **Object-Oriented Programming (OOP)**
- **Clean Architecture**
  - Separation of concerns into domain, data, and presentation layers
  - Clear boundaries between business logic, data access, and user interface
- **Domain-Driven Design (DDD)**
- **Repository Pattern**
- **Event-Driven Simulation**
- **Interactive CLI (Command-Line Interface)**

---

## ✨ Features

- ⚽ **Simulate Matches:** Quick and live match simulation with detailed event logs.
- 👥 **Team Management:** Create, edit, and manage teams with custom strategies and formations.
- 👟 **Player Management:** Add, edit, and search for players by name, nationality, or position.
- 👔 **Trainer Management:** Assign trainers to teams and manage their profiles.
- 🏟️ **Stadium Management:** Create and manage stadiums with different capacities and locations.
- 🧑‍⚖️ **Referee Management:** Add referees and assign them to matches.
- 🗺️ **Formation & Strategy:** Customize team formations and strategies for each match.
- 📊 **Statistics Dashboard:** View detailed match statistics, goals, substitutions, and event timelines.
- 🎨 **Interactive CLI:** Colorful and user-friendly command-line interface with icons and diagrams.

## 🛠️ Approaches & Techniques Used

- **Domain-Driven Design (DDD):**
  - Separation of entities, enums, repositories, and use cases for clear architecture.
- **Repository Pattern:**
  - Abstracts data access and CRUD operations for all entities.
- **Use Case Driven:**
  - Business logic is encapsulated in use case classes for maintainability and testability.
- **Modular UI:**
  - Presentation layer divided by entity and feature for easy extension.
- **CLI UX Enhancements:**
  - Use of colors, emojis, and diagrams for better user experience.
- **Random Generation:**
  - Automatic creation of teams, players, and match events for simulation.
- **Event-Driven Simulation:**
  - Match events and statistics are generated and tracked minute-by-minute.

## 📁 Project Structure

```
main.dart
domain/
  entities/         # Core entities (Team, Player, Trainer, etc.)
  enums/            # Enums (Positions, Cities, Colors, etc.)
  repositories/     # Repository interfaces
  usecases/         # Business logic use cases
data/
  repositories/     # Repository implementations (CRUD)
presentation/
  io/               # Input/Output (CLI)
  ui/               # UI for each entity
  utils/            # Utilities (messages, printing, etc.)
```

## 📦 Requirements

- [Dart SDK](https://dart.dev/get-dart)
- Command-line environment (Windows, Linux, macOS)

## 🚀 How to Run

1. Make sure Dart SDK is installed.
2. Open terminal in the project folder.
3. Run:

```sh
dart run main.dart
```

---

## 🖥️ Sample Output

```
===================================

🏈 Welcome to Fantasy Football Sim! 🎮

===================================
01. ⚽ Simulate Match
02. 👥 Team Management
03. 👟 Player Management
04. 🗺️ Formation and Strategy Management
05. 👔 Trainer Management
06. 🏟️ Stadium Management
07. 🧑‍⚖️ Manage Referees
08. 🚪 Exit

👉 Enter your choice (1 to 8): 1

✨ You selected: ⚽ Simulate Match
======================
  ⚽ Match Simulation  
======================
01. 🏟️ Start New Match
02. ⚡ Quick Match
03. 🚪 Exit
Enter your choice (1-3): 2
===================================
  ⚡ Quick Match - Fully Automatic  
===================================
Returning all 0 teams
⛔ No teams available. Creating random teams...
Team "Al Rifai" saved successfully (with 0 shared players)
✅ Team "Al Rifai" created successfully!
   👨‍🏫 Trainer: robertoMartinez
   ⚽ Players: 11 (7 on bench)
   🎯 Strategy: balanced
   🧩 Formation: 4-4-2
Warning: 2 players already in other teams:
- Jérémie Frimpong
- Luis Suárez
Team "Al Erbil" saved successfully (with 2 shared players)
✅ Team "Al Erbil" created successfully!
   👨‍🏫 Trainer: scolari
   ⚽ Players: 11 (7 on bench)
   🎯 Strategy: defensive
   🧩 Formation: 3-4-3
===================================
  ⚡ Quick Match - Fully Automatic  
===================================
Returning all 2 teams
🏟️ Random Stadium: Sunrise Park (Capacity: 75673)
🧑‍⚖️ Random Referee: Rami (Exp: 19 yrs)
✅ Automatic Match Setup:
🏠 Home: Al Rifai
🛫 Away: Al Erbil
🏟️ Stadium: Sunrise Park
🧑‍⚖️ Referee: Rami
🌤️ Weather: misty

📋 MATCH SETUP
🏠 Home Team: Al Rifai
   Trainer: robertoMartinez
   Strategy: balanced
   Formation: 4-4-2
   Total Power: 803.50

✈️  Away Team: Al Erbil
   Trainer: scolari
   Strategy: defensive
   Formation: 3-4-3
   Total Power: 806.50

🏟️  Stadium: Sunrise Park
   Location: Nairobi
   Capacity: 75673
   Weather: partlyCloudy

👨‍⚖️  Referee: Rami
   Experience: 19 years
   Strictness: 29%
====================
  🎮 Match Options  
====================
01. ⚡ Quick Simulation
02. ⏱️ Live Simulation
03. 🚪 Cancel
Select simulation type (1-3): 1
🎮 MATCH STARTING
Al Rifai vs Al Erbil
🏟️  Sunrise Park
👨‍⚖️  Referee: Rami
🌦  Weather: misty
==================================================
📋 LINEUPS
- Al Rifai (4-4-2)
   • Emile Smith Rowe (CB)
   • Nawaf Al-Abed (LAM)
   • Robert Gumny (RWB)
   • Matt Turner (LM)
   • Sergio Agüero (LWB)
   • Jérémie Frimpong (GK)
   • Arkadiusz Milik (RM)
   • Davy Klaassen (LB)
   • Erling Haaland (CB)
   • Karim Benzema (LM)
   • Luis Suárez (CM)
   Bench:
     - Sergej Milinković-Savić (LB)
     - Marcus Rashford (LB)
     - Nabil Fekir (LAM)
     - Kalidou Koulibaly (RB)
     - Rodri Hernández (RB)
     - Pablo Gavi (LAM)
     - Leandro Trossard (LWB)
- Al Erbil (3-4-3)
   • Enzo Fernández (RW)
   • Héctor Bellerín (CM)
   • David Alaba (LB)
   • Ferjani Sassi (RW)
   • Rodri Hernández (LWB)
   • Enzo Fernández (GK)
   • Youssef En-Nesyri (RM)
   • Firas Al-Buraikan (ST)
   • Ryan Gravenberch (CDM)
   • Federico Valverde (LW)
   • Emile Smith Rowe (RWB)
   Bench:
     - Nemanja Maksimović (LAM)
     - Frenkie de Jong (RB)
     - Saad Bguir (RWB)
     - Sofiane Boufal (RWB)
     - Nemanja Radonjić (RB)
     - Eddie Nketiah (RWB)
     - Teun Koopmeiners (LM)
==================================================
⚽ GOAL! Al Rifai scores! (Sergio Agüero)
...
🏆 Al Rifai 5 - 7 Al Erbil
🏟️  Stadium: Sunrise Park
👨‍⚖️  Referee: Rami
🌦  Weather: misty
📊 Total Events: 141
⚽ Goals: 12
🟨🟥 Cards: 6
🏆 Winner: Al Erbil

🎉 The match has ended! 🎉
Would you like to view detailed match statistics?
1. Yes - Show detailed statistics
2. No - Return to main menu
Enter your choice (1-2): 1

📊 DETAILED MATCH STATISTICS
============================================================
🔢 Score: Al Rifai 5 - 7 Al Erbil

📊 Possession: Al Rifai 54.6% | Al Erbil 45.4%
🎯 Shots: Al Rifai 23 | Al Erbil 22
🎯 Shots on Target: Al Rifai 12 | Al Erbil 7
🚫 Fouls: Al Rifai 14 | Al Erbil 9
📐 Corners: Al Rifai 7 | Al Erbil 5
🚩 Offsides: Al Rifai 2 | Al Erbil 4
🧤 Saves: Al Rifai 3 | Al Erbil 1
🟨 Yellow Cards: Al Rifai 4 | Al Erbil 2
🟥 Red Cards: Al Rifai 0 | Al Erbil 0
============================================================
```

---

## 🤝 Contribution

- Open an Issue or Pull Request on [GitHub](https://github.com/mohammedyashour).
- Suggest new features, bug fixes, or performance improvements.

## 📬 Contact

- Email: medo.ash.2019@gmail.com
- GitHub: [mohammedyashour](https://github.com/mohammedyashour)

---

🎓 Educational project for football management simulation. All rights reserved.
