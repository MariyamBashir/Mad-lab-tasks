Name: Maryam Bashir
Roll no: 04072313017

A1: 24
A2: 8
A3: 3
A4: 50

B1: 
Stateless widgets: LabApp, HomePage, SettingsCard, SummaryRow, Probe, Welcome, InfoPanel, ShareRow, InfoBox and StampStack. They only show data and do not change by themselves. 
Stateful widgets: Clock, Tile and SwapBoard. They need a State object because their values change over time (the clock seconds, the tap count, and the order of the tiles).

B2: 
The Widget is rebuilt on every setState. The Element and the RenderObject are kept. In Probe, the Widget number is changed every second, but the Element number stayed the same. This showed that Flutter creates a new Widget each time but reuses the same Element, and the Element is what holds the State.

B3: 
"Constraints go down, sizes go up" means a parent gives its child a size limit, and the child chooses its own size inside that limit and reports it back to the parent. In Step 7, the Row gave each Expanded a fixed width limit. The Text inside wrapped its words to fit that width and then reported its own height back up to the Row.