//
//  APNSFileGenerator.swift
//  PushSender
//

import Foundation

final class APNSFileGenerator {
    static func make(bundleId: String, title: String, body: String, customPayload: String?) {
        var jsonString: String =
        """
        "Simulator Target Bundle" : "\(bundleId)",
        "aps" : {
            "alert" : {
                "title" : "\(title)",
                "body" : "\(body)",
            },
        },
        """
        if let payload = customPayload {
            jsonString += payload
        }
        
        // 파일이 저장될 디렉토리 경로와 파일 이름 결정
        let directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileURL = directoryURL.appendingPathComponent("test.apns")
        
        var resultJsonString: String =
        """
        {
            \(jsonString)
        }
        """
        
        do {
            // 파일에 데이터 작성
            try resultJsonString.write(to: fileURL, atomically: true, encoding: .utf8)
            print("[✅] Success. FilePath -> \(fileURL.path)")
        } catch {
            print("[❌] Failed -> \(error)")
        }
    }
}
