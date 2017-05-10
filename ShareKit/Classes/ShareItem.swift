//
//  ShareItem.swift
//  ShareU
//
//  Created by duzhe on 2017/5/7.
//  Copyright © 2017年 duzhe. All rights reserved.
//

import UIKit

public class ShareItem: NSObject , NSCoding {

  public var folder: String? // 存放的目录
  public var text: String? // 文本信息
  public var url: URL?
  public var image: UIImage?
  public var category_id: Int = 0 // 目录id
  
  public override init() {
  }
  
  public func encode(with aCoder: NSCoder) {
    aCoder.encode(folder, forKey: "folder")
    aCoder.encode(text, forKey: "text")
    aCoder.encode(url, forKey: "url")
    aCoder.encode(image, forKey: "image")
    aCoder.encode(category_id, forKey: "category_id")
  }
  public required init?(coder aDecoder: NSCoder) {
    folder = aDecoder.decodeObject(forKey: "folder") as? String
    text = aDecoder.decodeObject(forKey: "text") as? String
    url = aDecoder.decodeObject(forKey: "url") as? URL
    image = aDecoder.decodeObject(forKey: "image") as? UIImage
    category_id = aDecoder.decodeInteger(forKey: "category_id")
  }
  
}
