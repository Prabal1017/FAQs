//
//  ContentView.swift
//  FAQs
//
//  Created by Prabal Kumar on 16/12/24.
//

import SwiftUI

struct ContentView: View {
    @State private var searchTerm = ""
    
    // Filtered questions based on the search term
    var filteredQuestions: [Question] {
        if searchTerm.isEmpty {
            return questions
        } else {
            return questions.filter {
                $0.title.localizedCaseInsensitiveContains(searchTerm) ||
                $0.answer.localizedCaseInsensitiveContains(searchTerm)
            }
        }
    }
    
    var body: some View {
        NavigationStack {
            ScrollView{
            VStack(spacing: 20) {
                
                // Filtered questions
                ForEach(filteredQuestions, id: \.id) { question in
                    QuestionView(question: question)
                }
                
                // Footer
                VStack(spacing: 10) {
                    Image(systemName: "questionmark.circle")
                        .font(.largeTitle)
                    
                    Text("Still have questions?")
                        .font(.headline)
                    
                    Text("Contact us and we'll respond to your request.")
                        .foregroundColor(.secondary)
                    
                    Link("Contact Support", destination: URL(string: "https://www.example.com/support")!)
                        .font(.headline)
                }
            }
            .padding()
            .padding(.bottom, 20)
        }
            .navigationTitle("FAQs")
    }
        
        .searchable(text: $searchTerm, prompt: "Search Questions")
}
}

struct QuestionView: View {
    @State private var isExpanded = false
    var question: Question
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text(question.title)
                    .font(.headline)
                    .padding(.leading)
                    .padding()
                
                Spacer()
                
                Button{
                    withAnimation(.easeInOut(duration: 0.3)) {
                        isExpanded.toggle()
                    }
                } label:{
                    Image(systemName: isExpanded ? "chevron.down" : "chevron.right")
                        .frame(width: 0, height:44)
                        .font(.title3)
                        .foregroundColor(.gray)
                        .padding(.trailing)
                        .padding(.trailing)
                }
            }
            
            if isExpanded {
                Divider()
                
                Text(question.answer)
                    .font(.body)
                    .padding(.leading)
                    .padding(.top, 5)
                    .padding()
                    .transition(.opacity)
            }
        }
        .padding(.vertical, 5)
        .background(RoundedRectangle(cornerRadius: 10).fill(Color.gray.opacity(0.2)))
    }
}

struct Question: Identifiable {
    var id = UUID()
    var title: String
    var answer: String
}

let questions = [
    Question(title: "How do I reset my password?", answer: "To reset your password, go to the login screen and click on 'Forgot Password.' Follow the instructions to reset it."),
    Question(title: "Where can I find the app settings?", answer: "You can find the app settings by tapping on the gear icon located in the top-right corner of the home screen."),
    Question(title: "Can I customize the app theme?", answer: "Yes, you can customize the app theme by going to Settings > Appearance and selecting your preferred theme."),
    Question(title: "How do I contact customer support?", answer: "You can contact customer support by navigating to the Help section and selecting 'Contact Support.'"),
    Question(title: "How can I update my profile information?", answer: "To update your profile, go to the Profile tab and click on the 'Edit' button. Make the necessary changes and save."),
    Question(title: "Why is my app not syncing?", answer: "Ensure that you have a stable internet connection. If the issue persists, try restarting the app or checking the sync settings."),
    Question(title: "What features are available in the free version?", answer: "The free version includes basic functionality such as viewing content, browsing categories, and accessing support. Upgrade to premium for additional features.")
]


#Preview {
    ContentView()
}
