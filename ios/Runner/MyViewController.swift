//
//  MyViewController.swift
//  Runner
//
//  Created by Sebastian Roth on 30/06/2020.
//

import UIKit

import Flutter.FlutterViewController

class MyViewController: FlutterViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Initially, I believed starting the metal capture manually would help.
        // Turns out adding the empty metal file instead helped to enable the GPU frame capture.
        // Will keep the code in for reference.
//        if #available(iOS 13.0, *) {
//          triggerProgrammaticMetalCapture()
//        }
    }
}
