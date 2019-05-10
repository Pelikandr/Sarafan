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
    private(set) var EventInfo: [String] = []

    func append(_ newEvent: String, newEventInfo: String) {
        self.eventList.append(newEvent)
        self.EventInfo.append(newEventInfo)
    }

    func set(_ newEventsList: [String], newEventInfoList: [String]) {
        self.eventList = newEventsList
        self.EventInfo = newEventInfoList
    }

    func clear() {
        self.eventList.removeAll()
        self.EventInfo.removeAll()
    }
}
