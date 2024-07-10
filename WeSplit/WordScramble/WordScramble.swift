//
//  WordScramble.swift
//  WeSplit
//
//  Created by QinY on 9/7/2024.
//

import SwiftUI

struct WordScramble: View {
    
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    @State private var errorTitle = ""
    @State private var errorMessgae = ""
    @State private var showingError = false
    
    var body: some View {
        NavigationStack {
            List {
                Section{
                    TextField("Enter your word",text: $newWord)
                        
                }
                .textInputAutocapitalization(.never)
                .onSubmit() {
                    addNewWord()
                }
                
                
                Section {
                    ForEach (usedWords,id: \.self){ word in
                        HStack {
                            Image(systemName: "\(word.count).circle")
                            Text(word)
                        }
                        
                    }
                }
            }
            .navigationTitle(rootWord)
            //MARK: - challenge
            .toolbar{
                Button("startGame") {
                    startGame()
                }
            }
        }.onAppear(perform: {
            startGame()
        })
        .alert(errorTitle, isPresented: $showingError) {
            Button("ok"){}
        } message: {
            Text(errorMessgae)
        }
    }
    
    
//    functions
    
    func isOriginal(word:String) -> Bool {
        !usedWords.contains(word)
    }
    
    func isPossible(word:String) -> Bool {
        var temWord = rootWord
        
        for letter in word {
            if let pos = temWord.firstIndex(of: letter){
                temWord.remove(at: pos)
            }else{
                return false
            }
        }
        return true
    }
    
    func isReal(word:String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        return misspelledRange.location == NSNotFound
    }
    
    func addNewWord(){
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        guard answer.count > 0 else { return}
        //MARK: - challenge
        guard answer.count > 3 else {
            errorInfo(title: "Answer too short", message: "Answer must longer than three letters")
            return
        }
        
        withAnimation{
            usedWords.insert(answer, at: 0)
        }
        newWord = ""
        
        guard isOriginal(word: answer) else {
            errorInfo(title: "Word used already", message: "Be more original")
            return
        }
        
        guard isPossible(word: answer) else {
            errorInfo(title: "Word not possible", message: "you can't speel that word from '\(rootWord)'")
            return
        }
        guard isReal(word: answer) else {
            errorInfo(title: "Word not recoginzed", message: "you can't just make them up")
            return
        }
    }
    
    func startGame(){
        
        if newWord.count != 0 {
            newWord = ""
        }
//     1.find the url for start.txt in app bundle
        if let  startWordURL = Bundle.main.url(forResource: "start", withExtension: "txt"){
//            2.Load start.txt into a string
            if let startWords = try?String(contentsOf: startWordURL){
//                3.splite the string up into an array of string,slitting on line break
                let allWord = startWords.components(separatedBy: "\n")
//                4.Pick one random word ,or user "silkworn" as a sensible default
                rootWord = allWord.randomElement() ?? "silkworm"
                print(rootWord)
                return
            }
        }
//        if problem ,trigger a crash and report
        fatalError("Could not load start.txt from bundle")
    }
    
    
    func errorInfo(title:String,message:String){
        errorTitle = title
        errorMessgae = message
        showingError = true
    }
}

#Preview {
    WordScramble()
}
