import Quick
import Nimble

#if USE_COMBINE
import Combine
#elseif SWIFT_PACKAGE
import CombineX
#else
import Specs
#endif

class PrefixUntilOutputSpec: QuickSpec {
    
    override func spec() {
        
        // MARK: - Relay
        describe("Relay") {
            
            // MARK: 1.1 should relay until other sends a value
            it("should relay until other sends a value") {
                
                let pub0 = PassthroughSubject<Int, CustomError>()
                let pub1 = PassthroughSubject<Int, CustomError>()
                
                let pub = pub0.prefix(untilOutputFrom: pub1)
                let sub = makeCustomSubscriber(Int.self, CustomError.self, .unlimited)
                pub.subscribe(sub)
                
                10.times {
                    pub0.send($0)
                }
                pub1.send(-1)
                
                for i in 10..<20 {
                    pub0.send(i)
                }
                 
                let valueEvents = (0..<10).map { CustomEvent<Int, CustomError>.value($0) }
                let expected = valueEvents + [.completion(.finished)]
                expect(sub.events).to(equal(expected))
            }
            
            // MARK: 1.2 should complete when other complete
            it("should complete when other complete") {
                
                let pub0 = PassthroughSubject<Int, CustomError>()
                let pub1 = PassthroughSubject<Int, CustomError>()
                
                let pub = pub0.prefix(untilOutputFrom: pub1)
                let sub = makeCustomSubscriber(Int.self, CustomError.self, .unlimited)
                pub.subscribe(sub)
                
                10.times {
                    pub0.send($0)
                }
                pub1.send(completion: .failure(.e0))
                for i in 10..<20 {
                    pub0.send(i)
                }
                
                let expected = (0..<20).map {
                    CustomEvent<Int, CustomError>.value($0)
                }
                expect(sub.events).to(equal(expected))
            }
        }
    }
}
