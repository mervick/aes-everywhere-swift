// AES256.swift
// This file is part of AES-everywhere project (https://github.com/mervick/aes-everywhere)
//
// This is an implementation of the AES algorithm, specifically CBC mode,
// with 256 bits key length and PKCS7 padding.
//
// Copyright Andrey Izman (c) 2019 <izmanw@gmail.com>
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.


import Foundation
import Cryptor


public final class AES256 {

    public static let SALTLEN:  Int = 8
    public static let BLOCKLEN: Int = 16
    public static let KEYLEN:   Int = 32

    public enum Error: Swift.Error {
        case invalidData
    }

    public static func encrypt(input: String, passphrase: String) throws -> String {
        let salt = try! Random.generate(byteCount: AES256.SALTLEN)
        let ctx = AES256.deriveKeyAndIv(passphrase, salt)

        let cryptor = try! Cryptor(operation: .encrypt, algorithm: .aes256, options: .pkcs7Padding, key: ctx.key, iv: ctx.iv)
        var cipher = cryptor.update(data: input.data(using: .utf8)!)?.final()!

        cipher = Array("Salted__".data(using: .utf8)!) + salt + cipher!
        let data = Data(bytes: cipher!, count: Int(cipher?.count ?? 0))

        return data.base64EncodedString()
    }

    public static func decrypt(input: String, passphrase: String) throws -> String {
        do {
            let data = Array(Data(base64Encoded: input)!)
            let salted = String(bytes: Array(data[0...7]), encoding: .utf8)!

            if (salted != String("Salted__")) {
                throw Error.invalidData
            }

            let salt = Array(data[8...15])
            let cipher = Array(data[16...])
            let ctx = AES256.deriveKeyAndIv(passphrase, salt)

            let cryptor = try! Cryptor(operation: .decrypt, algorithm: .aes256, options: .pkcs7Padding, key: ctx.key, iv: ctx.iv)
            let decrypted = cryptor.update(byteArray: cipher)?.final()!

            return String(bytes: decrypted!, encoding: .utf8)!
        } catch _ {
            throw Error.invalidData
        }
    }

    private static func deriveKeyAndIv(_ passphrase: String, _ salt: Array<UInt8>) -> (key: Array<UInt8>, iv: Array<UInt8>) {
        let pass = Array(passphrase.data(using: .utf8)!)
        var dx: Array<UInt8> = []
        var di: Array<UInt8> = []

        for _ in 1...3 {
            di = AES256.md5(di + pass + salt)
            dx += di
        }

        return (key: Array(dx[0...31]), iv: Array(dx[32...47]))
    }

    @inline(__always)
    private static func md5(_ bytes: Array<UInt8>) -> Array<UInt8> {
        let md5 = Digest(using: .md5)
        _ = md5.update(byteArray: bytes)
        return md5.final()
    }
}

