extension Fail: Equatable where Failure: Equatable {
    
    public static func == (lhs: Fail<Output, Failure>, rhs: Fail<Output, Failure>) -> Bool {
        return lhs.error == rhs.error
    }
}

/// A publisher that immediately terminates with the specified error.
public struct Fail<Output, Failure: Error>: Publisher {
    
    /// Creates a publisher that immediately terminates with the specified failure.
    ///
    /// - Parameter error: The failure to send when terminating the publisher.
    public init(error: Failure) {
        self.error = error
    }
    
    /// Creates publisher with the given output type, that immediately terminates with the specified failure.
    ///
    /// Use this initializer to create a `Fail` publisher that can work with subscribers or publishers that expect a given output type.
    /// - Parameters:
    ///   - outputType: The output type exposed by this publisher.
    ///   - failure: The failure to send when terminating the publisher.
    public init(outputType: Output.Type, failure: Failure) {
        self.error = failure
    }
    
    /// The failure to send when terminating the publisher.
    public let error: Failure
    
    public func receive<S: Subscriber>(subscriber: S) where Output == S.Input, Failure == S.Failure {
        Result<Output, Failure>
            .failure(self.error)
            .cx
            .publisher
            .receive(subscriber: subscriber)
    }
}
