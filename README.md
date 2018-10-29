# Todo App

This project is an example of implementation in Clean Swift architecture.

# Table of contents

* [Notes on implementation](#notes)
  * [General](#general)
  * [Architecture](#architecture)
  * [DI](#di)
  * [Tests](#tests)
  * [UI Tests](#uitests)

## Notes on implementation

### General

<a name="general"/>

Each screen should support use cases for creating, deleting and updating items in the list. 
For simplicity, List and Task modules are generally the same, but they fetch items differently and there are minor differencies in UI. On the one hand, there are DRY and YAGNI 😀, on the another hand for the production application it's easier to keep modules almost the same and do not write, for example, one module for all purposes. It's not fun to end up with tighly coupled one general component.

### Architecture

<a name="architecture"/>

Each screen is represented as a VIP module. Communication between components is done with protocols. 

![Clean architecture](https://cdn-images-1.medium.com/max/2000/1*QV4nxWPd_sbGhoWO-X7PfQ.png)

VIPER tends to transfer more responsibility to the Presenter. Depending on implementation in VIPER Presenter or Interactor can store view state. VIP allows ViewController to have more responsibility and at the same time, it loosens the coupling between components. 
There is a following idea in the VIP cycle. User produces a sequence of events. View handles it and asks interactor to start a business logic. Interactor holds Services (Storages, Providers, etc). When Interactor receives data from Service then it asks Presenter to map this data to the ViewModel and to present the update on the View. Then this cycle is repeated. ViewController can also ask router to present a screen.

In VIPER (depending on implementation) there is different flow. Presenter is listen for an view updates. 
If the Presenter receives the update then it decides what's do next. It can show another screen by using a router and it can ask an Interactor to fetch data. Finally, Presenter maps data from Interactor to ViewModel and then decides to ask Interactor, View or Router. View is totally passive. So, in VIPER the Presenter is kind of a major player.

### DI

<a name="di"/>

At that moment, there is no dependency injection framework. But I consider to add it as a feature improvement.
For each module, there is an Assembly which is supposed to manage dependencies.

### Tests

<a name="tests"/>

Each layer of the app is covered by unit tests. Currently, unit tests are implemented using XCTest.
Mock generation in Swift with Xcode is a pain, that's why I'm using an AppCode IDE which provides the nice open-source plugin for a mock generation.

### UI Tests

<a name="uitests"/>

There is a proof of concept of UI tests using the EarlGrey framework. 
The next improvement in term of UI tests is to add more test cases.
