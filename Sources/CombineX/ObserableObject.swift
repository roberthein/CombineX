// `ObservableObject` depends on property wrapper(`@Published`), which is only available since Swift 5.1.
#if swift(>=5.1)

/// A type of object with a publisher that emits before the object has changed.
///
/// By default an `ObservableObject` will synthesize an `objectWillChange`
/// publisher that emits before any of its `@Published` properties changes:
///
///     class Contact: ObservableObject {
///         @Published var name: String
///         @Published var age: Int
///
///         init(name: String, age: Int) {
///             self.name = name
///             self.age = age
///         }
///
///         func haveBirthday() -> Int {
///             age += 1
///             return age
///         }
///     }
///
///     let john = Contact(name: "John Appleseed", age: 24)
///     john.objectWillChange.sink { _ in print("\(john.age) will change") }
///     print(john.haveBirthday())
///     // Prints "24 will change"
///     // Prints "25"
///
public protocol ObservableObject: AnyObject {

    /// The type of publisher that emits before the object has changed.
    associatedtype ObjectWillChangePublisher: Publisher = ObservableObjectPublisher where ObjectWillChangePublisher.Failure == Never

    /// A publisher that emits before the object has changed.
    var objectWillChange: ObjectWillChangePublisher { get }
}

#if canImport(Runtime)
import Runtime

private protocol PublishedProtocol {
    var objectWillChange: ObservableObjectPublisher? { get set }
}
extension Published: PublishedProtocol {}

private let publishedPropertiesCache = TypeInfoCache<UnsafeRawPointer, [PropertyInfo]>()
private let globalObjectWillChangeCache = ObservableObjectPublisherCache<AnyObject, ObservableObjectPublisher>()
#endif

extension ObservableObject where ObjectWillChangePublisher == ObservableObjectPublisher {
    
    #if canImport(Runtime)
    private static func publishedProperties() throws -> [PropertyInfo] {
        let key = unsafeBitCast(self, to: UnsafeRawPointer.self)
        return try publishedPropertiesCache.value(for: key) {
            let info = try typeInfo(of: self)
            let props = info.properties.filter { $0.type is PublishedProtocol.Type }
            return props
        }
    }
    
    private func setObservableObjectPublisher(_ objectWillChange: ObservableObjectPublisher, for publishedProperty: PropertyInfo) throws {
        // TODO: mutate in place
        var published = try publishedProperty.get(from: self) as! PublishedProtocol
        published.objectWillChange = objectWillChange
        try withUnsafePointer(to: self) { ptr in
            let mptr = UnsafeMutablePointer(mutating: ptr)
            try publishedProperty.set(value: published, on: &(mptr.pointee))
        }
    }
    #endif
    
    public var objectWillChange: ObservableObjectPublisher {
        #if canImport(Runtime)
        return globalObjectWillChangeCache.value(for: self) {
            do {
                let publishedProperties = try type(of: self).publishedProperties()
                let pub = ObservableObjectPublisher()
                try publishedProperties.forEach { try setObservableObjectPublisher(pub, for: $0) }
                return pub
            } catch {
                fatalError(error.localizedDescription)
            }
        }
        #else
        Global.RequiresImplementation()
        #endif
    }
}

/// The default publisher of an `ObservableObject`.
public final class ObservableObjectPublisher: Publisher {
    
    public typealias Output = Void
    
    public typealias Failure = Never
    
    private let subject = PassthroughSubject<Output, Failure>()

    public init() {
        // Do nothing
    }

    public final func receive<S: Subscriber>(subscriber: S) where S.Failure == ObservableObjectPublisher.Failure, S.Input == ObservableObjectPublisher.Output {
        self.subject.receive(subscriber: subscriber)
    }

    public final func send() {
        self.subject.send()
    }
}

#endif
