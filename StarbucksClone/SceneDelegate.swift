//
//  SceneDelegate.swift
//  StarbucksClone
//
//  Created by 김지수 on 2022/11/28.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    var tempImage: UIImageView?
    let noti = UNUserNotificationCenter.current()
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        requestAuthNotification()
        self.window = UIWindow(windowScene: scene as! UIWindowScene)
        let story = UIStoryboard(name: "Main", bundle: nil)
        
        if UserDefaults.standard.bool(forKey: "isOnBoarding") == false {
            // 키가 존재하지 않으면 false = 첫 실행
            print("첫 실행이야")
            guard let vc = story.instantiateViewController(withIdentifier: "OnBordingViewController") as? OnBordingViewController else { return }
            self.window?.rootViewController = vc
            self.window?.makeKeyAndVisible()
            UserDefaults.standard.set(true, forKey: "isOnBoarding")
            
            // 이 부분은 테스트를 위한 value값 제거 코드🔥
            UserDefaults.standard.removeObject(forKey: "isOnBoarding")
        } else {
            // 키가 존재하면 true = 첫 실행 아님
            print("첫 실행 아니야")
            guard let vc = story.instantiateViewController(withIdentifier: "homeTabBar") as? UITabBarController else { return }
            self.window?.rootViewController = vc
            self.window?.makeKeyAndVisible()
            
            // 이 부분은 테스트를 위한 value값 제거 코드🔥
            UserDefaults.standard.removeObject(forKey: "isOnBoarding")
        }
        guard let _ = (scene as? UIWindowScene) else { return }
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        guard let image = tempImage else { return }
        image.removeFromSuperview()
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        guard let window = window else { return }
        tempImage = UIImageView(frame: window.frame)
        tempImage?.image = UIImage(named: "tempImage")
        window.addSubview(tempImage!)
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        print("백그라운드에서 복귀함")
        sendOrderAlert()
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        
        // 탭바 컨트롤러 내부 VC가 Order네비게이션컨트롤러 라면, 노티 전송
        if isOrderStatus() == true {
            requestSendNotification(title: "흠🤔🔥", body: "진행중인 주문이 있는데요?? 다시 돌아오세요!", seconds: 0.1)
        }
    }
    
    //MARK: -ORDER 상태인지 확인하는 함수
    func isOrderStatus() -> Bool {
        // 현재 VC - UI탭바컨트롤러
        guard let vc = window?.rootViewController?.presentedViewController as? UITabBarController else { return false }
        
        // 탭바 컨트롤러 내부 VC가 Order 네비게이션컨트롤러 라면 true
        if vc.selectedViewController is OrderNavigationController {
            return true
        } else {
            return false
        }
    }
    
    func sendOrderAlert() {
        guard let vc = window?.rootViewController?.presentedViewController as? UITabBarController else { return }
        if vc.selectedViewController is OrderNavigationController {
            
            // alert
            let alert = UIAlertController(title: "진행중인 주문이 있네요", message: "주문을 이어서 하시겠어요?", preferredStyle: .alert)
            
            let action = UIAlertAction(title: "네", style: .default) { action in
                print("네! 가 눌렸어")
            }
            let cancel = UIAlertAction(title: "홈으로", style: .default) { action in
                guard let naviVC = vc.selectedViewController as? OrderNavigationController else { return }
                
                // 아래 두개를 같이 쓰고 싶은데
                // 따로 쓰면 잘 되는데
                // 같이 쓰면 탭바가 사라져요 .. 왜 ?
//                naviVC.popToRootViewController(animated: true) // 네비게이션 VC Root로
                vc.selectedIndex = 0 // Home 탭바로
                
                guard let homeVC = vc.selectedViewController as? HomeViewController else { return }
                homeVC.tabBarController?.tabBar.isHidden = false
            }
            
            alert.addAction(cancel)
            alert.addAction(action)
            vc.selectedViewController?.present(alert, animated: true)
        }
    }
    
    //MARK: -Notification 관련
    
    // 노티 권한 요청
    func requestAuthNotification() {
        let notificationAuthOptions = UNAuthorizationOptions(arrayLiteral: [.alert, .badge, .sound])
        noti.requestAuthorization(options: notificationAuthOptions) { success, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    // 노티를 보내줘
    func requestSendNotification(title: String, body: String, seconds: Double) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: seconds, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        noti.add(request) { error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    //MARK: -현재 VC
//    private func getCurrentViewController() -> UIViewController? {
//        if let rootViewController = UIApplication.shared.windows.first?.rootViewController {
//
//            if let presentedViewController = rootViewController.presentedViewController {
//                return presentedViewController
//            }
//            return rootViewController
//        }
//        return nil
//    }
}

