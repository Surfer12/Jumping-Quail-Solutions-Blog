////
////  RecursiveBlogUIApp.swift
////  Jumping Quail Solutions Blog
////
////  Created by Ryan David Oates on 7/22/25.
////
//
////
////That's fantastic.. a swift live dashboard showing drift alerts and filter activations // RecursiveBlogProject: Swift App + Backend Integration Blueprint
//
//import SwiftUI
//
//@main
//struct RecursiveBlogUIApp: App {
//    var body: some Scene {
//        WindowGroup {
//            ContentView()
//        }
//    }
//}
//
//// MARK: - ContentView
//struct ContentView: View {
//    var body: some View {
//        NavigationView {
//            BlogPostListView()
//                .navigationTitle("Recursive Blog")
//        }
//    }
//}
//
//// MARK: - BlogPostListView
//struct BlogPostListView: View {
//    @State private var posts: [BlogPost] = []
//
//    var body: some View {
//        List(posts) { post in
//            NavigationLink(destination: BlogPostDetailView(post: post)) {
//                Text(post.title)
//            }
//        }
//        .onAppear {
//            loadPosts()
//        }
//    }
//
//    func loadPosts() {
//        // Placeholder for backend fetch
//        // Will integrate Supabase API fetch here
//    }
//}
//
//// MARK: - BlogPostDetailView
//struct BlogPostDetailView: View {
//    let post: BlogPost
//
//    var body: some View {
//        ScrollView {
//            VStack(alignment: .leading, spacing: 16) {
//                Text(post.title)
//                    .font(.title)
//                Text(post.body_md)
//                    .font(.body)
//            }
//            .padding()
//        }
//        .navigationTitle(post.title)
//    }
//}
//
//// MARK: - BlogPost Model
//struct BlogPost: Identifiable, Codable {
//    let id: UUID
//    let title: String
//    let body_md: String
//    let published_at: Date
//}
