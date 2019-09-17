# AES Everywhere - Cross Language Encryption Library

[AES Everywhere](https://github.com/mervick/aes-everywhere) is Cross Language Encryption Library which provides the ability to encrypt and decrypt data using a single algorithm in different programming languages and on different platforms.

This is an implementation of the AES algorithm, specifically CBC mode, with 256 bits key length and PKCS7 padding.
It implements OpenSSL compatible cryptography with random generated salt


## [Swift](https://swift.org) implementation

Swift implementation uses [BlueCryptor](https://github.com/IBM-Swift/BlueCryptor) which provides swift cross-platform crypto library derived from IDZSwiftCommonCrypto.
On macOS and iOS, BlueCryptor uses the Apple provided [CommonCrypto](https://developer.apple.com/library/archive/documentation/System/Conceptual/ManPages_iPhoneOS/man3/Common%20Crypto.3cc.html) library. On Linux, it uses [libcrypto](https://wiki.openssl.org/index.php/Libcrypto_API) from the [OpenSSL](https://www.openssl.org/) project.

Current repo is a part of [AES-everywhere](https://github.com/mervick/aes-everywhere) project separated due to the requirements of Swift Package Manager

### Installation

**Using [Swift Package Manager](https://swift.org/package-manager/):**
In your `Package.swift` add dependency to github url
```swift
  dependencies: [
    .package(url: "https://github.com/mervick/aes-everywhere-swift.git", from: "1.2.0")
  ],
```
and in target dependencies add "AesEverywhere":
```swift
  targets: [
    .target(
      name: "your-project-name",
      dependencies: [
        "AesEverywhere"
      ])
  ]
```

**Using [CocoaPods](https://cocoapods.org/):**

@TODO: publish pod, add docs


### Usage

```swift
import AesEverywhere

let crypted = try! AES256.encrypt(input: "TEST", passphrase: "PASS")
print(crypted)

let decrypted = try! AES256.decrypt(input: crypted, passphrase: "PASS")
print(decrypted)
```

