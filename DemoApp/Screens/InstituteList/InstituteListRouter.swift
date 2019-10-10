//
//  InstituteListRouter.swift
//  ProntoSoccorsoKit
//
//  Created by Matteo Pacini on 10/10/2019.
//  Copyright (c) 2019 Matteo Pacini. All rights reserved.

import UIKit

final class InstituteListRouter: InstituteListDataPassing { 
  
    weak var viewController: InstituteListViewController?
    var dataStore: InstituteListDataStore?

}

// MARK: - InstituteListRouterType 

extension InstituteListRouter: InstituteListRouterType {

}
