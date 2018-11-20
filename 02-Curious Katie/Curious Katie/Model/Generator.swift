//
//  Generator.swift
//  Curious Katie
//
//  Created by Rafal Padberg on 08.11.18.
//  Copyright © 2018 Rafal Padberg. All rights reserved.
//

import Foundation

// Generator struct is responsible to generate data. Names, interests names, cities, nationalities and interest extra description
struct Generator
{
    let interests: [String] = [
        "Sport", "Gaming", "Programming", "Science", "Music", "Art", "Writing", "Sightseeing", "Cooking", "Animals"
    ]
    
    private let maleNames: [String] = [
        "James", "John", "Robert", "Michael", "William", "David", "Richard", "Joseph", "Thomas", "Charles", "Christopher", "Daniel", "Matthew", "Anthony", "Donald", "Mark", "Paul", "Steven", "Andrew", "Kenneth", "George", "Joshua", "Kevin", "Brian", "Edward", "Ronald", "Timothy", "Jason", "Jeffrey", "Ryan", "Jacob", "Gary", "Nicholas", "Eric", "Stephen", "Jonathan", "Larry", "Justin", "Scott", "Brandon", "Frank", "Benjamin", "Gregory", "Raymond", "Samuel", "Patrick", "Alexander", "Jack", "Dennis", "Jerry", "Tyler", "Aaron", "Henry", "Jose", "Douglas", "Peter", "Adam", "Nathan", "Zachary", "Walter", "Kyle", "Harold", "Carl", "Jeremy", "Gerald", "Keith", "Roger", "Arthur", "Terry", "Lawrence", "Sean", "Christian", "Ethan", "Austin", "Joe", "Albert", "Jesse", "Willie", "Billy", "Bryan", "Bruce", "Noah", "Jordan", "Dylan", "Ralph", "Roy", "Alan", "Wayne", "Eugene", "Juan", "Gabriel", "Louis", "Russell", "Randy", "Vincent", "Philip", "Logan", "Bobby", "Harry", "Johnny"
    ]
    
    private let femaleNames: [String] = [
        "Mary", "Patricia", "Jennifer", "Linda", "Elizabeth", "Barbara", "Susan", "Jessica", "Sarah", "Margaret", "Karen", "Nancy", "Lisa", "Betty", "Dorothy", "Sandra", "Ashley", "Kimberly", "Donna", "Emily", "Carol", "Michelle", "Amanda", "Melissa", "Deborah", "Stephanie", "Rebecca", "Laura", "Helen", "Sharon", "Cynthia", "Kathleen", "Amy", "Shirley", "Angela", "Anna", "Ruth", "Brenda", "Pamela", "Nicole", "Katherine", "Samantha", "Christine", "Catherine", "Virginia", "Debra", "Rachel", "Janet", "Emma", "Carolyn", "Maria", "Heather", "Diane", "Julie", "Joyce", "Evelyn", "Joan", "Victoria", "Kelly", "Christina", "Lauren", "Frances", "Martha", "Judith", "Cheryl", "Megan", "Andrea", "Olivia", "Ann", "Jean", "Alice", "Jacqueline", "Hannah", "Doris", "Kathryn", "Gloria", "Teresa", "Sara", "Janice", "Marie", "Julia", "Grace", "Judy", "Theresa", "Madison", "Beverly", "Denise", "Marilyn", "Amber", "Danielle", "Rose", "Brittany", "Diana", "Abigail", "Natalie", "Jane", "Lori", "Alexis", "Tiffany", "Kayla"
    ]
    
