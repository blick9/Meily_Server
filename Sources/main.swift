import Kitura
import HeliumLogger
import Foundation
import LoggerAPI

let heliumLogger = HeliumLogger(.entry)
Log.logger = heliumLogger

let router = Router()
let handleFuncion = HandleFunction()

router.get("/test") { (request, response, next) in
    response.send("hello, codesquad and TEST")
    next()
}

router.post("/test") { (request, response, next) in
//    var data = DataBase()
    
    var bodyy : Data = Data()
    let body = try request.read(into: &bodyy)
    let string = String(data: bodyy, encoding: .utf8)
    
    Log.info("\(string)")
    try response.send("Echo \(string), TEST").end()
    next()
}

router.post("/api/user/register") { (request, response, next) in
    var data = Data()
    try request.read(into: &data)
    let validDicData = handleFuncion.emailAndPwJsonToDic(data: data)
    print(validDicData)

    let isDuplication = DataBase.sharedInstance.validDuplication(email: validDicData["email"]!)
    if isDuplication == true {
//        response.send("이미 존재하는 이메일 입니다.")
        response.send(status: .conflict)
    } else {
        let isResisterWorking = DataBase.sharedInstance.saveUserData(Email: validDicData["email"]!, Password: validDicData["password"]!)
//        response.send("회원가입 성공!")
        response.send(status: .OK)
    }
    next()
}

router.post("/api/user/login") { (request, response, next) in
    var data = Data()
    try request.read(into: &data)
    let validDicData = handleFuncion.emailAndPwJsonToDic(data: data)
    print(validDicData)
    
    let isDuplication = DataBase.sharedInstance.validDuplication(email: validDicData["email"]!)
    if isDuplication == false {
//        response.send("존재하지 않는 이메일입니다.")
        response.send(status: .notFound)
    } else if DataBase.sharedInstance.login(Email: validDicData["email"]!, Password: validDicData["password"]!) == false {
//        response.send("비밀번호가 맞지 않습니다.")
        response.send(status: .notAcceptable)
    } else {
//        response.send("로그인 성공!")
        response.send(status: .OK)
    }
    next()
}


router.get("/api/user/list/:email") { (request, response, next) in
    let emailData = request.parameters["email"] ?? ""
    
    let isDuplication = DataBase.sharedInstance.validDuplication(email: emailData)
    if isDuplication == true {
//        try response.send("이미 존재하는 E-mail 입니다.").end()
        response.send(status: .conflict)
    } else {
//        try response.send("중복된 E-mail 없음").end()
        response.send(status: .accepted)
    }
    Log.info("\(isDuplication)")
    next()
}

router.post("/api/login/certifylogin") { (request, response, next) in
    //
    // 현재 로그인 된 유저정보 받고, 로그인된 이메일 리퀘스트
    // 이후 현재 로그인된 유저정보 이메일로 이루어진 키값과 그 키값으로 저장된 아카이브 데이터 전송 후 복구 굿굿
}

router.get("/api/login/getloginid") { (request, response, next) in
//    response.send(<#T##str: String##String#>)
}

router.get("/api/user/alllist") { (request, response, next) in
    response.send(json: DataBase.sharedInstance.getUserEmailList())
}


router.all("/static", middleware: StaticFileServer())

Kitura.addHTTPServer(onPort: 8080, with: router)
Kitura.run()
