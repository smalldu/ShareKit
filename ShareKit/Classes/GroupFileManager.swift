//
//  GroupFileManager.swift
//  ShareU
//
//  Created by duzhe on 2017/5/7.
//  Copyright © 2017年 duzhe. All rights reserved.
//

import Foundation


public class GroupFileManager{
  
  public static let shared: GroupFileManager = GroupFileManager()
  private let groupURL: URL?
  private let key =  "zz_share_item"
  var diskCache:String!
  init(){
    if let fileURL = FileManager.default
      .containerURL(forSecurityApplicationGroupIdentifier: "group.zz.shareU") {
      groupURL = fileURL.appendingPathComponent("shareItem.uxx")
      print(groupURL!.absoluteString)
//      do {
//       try FileManager.default.createDirectory(at: groupURL! , withIntermediateDirectories: true, attributes: nil)
//      } catch let error {
//        print("Error: \(error.localizedDescription)")
//      }
      
    } else {
      groupURL = nil
    }
  }
  
  public func save(shareItem:ShareItem ) {
    guard let groupURL = groupURL else {
      return
    }
    self.retrive { (obj) in
      var items: [ShareItem] = []
      if let obj = obj as? [ShareItem] {
        items = obj
      }
      items.append(shareItem)
      let data = NSMutableData()
      var keyArchiver:NSKeyedArchiver!
      keyArchiver =  NSKeyedArchiver(forWritingWith: data)
      keyArchiver.encode(items, forKey: self.key)  //对key进行MD5加密
      keyArchiver.finishEncoding() //归档完毕
      print(groupURL)
      do {
        try data.write(to: groupURL, options: NSData.WritingOptions.atomic )
      } catch let error {
        print("Error: \(error.localizedDescription)")
      }
    }
  }
  
  public func retrive(complete:@escaping ((_ obj:Any?)->())){
    guard let groupURL = groupURL else {
      complete(nil)
      return
    }
    //反归档 获取
    DispatchQueue.global().async { () -> Void in
      do {
        let mdata = try NSMutableData(contentsOf: groupURL, options: NSData.ReadingOptions.alwaysMapped) as Data
        let unArchiver = NSKeyedUnarchiver(forReadingWith: mdata)
        
        let obj = try unArchiver.decodeTopLevelObject(forKey: self.key)
        complete(obj)
      }
      catch {
        complete(nil)
      }
    }
  }
  
  /// 删除全部
  public func deleteAll(){
    guard let groupURL = groupURL else {
      return
    }
    let data = NSMutableData()
    var keyArchiver:NSKeyedArchiver!
    keyArchiver =  NSKeyedArchiver(forWritingWith: data)
    keyArchiver.encode( nil , forKey: key)  //对key进行MD5加密
    keyArchiver.finishEncoding() //归档完毕
    print(groupURL)
    do {
      try data.write(to: groupURL, options: NSData.WritingOptions.atomic )
    } catch let error {
      print("Error: \(error.localizedDescription)")
    }
  }
  
}
