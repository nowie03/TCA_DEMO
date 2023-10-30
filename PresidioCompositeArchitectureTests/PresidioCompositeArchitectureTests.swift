//
//  PresidioCompositeArchitectureTests.swift
//  PresidioCompositeArchitectureTests
//
//  Created by immanuel nowpert on 25/10/23.
//

import XCTest
import ComposableArchitecture
@testable import PresidioCompositeArchitecture

final class PresidioCompositeArchitectureTests: XCTestCase {
    let emailRegex = #"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }
    
    func testEmail () throws {
        if isEmailValid("nowiexmail.com") {
            XCTAssert(true)
        }
    }
    
    func isEmailValid(_ email:String)-> Bool{
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with:email)
    }
    
    @MainActor
    func testProductApiCall () async throws {
        let store = TestStore(initialState: ProductsFeature.State()) {
            ProductsFeature()
        }
        
       
        
        await store.send(.viewOnReady)
        
        await store.receive(.sendResponse([Product]()), timeout: .seconds(2)) { state in
            state.products = [Product(id: 1, title: "Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops", price: 109.95, category: "men's clothing", description: "Your perfect pack for everyday use and walks in the forest. Stash your laptop (up to 15 inches) in the padded sleeve, your everyday", image: "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg")]
        }
        
//        await store.send(.viewOnReady) { state in
//            state.products = [Product(id: 1, title: "Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops", price: 109.95, category: "men's clothing", description: "Your perfect pack for everyday use and walks in the forest. Stash your laptop (up to 15 inches) in the padded sleeve, your everyday", image: "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg")]
//        }
        
        await store.finish()
    }
    
    @MainActor
    func testCounterFeature ()async  throws {
        let store = TestStore(initialState: CounterFeature.State()) {
            CounterFeature()
        }
        
        await store.send(.incrementButtonTapped){
            state in
            state.count += 1
        }
        
        await store.send(.decrementButtonTapped) { state in
            state.count -= 1
        }
        
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
