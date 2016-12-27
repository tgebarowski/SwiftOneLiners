# SwiftOneLiners
A collection of helpers and useful one-liners in Swift.

## iff.swift 

If and only if operator <->, trying to replicate Ruby postifx if.
Working only with functions having () -> Void signature.

Example:

```swift
func register() { print("Registered") }
func subscribe() { print("Subscribed") }
func invite() { print("Invited") }

var shouldRegister = true
var shouldSubscribe = true
var shouldInvite = true

register() <-> shouldRegister
subscribe() <-> shouldSubscribe
invite() <-> shouldInvite
```

instead of:

```swift
if shouldRegister {
	register()
}
if shouldSubscribe {
	subscribe()
}
if shouldInvite {
	invite()
}
```
