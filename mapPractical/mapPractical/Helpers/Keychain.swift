//
//  Constants.swift
//  mapPractical
//
//  Created by Pranav Gupte on 06/03/22.
//

import Foundation
import Security

// Constant Identifiers
let userAccount = "AuthenticatedUser"
let accessGroup = "SecuritySerivice"
let passwordKey = "KeyForPassword"
let usernameKey = "KeyForUsername"

// Arguments for the keychain queries
let kSecClassValue = NSString(format: kSecClass)
let kSecAttrAccountValue = NSString(format: kSecAttrAccount)
let kSecValueDataValue = NSString(format: kSecValueData)
let kSecClassGenericPasswordValue = NSString(format: kSecClassGenericPassword)
let kSecAttrServiceValue = NSString(format: kSecAttrService)
let kSecMatchLimitValue = NSString(format: kSecMatchLimit)
let kSecReturnDataValue = NSString(format: kSecReturnData)
let kSecMatchLimitOneValue = NSString(format: kSecMatchLimitOne)
public class KeychainService: NSObject {
    public class func saveUsername(username: NSString) {
        self.save(service: usernameKey as NSString, data: username)
    }
    public class func loadUsername() -> NSString? {
        return self.load(service: usernameKey as NSString)
    }
    public class func savePassword(password: NSString) {
        self.save(service: passwordKey as NSString, data: password)
    }
    public class func loadPassword() -> NSString? {
        return self.load(service: passwordKey as NSString)
    }
    public class func remove(username: NSString, password: NSString){
        self.remove(service1: usernameKey as NSString, service2: passwordKey as NSString,  usernameData: username,  pwdData: password)
    }
    private class func remove(service1: NSString, service2: NSString, usernameData: NSString,  pwdData: NSString) {
        let dataFromString1: NSData = usernameData.data(using:String.Encoding.utf8.rawValue, allowLossyConversion: false)! as NSData
        let dataFromString2: NSData = pwdData.data(using:String.Encoding.utf8.rawValue, allowLossyConversion: false)! as NSData
        
        // Instantiate a new default keychain query
        let keychainQuery1: NSMutableDictionary = NSMutableDictionary(objects: [kSecClassGenericPasswordValue, service1, userAccount, dataFromString1], forKeys: [kSecClassValue, kSecAttrServiceValue, kSecAttrAccountValue, kSecValueDataValue])
        let keychainQuery2: NSMutableDictionary = NSMutableDictionary(objects: [kSecClassGenericPasswordValue, service2, userAccount, dataFromString2], forKeys: [kSecClassValue, kSecAttrServiceValue, kSecAttrAccountValue, kSecValueDataValue])
        
        // Delete itmes
        SecItemDelete(keychainQuery1 as CFDictionary)
        SecItemDelete(keychainQuery2 as CFDictionary)
    }
    private class func save(service: NSString, data: NSString) {
        let dataFromString: NSData = data.data(using:String.Encoding.utf8.rawValue, allowLossyConversion: false)! as NSData
        
        // Instantiate a new default keychain query
        let keychainQuery: NSMutableDictionary = NSMutableDictionary(objects: [kSecClassGenericPasswordValue, service, userAccount, dataFromString], forKeys: [kSecClassValue, kSecAttrServiceValue, kSecAttrAccountValue, kSecValueDataValue])
        
        // Delete any existing items
        SecItemDelete(keychainQuery as CFDictionary)
        
        // Add the new keychain item
        SecItemAdd(keychainQuery as CFDictionary, nil)
    }
    private class func load(service: NSString) -> NSString? {
        // Limit our results to one item
        let keychainQuery: NSMutableDictionary = NSMutableDictionary(objects: [kSecClassGenericPasswordValue, service, userAccount, kCFBooleanTrue!, kSecMatchLimitOneValue], forKeys: [kSecClassValue, kSecAttrServiceValue, kSecAttrAccountValue, kSecReturnDataValue, kSecMatchLimitValue])
        var dataTypeRef :AnyObject?
        // Search for the keychain items
        let status: OSStatus = SecItemCopyMatching(keychainQuery, &dataTypeRef)
        var contentsOfKeychain: NSString? = nil
        if status == errSecSuccess {
            if let retrievedData = dataTypeRef as? NSData {
                contentsOfKeychain = NSString(data: retrievedData as Data, encoding: String.Encoding.utf8.rawValue)
            }
        } else {
            print("Nothing was retrieved from the keychain. Status code \(status)")
        }
        return contentsOfKeychain
    }
}
