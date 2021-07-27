//
//  ViewOutput.swift
//  Stoloto
//
//  Created by Maxim Smirnov on 29/01/2018.
//  Copyright © 2018 Finch. All rights reserved.
//

import Foundation

protocol ViewOutput: AnyObject {
    func viewIsReady()
    func viewWillAppear()
    func viewDidAppear()
    func viewDidDisappear()
    func viewWillDisappear()
}

extension ViewOutput {
    func viewWillAppear() { }
    func viewWillDisappear() { }
    func viewDidAppear() { }
    func viewDidDisappear() { }
}
