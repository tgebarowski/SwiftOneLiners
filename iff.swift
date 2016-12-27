//
// iff.swift
//
// If and only if operator <->, trying to replicate Ruby postifx if.
//
// Tomasz Gebarowski <gebarowski@gmail.com>
//
// Example:
//
// func register() { print("Registered") }
// func subscribe() { print("Subscribed") }
//
// var shouldRegister = true
// var shouldSubscribe = true
//
// register() <-> shouldRegister
// subscribe() <-> shouldSubscribe
//

infix operator <->

func <-> (closure: @autoclosure ()-> Void, condition: Bool) {
    condition ? closure() : ()
}

