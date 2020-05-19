//
//  SettingViewController.swift
//  90's
//
//  Created by 홍정민 on 2020/04/26.
//  Copyright © 2020 홍정민. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {
    @IBOutlet weak var settingTableView: UITableView!
    var noticeList = ["마케팅 이벤트 알림","앨범 기간 알림", "앨범이 종료되기 전 알림", "구매 및 배송 알림"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        
    }
    
    @IBAction func goBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    func setUI(){
        settingTableView.dataSource = self
        settingTableView.delegate = self
    }
    
}

extension SettingViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return noticeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingCell") as! SettingCell
        cell.settingNameLabel.text = noticeList[indexPath.row]
        cell.delegate = self
        cell.currentIndex = indexPath.row
        return cell
    }
    
    
}

extension SettingViewController: SwitchActionDelegate {
    
    func didClickedLink(index: Int) {
        
        print("Clicked")
        //알람 트리거 설정
        let content = UNMutableNotificationContent()
        //APN form
        if noticeList[index] == "마케팅 이벤트 알림" {
            content.title = "90s"
            content.body = noticeList[index]
            content.badge = 1
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats:false)
            let request = UNNotificationRequest(identifier: "timerdone", content: content, trigger: trigger)
            UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        }
        //이건 모르겠는뎅....
        else if noticeList[index] == "앨범 기간 알림" {
            content.title = "90s"
            content.body = noticeList[index]
            content.badge = 1
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats:false)
            let request = UNNotificationRequest(identifier: "timerdone", content: content, trigger: trigger)
            UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        }
        //알람 트리거로 해결 가능. 앨범 만든 날짜 , timeInterval 이용
        else if noticeList[index] == "앨범이 종료되기 전 알림" {
            content.title = "90s"
            content.body = noticeList[index]
            content.badge = 1
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats:false)
            let request = UNNotificationRequest(identifier: "timerdone", content: content, trigger: trigger)
            UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        }
        //APN form
        else if noticeList[index] == "구매 및 배송 알림" {
            content.title = "90s"
            content.body = noticeList[index]
            content.badge = 1
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats:false)
            let request = UNNotificationRequest(identifier: "timerdone", content: content, trigger: trigger)
            UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        }
        
    }
    
}

