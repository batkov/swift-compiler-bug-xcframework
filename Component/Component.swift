import Foundation

public protocol Component {

    func makeItWork(with tag: ComponentTag)

}

public protocol ComponentTag {

    func text() -> String

}
