//
//  Generator.swift
//  Curious Katie
//
//  Created by Rafal Padberg on 08.11.18.
//  Copyright © 2018 Rafal Padberg. All rights reserved.
//

import Foundation

struct Generator
{
    let maleNames: [String] = [
        "James", "John", "Robert", "Michael", "William", "David", "Richard", "Joseph", "Thomas", "Charles", "Christopher", "Daniel", "Matthew", "Anthony", "Donald", "Mark", "Paul", "Steven", "Andrew", "Kenneth", "George", "Joshua", "Kevin", "Brian", "Edward", "Ronald", "Timothy", "Jason", "Jeffrey", "Ryan", "Jacob", "Gary", "Nicholas", "Eric", "Stephen", "Jonathan", "Larry", "Justin", "Scott", "Brandon", "Frank", "Benjamin", "Gregory", "Raymond", "Samuel", "Patrick", "Alexander", "Jack", "Dennis", "Jerry", "Tyler", "Aaron", "Henry", "Jose", "Douglas", "Peter", "Adam", "Nathan", "Zachary", "Walter", "Kyle", "Harold", "Carl", "Jeremy", "Gerald", "Keith", "Roger", "Arthur", "Terry", "Lawrence", "Sean", "Christian", "Ethan", "Austin", "Joe", "Albert", "Jesse", "Willie", "Billy", "Bryan", "Bruce", "Noah", "Jordan", "Dylan", "Ralph", "Roy", "Alan", "Wayne", "Eugene", "Juan", "Gabriel", "Louis", "Russell", "Randy", "Vincent", "Philip", "Logan", "Bobby", "Harry", "Johnny"
    ]
    
    let femaleNames: [String] = [
        "Mary", "Patricia", "Jennifer", "Linda", "Elizabeth", "Barbara", "Susan", "Jessica", "Sarah", "Margaret", "Karen", "Nancy", "Lisa", "Betty", "Dorothy", "Sandra", "Ashley", "Kimberly", "Donna", "Emily", "Carol", "Michelle", "Amanda", "Melissa", "Deborah", "Stephanie", "Rebecca", "Laura", "Helen", "Sharon", "Cynthia", "Kathleen", "Amy", "Shirley", "Angela", "Anna", "Ruth", "Brenda", "Pamela", "Nicole", "Katherine", "Samantha", "Christine", "Catherine", "Virginia", "Debra", "Rachel", "Janet", "Emma", "Carolyn", "Maria", "Heather", "Diane", "Julie", "Joyce", "Evelyn", "Joan", "Victoria", "Kelly", "Christina", "Lauren", "Frances", "Martha", "Judith", "Cheryl", "Megan", "Andrea", "Olivia", "Ann", "Jean", "Alice", "Jacqueline", "Hannah", "Doris", "Kathryn", "Gloria", "Teresa", "Sara", "Janice", "Marie", "Julia", "Grace", "Judy", "Theresa", "Madison", "Beverly", "Denise", "Marilyn", "Amber", "Danielle", "Rose", "Brittany", "Diana", "Abigail", "Natalie", "Jane", "Lori", "Alexis", "Tiffany", "Kayla"
    ]
    
    let cities: [String] = [
        "Hong Kong", "Singapore", "Bangkok", "London", "Macau", "Kuala Lumpur", "Shenzhen", "New York City", "Antalya", "Paris", "Istanbul", "Rome", "Dubai", "Guangzhou", "Phuket", "Mecca", "Pattaya", "Taipei City", "Prague", "Shanghai", "Las Vegas", "Miami", "Barcelona", "Moscow", "Beijing", "Los Angeles", "Budapest", "Vienna", "Amsterdam", "Sofia", "Madrid", "Orlando", "Ho Chi Minh City", "Lima", "Berlin", "Tokyo", "Warsaw", "Chennai", "Cairo", "Nairobi", "Hangzhou", "Milan", "San Francisco", "Buenos Aires", "Venice", "Mexico City", "Dublin", "Seoul", "Mugla", "Mumbai", "Denpasar", "Delhi", "Toronto", "Zhuhai", "St Petersburg", "Burgas", "Sydney", "Djerba", "Munich", "Johannesburg", "Cancun", "Edirne", "Suzhou", "Bucharest", "Punta Cana", "Agra", "Jaipur", "Brussels", "Nice", "Chiang Mai", "Hamburg", "Lisbon", "Cork", "Marrakech", "Jakarta", "Manama", "Hanoi", "Honolulu", "Manila", "Guilin", "Auckland", "Cracow", "Gorzów Wielkopolski", "Amman", "Vancouver", "Abu Dhabi", "Kiev", "Doha", "Florence", "Rio de Janeiro", "Melbourne", "Washington D.C.", "Riyadh", "Christchurch", "Frankfurt", "Baku", "Sao Paulo", "Harare", "Kolkata", "Nanjing"
    ]
    
    let nationalities: [String] = [
        "Afghan", "Albanian", "Algerian", "Argentinian", "Australian", "Austrian", "Bangladeshi", "Belgian", "Bolivian", "Batswana", "Brazilian", "Bulgarian", "Cambodian", "Cameroonian", "Canadian", "Chilean", "Chinese", "Colombian", "Costa Rican", "Croatian", "Cuban", "Czech", "Danish", "Dominican", "Ecuadorian", "Egyptian", "Salvadorian", "English", "Estonian", "Ethiopian", "Fijian", "Finnish", "French", "German", "Ghanaian", "Greek", "Guatemalan", "Haitian", "Honduran", "Hungarian", "Icelandic", "Indian", "Indonesian", "Iranian", "Iraqi", "Irish", "Israeli", "Italian", "Jamaican", "Japanese", "Jordanian", "Kenyan", "Kuwaiti", "Lao", "Latvian", "Lebanese", "Libyan", "Lithuanian", "Malaysian", "Malian", "Maltese", "Mexican", "Mongolian", "Moroccan", "Mozambican", "Namibian", "Nepalese", "Dutch", "New Zealand", "Nicaraguan", "Nigerian", "Norwegian", "Pakistani", "Panamanian", "Paraguayan", "Peruvian", "Philippine", "Polish", "Portuguese", "Romanian", "Russian", "Saudi", "Scottish", "Senegalese", "Serbian", "Singaporean", "Slovak", "South African", "Korean", "Spanish", "Sri Lankan", "Sudanese", "Swedish", "Swiss", "Syrian", "Taiwanese", "Tajikistani", "Thai", "Tongan", "Tunisian", "Turkish", "Ukrainian", "Emirati", "British", "American", "Uruguayan", "Venezuelan", "Vietnamese", "Welsh", "Zambian", "Zimbabwean"
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
}
