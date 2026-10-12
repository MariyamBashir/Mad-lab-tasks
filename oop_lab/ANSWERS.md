# CS442 OOP Lab
Name: Maryam Bashir
Roll no: BCS-23-017

Q1. 
A subclass using extends gets the parent's fields and method bodies for free. A class using implements only gets the list of promises, so it must write every method itself.

Q2. 
I choose a mixin when unrelated classes (like Book and Dvd) need to share the same code. I choose an abstract parent when the classes are really of the same kind of thing and share a common base.

Q3. 
we must override hashcode when we overide == as equal objects must give the same hashCode. If they do not, sets and maps cannot find them correctly and treat equal objects as different.

Q4. 
dart lets us write the first one because as we kno that an extension only adds methods to the existing String type without creating a new type. A subclass would create a new type, and Dart does not allow extending String.