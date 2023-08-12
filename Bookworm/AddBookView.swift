//
//  AddBookView.swift
//  Bookworm
//
//  Created by Alex Nguyen on 2023-06-28.
//

import SwiftUI

struct AddBookView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    @State private var title = ""
    @State private var author = ""
    @State private var rating = 2
    @State private var genre = "Thriller"
    @State private var review = ""
    
    let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]
    
    @State private var showingEmptyAlert = false
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Name of book", text: $title)
                    TextField("Author", text: $author)
                    
                    Picker("Genre", selection: $genre) {
                        ForEach(genres, id: \.self) {
                            Text($0)
                        }
                    }
                }
                
                Section {
                    TextEditor(text: $review)
                    HStack {
                        EmojiRating(rating: Int16(rating))
                        RatingView(rating: $rating)
                    }
                } header: {
                    Text("Write a review")
                }
                
                Section {
                    Button("Save") {
                        if title.trimmingCharacters(in: .whitespacesAndNewlines) == "" || author.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
                            showingEmptyAlert = true
                        } else {
                            let newBook = Book(context: moc)
                            newBook.id = UUID()
                            newBook.title = title.trimmingCharacters(in: .whitespacesAndNewlines)
                            newBook.author = author.trimmingCharacters(in: .whitespacesAndNewlines)
                            newBook.genre = genre
                            newBook.rating = Int16(rating)
                            newBook.review = review
                            newBook.dateadded = Date.now
                            
                            try? moc.save()
                            dismiss()
                        }
                    }
                    .disabled(title.isEmpty || author.isEmpty)
                }
            }
            .navigationTitle("Add Book")
            .alert("Warning!", isPresented: $showingEmptyAlert) {
                Button("OK") {}
            } message: {
                Text("Can't be empty!")
            }
        }
    }
}

struct AddBookView_Previews: PreviewProvider {
    static var previews: some View {
        AddBookView()
    }
}
