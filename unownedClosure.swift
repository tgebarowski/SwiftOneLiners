func unownedClosure<T: AnyObject, A: Any>(_ obj: T, _ method: @escaping (T) -> (Void) -> A) -> (Void) -> A {
    return { [unowned obj] in
        method(obj)()
    }
}

func unownedClosure<T: AnyObject, A: Any, B: Any>(_ obj: T, _ method: @escaping (T) -> (A) -> B) -> (A) -> B {
    return { [unowned obj] arg in
        method(obj)(arg)
    }
}

func unownedClosure<T: AnyObject, A: Any, B: Any, C: Any>(_ obj: T, _ method: @escaping (T) -> (A, B) -> C) -> (A, B) -> C {
    return { [unowned obj] arg1, arg2 in
        method(obj)(arg1, arg2)
    }
}