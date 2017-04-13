# Pass-Code-Entry-View-Controller

![Alt text](https://media.giphy.com/media/BgNuBNJBnna48/giphy.gif)

A simple numeric pass code interface

- A view controller with a pin pad.
- Pin code length can be set.
- The pin code will be validated.

To add this to your project you will need the 3 files in the "Pin Entry View Controller" group;
- JSDPinEntryViewController.h
- JSDPinEntryViewController.m
- JSDPinEntryViewController..xib

A single delegate method reports when the view is dismissed or the correct code is entered.

The code length is set to only 4 digits. If you want more digits change the pinMaxLength variable in JSDPinEntryViewController.m.

The passcode is set to 1234 at the moment, but it can be easily changed. Take a look in getPin: in JSDPinEntryViewController.m. A method is used as you might want to fetch a code from a server or elsewhere in your app.
