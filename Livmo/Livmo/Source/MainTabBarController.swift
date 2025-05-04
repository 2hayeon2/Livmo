//
//  MainTabBarController.swift
//  Livmo
//
//  Created by hayeon lee on 5/4/25.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs()
    }

    private func setupTabs() {
        let blockAddVC = BlockAddViewController()
        let blockAddNav = UINavigationController(rootViewController: blockAddVC)
        blockAddNav.tabBarItem = UITabBarItem(title: "Block", image: UIImage(systemName: "cube"), tag: 0)

        let dayAddVC = DayAddViewController()
        let dayAddNav = UINavigationController(rootViewController: dayAddVC)
        dayAddNav.tabBarItem = UITabBarItem(title: "Day", image: UIImage(systemName: "sun.max"), tag: 1)
//        let todayVC = TodayViewController()
//        todayVC.tabBarItem = UITabBarItem(title: "Today", image: UIImage(systemName: "sun.max"), tag: 1)

//        let settingsVC = SettingsViewController()
//        settingsVC.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "gear"), tag: 2)

        viewControllers = [blockAddNav, dayAddNav]
    }
}

#if DEBUG
import SwiftUI

struct MainTabBarController_Preview: PreviewProvider {
    static var previews: some View {
        NavigationViewWrapper()
            .previewDevice("iPhone 15 Pro")
    }

    struct NavigationViewWrapper: UIViewControllerRepresentable {
        func makeUIViewController(context: Context) -> UINavigationController {
            let vc = MainTabBarController()
            let nav = UINavigationController(rootViewController: vc)
            nav.setNavigationBarHidden(false, animated: false)
            return nav
        }

        func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {}
    }
}
#endif
