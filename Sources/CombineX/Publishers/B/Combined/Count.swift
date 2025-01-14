#if !COCOAPODS
import CXUtility
#endif

extension Publisher {
    
    /// Publishes the number of elements received from the upstream publisher.
    ///
    /// - Returns: A publisher that consumes all elements until the upstream publisher finishes, then emits a single
    /// value with the total number of elements received.
    public func count() -> Publishers.Count<Self> {
        return .init(upstream: self)
    }
}

extension Publishers.Count: Equatable where Upstream: Equatable {
    
    public static func == (lhs: Publishers.Count<Upstream>, rhs: Publishers.Count<Upstream>) -> Bool {
        return lhs.upstream == rhs.upstream
    }
}

extension Publishers {
    
    /// A publisher that publishes the number of elements received from the upstream publisher.
    public struct Count<Upstream: Publisher>: Publisher {
        
        public typealias Output = Int
        
        public typealias Failure = Upstream.Failure
        
        /// The publisher from which this publisher receives elements.
        public let upstream: Upstream
        
        public init(upstream: Upstream) {
            self.upstream = upstream
        }
        
        public func receive<S: Subscriber>(subscriber: S) where Upstream.Failure == S.Failure, S.Input == Publishers.Count<Upstream>.Output {
            self.upstream
                .reduce(Atom(val: 0)) { counter, _ in
                    _ = counter.add(1)
                    return counter
                }
                .map {
                    $0.get()
                }
                .receive(subscriber: subscriber)
        }
    }
}
