# money_box

Used achitecture is MVVM. It was selected because it require not a lot of time to implement, but it make all code more testable. Unit tests can be written later, but it is easy to cover ViewController and ViewModel by tests if MVVM architecture is selected, and all functionality does not depends on each other.

Dependencies: Dependencies were added with SPM(Swift Package Manager). It helps easier to manage added dependencies and it is easier to understand what happens when you debugging your code.

Fetch - Hides the boilerplate code. Fetch allows you to make protocol-based HTTP requests, whilst providing a custom class or struct capable of parsing the response in to model objects your app can understand. Source: https://github.com/dhardiman/Fetch

Bond - is a Swift binding framework that takes binding concepts to a whole new level. It’s simple, powerful, type-safe and multi-paradigm - just like Swift. Source: https://github.com/DeclarativeHub/Bond

Hopoate -  is a lightweight dependency injection framework for iOS, allowing for simple registration and resolution of application dependencies.

Router - is a set of protocols that can be used to describe navigational architecture for an iOS app.

How to launch:
Install and launch latest Xcode (version 13.2.1)
Clone an existing project using repository url (https://github.com/NickRudenko/money_box)
Build and run app.
