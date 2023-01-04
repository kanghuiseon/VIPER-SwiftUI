//
//  MainTab.swift
//  VIPER-Swift
//
//  Created by 강희선 on 2022/09/16.
//

import SwiftUI
import Swinject

struct MainTab: View {
    @State private var selectedTab: String = Tab.home.id
    let container: Container
    
    init(_ container: Container) {
        self.container = container
    }
    
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView(.init(container: container))
                .tabItem {
                    Image(Tab.home.imageName)
                }
                .tag(Tab.home.id)
            
            LibraryView(.init())
                .tabItem {
                    Image(Tab.library.imageName)
                }
                .tag(Tab.library.id)
            
            CharacterView()
                .tabItem {
                    Image(Tab.character.imageName)
                }
                .tag(Tab.character.id)
            
            HistoryView()
                .tabItem {
                    Image(Tab.history.imageName)
                }
                .tag(Tab.history.id)
            
            ProfileView()
                .tabItem {
                    Image(Tab.profile.imageName)
                }
                .tag(Tab.profile.id)
        }
        .accentColor(.pink)
    }
}

extension MainTab {
    enum Tab {
        case home
        case library
        case character
        case history
        case profile
        
        var id: String {
            switch self {
            case .home: return "tab.home"
            case .library: return "tab.library"
            case .character: return "tab.character"
            case .history: return "tab.history"
            case .profile: return "tab.profile"
            }
        }
        
        var imageName: String {
            switch self {
            case .home: return "home"
            case .library: return "book"
            case .character: return "superhero"
            case .history: return "pencil"
            case .profile: return "user"
            }
        }
    }
}

struct MainTab_Previews: PreviewProvider {
    static var previews: some View {
        MainTab(.preview)
    }
}
