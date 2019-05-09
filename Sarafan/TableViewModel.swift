//
//  TableViewModel.swift
//  Sarafan
//
//  Created by Denis Zayakin on 4/20/19.
//  Copyright © 2019 Denis Zayakin. All rights reserved.
//
import UIKit
import Firebase
import FirebaseDatabase
import Foundation

//Singleton
class DataSource {

    static var shared = DataSource()

    private(set) var eventList: [String] = []

    func append(_ newEvent: String) {
        self.eventList.append(newEvent)
    }

    func set(_ newEventsList: [String]) {
        self.eventList = newEventsList
    }

    func clear() {
        self.eventList.removeAll()
    }
}
