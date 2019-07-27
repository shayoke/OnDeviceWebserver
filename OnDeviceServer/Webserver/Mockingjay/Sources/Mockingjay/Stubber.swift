//
//  Stubber.swift
//  Mockingjay
//
//  Created by Shayoke Mukherjee on 28/07/2019.
//

import Foundation

public class Stubber {
  
  public init() {}
  
  @discardableResult public func stub(_ matcher: @escaping Matcher, delay: TimeInterval? = nil, _ builder: @escaping Builder) -> Stub {
    
    //    if mockingjayRemoveStubOnTearDown {
    //      shutDown()
    //
    //    }
    
    return MockingjayProtocol.addStub(matcher: matcher, delay: delay, builder: builder)
  }
  
  
  public func removeStub(_ stub:Stub) {
    MockingjayProtocol.removeStub(stub)
  }
  
  public func removeAllStubs() {
    MockingjayProtocol.removeAllStubs()
  }
  
  private func shutDown() {
    //    if mockingjayRemoveStubOnTearDown {
    MockingjayProtocol.removeAllStubs()
    //    }
  }
}

//
//var AssociatedMockingjayRemoveStubOnTearDownHandle: UInt8 = 0
//  /// Whether Mockingjay should remove stubs on teardown
//  public var mockingjayRemoveStubOnTearDown: Bool {
//    get {
//      let associatedResult = objc_getAssociatedObject(self, &AssociatedMockingjayRemoveStubOnTearDownHandle) as? Bool
//      return associatedResult ?? true
//    }
//
//    set {
//      objc_setAssociatedObject(self, &AssociatedMockingjayRemoveStubOnTearDownHandle, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
//    }
//  }
//
//}
