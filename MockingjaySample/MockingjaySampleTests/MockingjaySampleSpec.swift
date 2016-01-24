import Quick
import Nimble
import Mockingjay
import Alamofire
import SwiftyJSON

class MockingjaySampleSpec: QuickSpec {
    var isSuccess: Bool!
    let url = "http://hogehoge.com/hoge1/fuga.json"
    var language: String!
    
    override func spec() {
        describe("API request") {
            context("when you request \(self.url)") {
                beforeEach() {
                    let body = [ "language": "swift" ]
                    self.stub(http(.GET, uri: self.url), builder: json(body))
                }
                
                it("if returns json") {
                    dispatch_async(dispatch_get_main_queue()) {
                        Alamofire.request(.GET, self.url)
                            .responseJSON { response in
                                self.isSuccess = response.result.isSuccess
                        }
                    }
                    expect(self.isSuccess).toEventually(beTruthy())
                }
            }
        }
    }
}