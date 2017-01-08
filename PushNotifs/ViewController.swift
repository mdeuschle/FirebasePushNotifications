//
//  ViewController.swift
//  PushNotifs
//
//  Created by Matt Deuschle on 1/7/17.
//  Copyright © 2017 Matt Deuschle. All rights reserved.
//

import UIKit
import Firebase
import FirebaseInstanceID
import FirebaseMessaging

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        FIRMessaging.messaging().subscribe(toTopic: "/topics/news")
    }



}

