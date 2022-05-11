//
//  NewsAPI.swift
//  NewsTest
//
//  Created by AnhLe on 10/05/2022.
//

import RxSwift
import Moya

class NewsAPI {
    
    static let shared = NewsAPI()
    let disposedBag = DisposeBag()
    let provider = MoyaProvider<NewsTargetType>()

    private init() {}
    
    func request(target: NewsTargetType) -> Single<NewsResponse> {
        return Single.create { single in
            self.provider.rx
                .request(target)
                .subscribe(onSuccess: { response in
                    if let result = self.handleResponse(response, returnType: NewsResponse.self) {
                        if let status = result.status {
                            if status == "error" {
                                single(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: result.message ?? ""])))
                            } else {
                                single(.success(result))
                            }
                        } else {
                            single(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Response error"])))
                        }
                    } else {
                        single(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Parse error"])))
                    }
                }, onFailure: { error in
                    single(.failure(error))
                })
                .disposed(by: self.disposedBag)
            return Disposables.create()
        }
    }
}

extension NewsAPI {
    private func handleResponse<T: Decodable>(_ response: Response, returnType: T.Type) -> T? {
        do {
            let decoder = JSONDecoder()
            let result = try decoder.decode(returnType, from: response.data)
            return result
        } catch {
            print("Parse data error: \(error)")
            return nil
        }
    }
}
