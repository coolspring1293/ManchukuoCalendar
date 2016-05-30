//
//  File.swift
//  ManchukuoCalendar
//
//  Created by Kieran Will on 5/30/16.
//  Copyright © 2016 Wang Liu. All rights reserved.
//

import Cocoa
import ServiceManagement

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var statusMenu: NSMenu!
    @IBOutlet weak var loginOnStartupItem: NSMenuItem!
    var statusItem: NSStatusItem?

    func applicationDidFinishLaunching(aNotification: NSNotification) {
        statusItem = NSStatusBar.systemStatusBar().statusItemWithLength(NSVariableStatusItemLength)
        statusItem?.menu = statusMenu
        statusItem?.highlightMode = true
        
        loginOnStartupItem.state = NSBundle.mainBundle().isLoginItem() ? NSOnState : NSOffState
        
        fetch()
        NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(AppDelegate.fetch), userInfo: nil, repeats: true)
    }
    
    func fetch() {        
        let date = NSDate()
        let timeFormatter = NSDateFormatter()
        timeFormatter.dateFormat = "大清满洲康德八十二年M月dd日 HH:mm:ss"
        let strNowTime = timeFormatter.stringFromDate(date) as String
        self.statusItem?.title = strNowTime
    }
    
    @IBAction func toggleLoginOnStartup(menuItem: NSMenuItem) {
        menuItem.state = menuItem.state == NSOnState ? NSOffState : NSOnState
        
        if menuItem.state == NSOnState {
            NSBundle.mainBundle().addToLoginItems()
        } else {
            NSBundle.mainBundle().removeFromLoginItems()
        }
    }
    
    @IBAction func quit(menuItem: NSMenuItem) {
        NSApplication.sharedApplication().terminate(self)
    }
}

