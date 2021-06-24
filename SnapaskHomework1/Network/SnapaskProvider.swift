//
//  SnapaskProvider.swift
//  SnapaskHomework
//
//  Created by Albert_Chien on 2021/6/23.
//

import Moya
import RxCocoa
import RxSwift

class SnapaskProvider<Target: TargetType>: MoyaProvider<Target> {

    init(endpointClosure:@escaping EndpointClosure = MoyaProvider.defaultEndpointMapping,
         stubClosure: @escaping StubClosure = MoyaProvider.neverStub) {
        super.init(endpointClosure:endpointClosure,
                   stubClosure: stubClosure)
    }

    func request<T>(_ modelType: T.Type, request: Target, callbackQueue: DispatchQueue? = nil) -> Single<T> where T: Decodable {
        Single<Result<Response, MoyaError>>
            .create {[weak self] singleObserver in
            guard let self = self else {return Disposables.create()}
            let cancellableToken = self.request(request) { progress in
            } completion: { complete in
                singleObserver(.success(complete))
            }

            return Disposables.create {
                cancellableToken.cancel()
            }
        }.flatMap { result in
            Single<T>.create { single in
                switch result {
                case .success(let response):
                    do {
                        let json = try JSONDecoder().decode(T.self, from: response.data)
                        single(.success(json))
                    } catch {
                        print(error)
                        single(.error(error))
                    }
                case .failure(let error):
                    single(.error(error))
                }
              return Disposables.create()
            }
        }
    }

}

class SnapaskNetworkService {
    public static let shared = SnapaskNetworkService()

    private let provider: SnapaskProvider<MultiTarget>

    init(provider: SnapaskProvider<MultiTarget> = SnapaskProvider<MultiTarget>()) {
        self.provider = provider
    }

    func request<R: SnapaskTargetType>(_ request: R) -> Single<R.ResponseType> {
        let target = MultiTarget(request)
        return provider.request(R.ResponseType.self, request: target)
    }
}
