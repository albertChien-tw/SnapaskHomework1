//
//  StubbingConstructor.swift
//  SnapaskHomework
//
//  Created by Albert_Chien on 2021/6/24.
//

import Moya
import Alamofire

struct StubbingConstructor {

    public func setSuccess(mockData: Data, statusCode: Int = 200, responseTime: TimeInterval = 0.3) -> SnapaskNetworkService {
        let provider = { () -> SnapaskProvider<MultiTarget> in
            let mockDataClosure = makeMockDataClosure(statusCode, mockData)
            let stubClosure = getStubClosure(from: responseTime)
            return SnapaskProvider<MultiTarget>(endpointClosure: mockDataClosure,
                                                stubClosure: stubClosure)
        }()
        return SnapaskNetworkService(provider: provider)
    }

    public func setFailure(mockData: Data, statusCode: Int = 400, responseTime: TimeInterval = 0.3) -> SnapaskNetworkService {
        let provider: SnapaskProvider<MultiTarget> = {() -> SnapaskProvider<MultiTarget> in
            let mockDataClosure = makeMockDataClosure(statusCode, mockData)
            let stubClosure = getStubClosure(from: responseTime)

            return SnapaskProvider<MultiTarget>(
                endpointClosure: mockDataClosure,
                stubClosure: stubClosure)
        }()
        return SnapaskNetworkService(provider: provider)
    }

    private func getStubClosure(from responseTime: TimeInterval) -> (MultiTarget) -> StubBehavior {
        responseTime > 0 ? MoyaProvider.delayedStub(responseTime) : MoyaProvider.immediatelyStub
    }

    private func makeMockDataClosure(_ statusCode: Int, _ mockData: Data) -> (MultiTarget) -> Endpoint {
        { (target: MultiTarget) -> Endpoint in
            Endpoint(
                    url: URL(target: target).absoluteString,
                    sampleResponseClosure: { .networkResponse(statusCode, mockData) },
                    method: target.method,
                    task: target.task,
                    httpHeaderFields: target.headers
            )
        }
    }
}
