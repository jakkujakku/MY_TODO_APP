//
//  CustomUIBarButtonItem.swift
//  PinterestAppTest
//
//  Created by (^ㅗ^)7 iMac on 2023/08/16.
//

import UIKit

final class CustomUIBarButtonItem: UIBarButtonItem {
    override init() {
        super.init()
        self.title = "추가"
        self.style = .plain
        self.target = self
        self.action = nil
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
