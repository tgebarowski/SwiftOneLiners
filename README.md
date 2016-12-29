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

## unownedClosure.swift

Convenient wrapper to weakify functions passed as arguments as escaping closures.

Example:

```swift

class RequestSender {
    
    func sendRequest(success: @escaping () -> Void) {
        DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + 0.5) {
            success()
        }
    }
}

class Dispatcher {
    
    private let requestSender = RequestSender()
    private let dispatchGroup = DispatchGroup()
    
    deinit {
        print("Deinitialized")
    }
    
    func start() {
        dispatchGroup.enter()
        requestSender.sendRequest(success: handleResponse)
    }
    
    func wait() {
        dispatchGroup.wait(timeout: .now() + .seconds(1))
    }
    
    private func handleResponse() {
        print("Response handled")
        dispatchGroup.leave()
    }
}

let dispatcher = Dispatcher()
dispatcher.start()
dispatcher.wait()
```
The problem with the above code is that sendRequest returns its result using escaping closure from a background queue.
Passing a private handleResponse() function as a closure argument creates a retain cycle, hence deinit is never called on Dispatcher object.

The problem could be easily solved by wrapping either:

- inlineing handleResponse content withing the closure where self is weak/unowned

```swift
requestSender.sendRequest(success: { [unowned self] in
	print("Response handled")
    self.dispatchGroup.leave()
})
```

- wrapping handleResponse with another closure where self is weak/unowned

```swift
requestSender.sendRequest(success: { [unowned self] in
	self.handleResponse()
})
```

The above code looks ugly and is less compact. That's why I prepared some helper functions allowing to simplify this construction:

```swift
requestSender.sendRequest(success: unownedClosure(self, Dispatcher.handleResponse))
```

Not perfect, but definitely something that could be improved in new version of Swift.




