//
//  Observable+Rx.swift
//  VVHelper
//
//  Created by huang on 2020/5/9.
//

import Foundation

extension ConcurrentDispatchQueueScheduler {
    private static let globalInstanceDefault = ConcurrentDispatchQueueScheduler(queue: DispatchQueue.global())
    
    private static var globalInstances: [DispatchQoS.QoSClass: ConcurrentDispatchQueueScheduler] = {
        let allQos: [DispatchQoS.QoSClass] = [
            .default, .background, .userInitiated, .userInteractive, .utility, .unspecified
        ]
        let schedulers = allQos.map { (qos) in
            ConcurrentDispatchQueueScheduler(queue: DispatchQueue.global(qos: qos))
        }
        
        return Dictionary(uniqueKeysWithValues: zip(allQos, schedulers))
    }()
    
    static func globalInstance(qos: DispatchQoS.QoSClass = .default) -> ImmediateSchedulerType {
        return globalInstances[qos] ?? globalInstanceDefault
    }
}

extension ObservableType {
    func deliveryOnMainThread() -> Observable<Self.Element> {
        return self.observeOn(MainScheduler.instance)
    }
    
    func deliveryOnGlobalQueue(qos: DispatchQoS.QoSClass = .default) -> Observable<Self.Element> {
        return self.observeOn(ConcurrentDispatchQueueScheduler.globalInstance(qos: qos))
    }
}

extension PrimitiveSequence {
    func deliveryOnMainThread() -> PrimitiveSequence<Trait, Element> {
        return self.observeOn(MainScheduler.instance)
    }
    
    func deliveryOnGlobalQueue(qos: DispatchQoS.QoSClass = .default) -> PrimitiveSequence<Trait, Element> {
        return self.observeOn(ConcurrentDispatchQueueScheduler.globalInstance(qos: qos))
    }
}
