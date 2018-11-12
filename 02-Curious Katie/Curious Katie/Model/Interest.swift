//
//  Interest.swift
//  Curious Katie
//
//  Created by Rafal Padberg on 08.11.18.
//  Copyright © 2018 Rafal Padberg. All rights reserved.
//

import Foundation

struct Interests
{
    let interests: [String] = [
        "Sport", "Gaming", "Programming", "Science", "Music", "Art", "Writing", "Sightseeing", "Cooking", "Animals"
    ]
    
    let interestsExtras: [Int : [String]] = [
        0 : [
            "Football", "American Football", "Basketball", "Martial Arts", "Extreme Sports", "Speedway", "FC Bayern! Stern des Südens", "Boxing", "Olympics Fan", "Bruce Lee KungFu Karate Master"
        ],
        1 : [
            "League of Legends", "Civilization", "Elder Scrolls Fan", "My name is Gerald from Rivia", "Playstation is all I need", "Forza", "Final Fantasy ", "Factorio will steal your life", "EA Sports it’s in the game", "Tetris"
        ],
        2 : [
            "Delphi is dead", "I like Python, but not the animal", "Me is liking C", "Swift obviously", "Java", "Kotlin", "JavaScript", "PHP and Laravel", "R you familiar with R", "I am pro Programmer, I know HTML 4 and 5 and CSS"
        ],
        3 : [
            "Astronomy", "Physics", "I watch Discovery Channel a LOT", "Math is King", "Nikola Tesla is my hero", "E = mc2", "What is the speed of light?", "ein Albert, ein Stein", "Science is new Religion", "I am more into medicine"
        ],
        4 : [
            "We don’t need no education", "I love Justin Bieber", "Rock and Roll", "Techno fan", "Hip Hop", "Mozart and Chopin", "I can play a Guitar", "Let me get my keyboard…", "Metallica", "Who won last years EuroVision contest, was is Australia?…"
        ],
        5 : [
            "I like to draw", "Michelangelo", "Mona Lisa", "Vincent van Gogh", "Scream", "Black is not a color!", "I had my pencil somewhere", "I am soaked in paint", "No it’s not blue is COBALT", "I paint in shades of grey ‘cause I am a daltonist"
        ],
        6 : [
            "William Shakespeare", "I know the whole Alphabet!", "I have so many pens", "I just need to take a note", "My next essay will be on….", "I am a left hander", "A complete sentence need to end with.", "I can write in chinese", "Calligraphy", "Where is my ink?"
        ],
        7 : [
            "I have been to America last year", "Those pyramids are amazing", "I like forests", "India", "Mexico City is so huge", "What’s the capital of Greece?", "Eiffel Tower", "Been there, done that", "Look at the sky!", "Brazil is nice"
        ],
        8 : [
            "I like to cook", "My favourite vegetable is a Potato", "I need to drink wine when I eat", "It look tasty!", "I like Asian foods", "Mexican foods is hot and tasty", "I watch Hell’s Kitchen every week", "Pepper or Salt?", "Sushi!", "There are two groups of humans. First group eats to live, second one lives to eat."
        ],
        9 : [
            "Are you a dog or cat person", "I am strong as a bear", "I used to have a hamster", "Lassi come home", "Is it a bird?", "What is the biggest animal on the planet?", "I am an animal of type Homo sapiens sapiens", "I take my dog fore a walk, I will be back in 30 minutes", "Which Australian animals cannot kill you?", "My zodiac animal is a lion."
        ]
    ]
    
    func generateRandom(id: Int) -> String
    {
        let random = Int.random(in: 0 ..< 10)
        return interestsExtras[id]![random]
    }
}