    private let cities: [String] = [
        "Hong Kong", "Singapore", "Bangkok", "London", "Macau", "Kuala Lumpur", "Shenzhen", "New York City", "Antalya", "Paris", "Istanbul", "Rome", "Dubai", "Guangzhou", "Phuket", "Mecca", "Pattaya", "Taipei City", "Prague", "Shanghai", "Las Vegas", "Miami", "Barcelona", "Moscow", "Beijing", "Los Angeles", "Budapest", "Vienna", "Amsterdam", "Sofia", "Madrid", "Orlando", "Ho Chi Minh City", "Lima", "Berlin", "Tokyo", "Warsaw", "Chennai", "Cairo", "Nairobi", "Hangzhou", "Milan", "San Francisco", "Buenos Aires", "Venice", "Mexico City", "Dublin", "Seoul", "Mugla", "Mumbai", "Denpasar", "Delhi", "Toronto", "Zhuhai", "St Petersburg", "Burgas", "Sydney", "Djerba", "Munich", "Johannesburg", "Cancun", "Edirne", "Suzhou", "Bucharest", "Punta Cana", "Agra", "Jaipur", "Brussels", "Nice", "Chiang Mai", "Hamburg", "Lisbon", "Cork", "Marrakech", "Jakarta", "Manama", "Hanoi", "Honolulu", "Manila", "Guilin", "Auckland", "Cracow", "Gorzów Wielkopolski", "Amman", "Vancouver", "Abu Dhabi", "Kiev", "Doha", "Florence", "Rio de Janeiro", "Melbourne", "Washington D.C.", "Riyadh", "Christchurch", "Frankfurt", "Baku", "Sao Paulo", "Harare", "Kolkata", "Nanjing"
    ]
    
    private let nationalities: [String] = [
        "Afghan", "Albanian", "Algerian", "Argentinian", "Australian", "Austrian", "Bangladeshi", "Belgian", "Bolivian", "Batswana", "Brazilian", "Bulgarian", "Cambodian", "Cameroonian", "Canadian", "Chilean", "Chinese", "Colombian", "Costa Rican", "Croatian", "Cuban", "Czech", "Danish", "Dominican", "Ecuadorian", "Egyptian", "Salvadorian", "English", "Estonian", "Ethiopian", "Fijian", "Finnish", "French", "German", "Ghanaian", "Greek", "Guatemalan", "Haitian", "Honduran", "Hungarian", "Icelandic", "Indian", "Indonesian", "Iranian", "Iraqi", "Irish", "Israeli", "Italian", "Jamaican", "Japanese", "Jordanian", "Kenyan", "Kuwaiti", "Lao", "Latvian", "Lebanese", "Libyan", "Lithuanian", "Malaysian", "Malian", "Maltese", "Mexican", "Mongolian", "Moroccan", "Mozambican", "Namibian", "Nepalese", "Dutch", "New Zealand", "Nicaraguan", "Nigerian", "Norwegian", "Pakistani", "Panamanian", "Paraguayan", "Peruvian", "Philippine", "Polish", "Portuguese", "Romanian", "Russian", "Saudi", "Scottish", "Senegalese", "Serbian", "Singaporean", "Slovak", "South African", "Korean", "Spanish", "Sri Lankan", "Sudanese", "Swedish", "Swiss", "Syrian", "Taiwanese", "Tajikistani", "Thai", "Tongan", "Tunisian", "Turkish", "Ukrainian", "Emirati", "British", "American", "Uruguayan", "Venezuelan", "Vietnamese", "Welsh", "Zambian", "Zimbabwean"
    ]
    
    private let interestsExtras: [Int : [String]] = [
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
    
    func getName(male: Bool) -> String
    {
        let random = Int.random(in: 0 ..< (male ? maleNames.count : femaleNames.count))
        return male ? maleNames[random] : femaleNames[random]
    }
    
    func getCity() -> String
    {
        let random = Int.random(in: 0 ..< cities.count)
        return cities[random]
    }
    
    func getNationality() -> String
    {
        let random = Int.random(in: 0 ..< nationalities.count)
        return nationalities[random]
    }
    
    func getInterestExtra(id: Int) -> String {
        let random = Int.random(in: 0 ..< 10)
        return interestsExtras[id]![random]
    }
    
    func getInterest(id: Int) -> String {
        return interests[id]
    }
}
