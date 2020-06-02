import UIKit
import DGCore
import RxSwift
import RxCocoa

let dummy = DGCoreDummy()
print(dummy)

let testBehavior = BehaviorRelay<Int>(value: 0)

testBehavior.subscribe(onNext: { val in
    print(val)
})

testBehavior.accept(1)
testBehavior.accept(2)
testBehavior.accept(3)
