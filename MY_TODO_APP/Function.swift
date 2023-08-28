//
//  Function.swift
//  MY_TODO_APP
//
//  Created by (^ㅗ^)7 iMac on 2023/08/24.
//

import UIKit

@objc protocol SetupDelegateProtocol {
    @objc optional func setup()

    // 스크롤시 서치바 보이게 하는 함수 ✅
    @objc optional func topViewUp()

    // 서치바 추가 ✅
    @objc optional func addSearchBar()
}
