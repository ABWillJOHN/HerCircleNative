//
//  AesEncrypt.swift
//  restNew
//
//  Created by Rahul Patel on 09/07/21.
//

import Foundation
import UIKit
import CommonCrypto

class AesEncryption: NSObject {
    override init() {
        super.init()
    }

    func encrypt(encryptedText:String, keyString: String) -> String? {

        let derivedKey = generateDerivedKey(keyString: keyString)
        let keyData = Data(bytes: derivedKey[0..<32])
        let ivData = Data(bytes: derivedKey[32..<48])

        let rawData = encryptedText.data(using: .utf16LittleEndian)! //self.data(using: .utf16LittleEndian)!
        let encryptedData = Crypt(data: rawData, keyData: keyData, ivData: ivData, operation: kCCEncrypt)
//        let encryptedString  = encryptedData.base64EncodedString()
//        return encryptedString
        guard let encryptedString  = encryptedData.base64EncodedString() as String? else {
            return nil
        }
        return encryptedString
    }

    func decrypt(encryptedText: String, keys: String)  -> String? { //### `String?` rather than `String`
        //### Decode `encryptedText` as Base-64
        guard let encryptedData = Data(base64Encoded: encryptedText) else {
            print("Data is not a valid Base-64")
            return nil
        }
        let derivedKey = generateDerivedKey(keyString: keys)
        //### A little bit shorter, when `derivedKey` is of type `[UInt8]`
        let keyData = Data(bytes: derivedKey[0..<32])
        let ivData = Data(bytes: derivedKey[32..<48])
        if let decryptedData = DeCrypt(data: encryptedData, keyData: keyData, ivData: ivData, operation: kCCDecrypt) {
            //### Use `utf16LittleEndian`
            return String(bytes: decryptedData, encoding: .utf16LittleEndian)
        } else {
            //### return nil, when `testDeCrypt` fails
            return nil
        }
    }

    func Crypt(data: Data, keyData: Data, ivData: Data, operation:Int) -> Data {
        assert(keyData.count == Int(kCCKeySizeAES128) || keyData.count == Int(kCCKeySizeAES192) || keyData.count == Int(kCCKeySizeAES256))

        let buffer_size = data.count + kCCBlockSizeAES128
        var buffer: [UInt8] = Array(repeating: 0, count: buffer_size)
        var num_bytes_encrypted : size_t = 0
        let operation = CCOperation(operation)
        let algoritm = CCAlgorithm(kCCAlgorithmAES)
        let options = CCOptions(kCCOptionPKCS7Padding)

        let cryptoStatus = keyData.withUnsafeBytes {keyDataBytes in
            ivData.withUnsafeBytes {ivDataBytes in
                data.withUnsafeBytes {dataBytes in
                    CCCrypt(operation, algoritm, options, keyDataBytes, keyData.count, ivDataBytes, dataBytes, data.count, &buffer, buffer_size, &num_bytes_encrypted)
                }
            }
        }

        if cryptoStatus == CCCryptorStatus(kCCSuccess){
            let myResult = Data(bytes: buffer, count: num_bytes_encrypted)
            return myResult
        } else {
            return Data()
        }
    }


    func DeCrypt(data: Data, keyData: Data, ivData: Data, operation: Int) -> Data? { //### make it Optional
        assert(keyData.count == Int(kCCKeySizeAES128) || keyData.count == Int(kCCKeySizeAES192) || keyData.count == Int(kCCKeySizeAES256))
        var decryptedData = Data(count: data.count)
        var numBytesDecrypted: size_t = 0
        let operation = CCOperation(operation)
        let algoritm = CCAlgorithm(kCCAlgorithmAES)
        let options = CCOptions(kCCOptionPKCS7Padding)
        let decryptedDataCount = decryptedData.count
        let cryptoStatus = keyData.withUnsafeBytes {keyDataBytes in
            ivData.withUnsafeBytes {ivDataBytes in
                data.withUnsafeBytes {dataBytes in
                    decryptedData.withUnsafeMutableBytes {decryptedDataBytes in
                        CCCrypt(operation, algoritm, options, keyDataBytes, keyData.count, ivDataBytes, dataBytes, data.count, decryptedDataBytes, decryptedDataCount, &numBytesDecrypted)
                    }
                }
            }
        }
        if cryptoStatus == CCCryptorStatus(kCCSuccess) {
            decryptedData.count = numBytesDecrypted
            return decryptedData
        } else {
            return nil //### returning `nil` instead of `Data()`
        }
    }

    func generateDerivedKey(keyString: String) -> [UInt8] { //### `[UInt8]`
        let salt: [UInt8] = [0x49, 0x76, 0x61, 0x6e, 0x20, 0x4d, 0x65, 0x64, 0x76, 0x65, 0x64, 0x65, 0x76]
        var key = [UInt8](repeating: 0, count: 48)
        CCKeyDerivationPBKDF(CCPBKDFAlgorithm(kCCPBKDF2), keyString, keyString.utf8.count, salt, salt.count, CCPseudoRandomAlgorithm(kCCPRFHmacAlgSHA1), 1000, &key, 48)

        //### return the Array of `UInt8` directly
        return key
    }

}
