//
//  Constant.swift
//  ShareU
//
//  Created by duzhe on 2017/5/6.
//  Copyright © 2017年 duzhe. All rights reserved.
//

import Foundation


public struct Constant {
  
  /// 延时加载
  ///
  /// - Parameters:
  ///   - seconds: 秒
  ///   - completion: 回调
  public static func delay(_ seconds: Double, completion:@escaping ()->()) {
    let popTime = DispatchTime.now() + Double(Int64( Double(NSEC_PER_SEC) * seconds )) / Double(NSEC_PER_SEC)
    DispatchQueue.main.asyncAfter(deadline: popTime) {
      completion()
    }
  }
  
  public static func setDefault(_ key:String,value:Any?){
    // 使用group
    guard let userDefaults = UserDefaults(suiteName: "group.zz.shareU") else {
      return
    }
    if value == nil{
      userDefaults.removeObject(forKey: key)
    }else{
      userDefaults.set(value, forKey: key)
      userDefaults.synchronize() //同步
    }
  }
  
  public static func removeUserDefault(_ key:String?){
    // 使用group
    guard let userDefaults = UserDefaults(suiteName: "group.zz.shareU") else {
      return
    }
    if key != nil{
      userDefaults.removeObject(forKey: key!)
      userDefaults.synchronize()
    }
  }
  
  public static func getDefault(_ key:String) ->Any?{
    // 使用group
    guard let userDefaults = UserDefaults(suiteName: "group.zz.shareU") else {
      return nil
    }
    return userDefaults.value(forKey: key)
  }
  
  /**
   资源锁
   
   - parameter lock:    lock对象
   - parameter closure: 闭包
   */
  public func synchronized(_ lock:AnyObject,closure:(()->())?){
    objc_sync_enter(lock)
    closure?()
    objc_sync_exit(lock)
  }
  
}

/**
 在debug下输出 release不打印
 
 - parameter item:
 */
func zp(_ item: @autoclosure () -> Any) {
  #if DEBUG
    print(item())
  #endif
}
