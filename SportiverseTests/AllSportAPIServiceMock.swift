//
//  AllSportAPIServiceMock.swift
//  SportiverseTests
//
//  Created by Ramy Ashraf on 01/06/2023.
//
import Foundation
import UIKit
import CoreData
//import XCTest
@testable import Sportiverse
class AllSportAPIServiceMock: APIService {
    private let decoder: DecoderUtil
    private let context: NSManagedObjectContext
    init(decoder: DecoderUtil) {
        self.decoder = decoder
        self.context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    }
    
    func getLeagues(of name: String, onCompletion: @escaping (Result<[Sportiverse.League], Error>) -> Void) {
        let data = leaguesMockResponse.data(using: .utf8)!
        onCompletion(decoder.decodeLeagues(from: data, type: name, context: context))
    }
    
    func getUpcomingEvents(of sportType: String, leagueID: Int, from startDate: String, to endDate: String, onCompletion: @escaping (Result<[Sportiverse.Event], Error>) -> Void) {
        let data = upcomingEventsMockResponse.data(using: .utf8)!
            onCompletion(decoder.decodeEvents(from: data))
    }
    
    func getLivescores(of sportType: String, leagueID: Int, onCompletion: @escaping (Result<[Sportiverse.Event], Error>) -> Void) {
        let data = livescoreMockResponse.data(using: .utf8)!
        onCompletion(decoder.decodeEvents(from: data))
    }
    
    func getTeams(of sportType: String, leagueID: Int, onCompletion: @escaping (Result<[Sportiverse.Team], Error>) -> Void) {
        let data = teamsMockResponse.data(using: .utf8)!
        onCompletion(decoder.decodeTeams(from: data))
    }
    
    
    let leaguesMockResponse = """
                            {
                            "success": 1,
                            "result": [
                            {
                            "league_key": 4,
                            "league_name": "UEFA Europa League",
                            "country_key": 1,
                            "country_name": "eurocups",
                            "league_logo": "https://apiv2.allsportsapi.com/logo/logo_leagues/",
                            "country_logo": null
                            },
                            {
                            "league_key": 1,
                            "league_name": "European Championship",
                            "country_key": 1,
                            "country_name": "eurocups",
                            "league_logo": null,
                            "country_logo": null
                            },
                            {
                            "league_key": 683,
                            "league_name": "UEFA Europa Conference League",
                            "country_key": 1,
                            "country_name": "eurocups",
                            "league_logo": null,
                            "country_logo": null
                            },
                            {
                            "league_key": 3,
                            "league_name": "UEFA Champions League",
                            "country_key": 1,
                            "country_name": "eurocups",
                            "league_logo": "https://apiv2.allsportsapi.com/logo/logo_leagues/3_uefa_champions_league.png",
                            "country_logo": null
                            }
                            ]
                            }
                            """
    
    let upcomingEventsMockResponse = """
                                    {
                                    "success": 1,
                                    "result": [
                                    {
                                    "event_key": 11755060,
                                    "event_date": "2023-09-22",
                                    "event_time": "22:00",
                                    "event_first_player": "World",
                                    "first_player_key": 12908,
                                    "event_second_player": "Europe",
                                    "second_player_key": 12547,
                                    "event_final_result": "-",
                                    "event_game_result": "-",
                                    "event_serve": null,
                                    "event_winner": null,
                                    "event_status": "",
                                    "country_name": "Teams Men",
                                    "league_name": "Laver Cup Teams",
                                    "league_key": 3173,
                                    "league_round": "",
                                    "league_season": "2023",
                                    "event_live": "0",
                                    "event_first_player_logo": null,
                                    "event_second_player_logo": null,
                                    "pointbypoint": [],
                                    "scores": []
                                    },
                                    {
                                    "event_key": 11867649,
                                    "event_date": "2023-06-02",
                                    "event_time": "11:00",
                                    "event_first_player": "N. Djokovic",
                                    "first_player_key": 1905,
                                    "event_second_player": "A. Davidovich Fokina",
                                    "second_player_key": 2842,
                                    "event_final_result": "-",
                                    "event_game_result": "-",
                                    "event_serve": null,
                                    "event_winner": null,
                                    "event_status": "1",
                                    "country_name": "Atp Singles",
                                    "league_name": "ATP French Open",
                                    "league_key": 2155,
                                    "league_round": null,
                                    "league_season": "2023",
                                    "event_live": "0",
                                    "event_first_player_logo": "https://apiv2.allsportsapi.com/logo-tennis/1905_n-djokovic.jpg",
                                    "event_second_player_logo": "https://apiv2.allsportsapi.com/logo-tennis/2842_a-davidovich-fokina.jpg",
                                    "pointbypoint": [],
                                    "scores": []
                                    },
                                    {
                                    "event_key": 11867650,
                                    "event_date": "2023-06-02",
                                    "event_time": "11:00",
                                    "event_first_player": "L. Musetti",
                                    "first_player_key": 2849,
                                    "event_second_player": "C. Norrie",
                                    "second_player_key": 1103,
                                    "event_final_result": "-",
                                    "event_game_result": "-",
                                    "event_serve": null,
                                    "event_winner": null,
                                    "event_status": "1",
                                    "country_name": "Atp Singles",
                                    "league_name": "ATP French Open",
                                    "league_key": 2155,
                                    "league_round": null,
                                    "league_season": "2023",
                                    "event_live": "0",
                                    "event_first_player_logo": "https://apiv2.allsportsapi.com/logo-tennis/2849_l-musetti.jpg",
                                    "event_second_player_logo": "https://apiv2.allsportsapi.com/logo-tennis/1103_c-norrie.jpg",
                                    "pointbypoint": [],
                                    "scores": []
                                    }
                                    ]
                                    }
                                    """
    
    
    let livescoreMockResponse = """
                                {
                                "success": 1,
                                "result": [
                                {
                                "event_key": 1173071,
                                "event_date": "2023-06-01",
                                "event_time": "01:00",
                                "event_home_team": "Atlanta Utd",
                                "home_team_key": 299,
                                "event_away_team": "New England Revolution",
                                "away_team_key": 7956,
                                "event_halftime_result": "0 - 2",
                                "event_final_result": "1 - 2",
                                "event_ft_result": "",
                                "event_penalty_result": "",
                                "event_status": "71",
                                "country_name": "USA",
                                "league_name": "MLS - Regular Season",
                                "league_key": 332,
                                "league_round": "Round 21",
                                "league_season": "2023",
                                "event_live": "1",
                                "event_stadium": "Mercedes-Benz Stadium, Atlanta",
                                "event_referee": "Rubiel Vazquez, USA",
                                "home_team_logo": "https://apiv2.allsportsapi.com/logo/299_atlanta-united.jpg",
                                "away_team_logo": "https://apiv2.allsportsapi.com/logo/7956_new-england.jpg",
                                "event_country_key": 114,
                                "league_logo": "https://apiv2.allsportsapi.com/logo/logo_leagues/332_mls.png",
                                "country_logo": "https://apiv2.allsportsapi.com/logo/logo_country/114_usa.png",
                                "event_home_formation": "4-2-3-1",
                                "event_away_formation": "4-2-3-1",
                                "fk_stage_key": 1718,
                                "stage_name": "Regular Season",
                                "league_group": null,
                                },
                                {
                                "event_key": 1173072,
                                "event_date": "2023-06-01",
                                "event_time": "01:30",
                                "event_home_team": "Columbus Crew",
                                "home_team_key": 306,
                                "event_away_team": "Colorado Rapids",
                                "away_team_key": 7961,
                                "event_halftime_result": "1 - 1",
                                "event_final_result": "1 - 1",
                                "event_ft_result": "",
                                "event_penalty_result": "",
                                "event_status": "58",
                                "country_name": "USA",
                                "league_name": "MLS - Regular Season",
                                "league_key": 332,
                                "league_round": "Round 21",
                                "league_season": "2023",
                                "event_live": "1",
                                "event_stadium": "Lower.com Field, Columbus",
                                "event_referee": "Tori Penso, USA",
                                "home_team_logo": "https://apiv2.allsportsapi.com/logo/306_columbus-crew.jpg",
                                "away_team_logo": "https://apiv2.allsportsapi.com/logo/7961_colorado-rapids.jpg",
                                "event_country_key": 114,
                                "league_logo": "https://apiv2.allsportsapi.com/logo/logo_leagues/332_mls.png",
                                "country_logo": "https://apiv2.allsportsapi.com/logo/logo_country/114_usa.png",
                                "event_home_formation": "3-4-2-1",
                                "event_away_formation": "3-5-2",
                                "fk_stage_key": 1718,
                                "stage_name": "Regular Season",
                                "league_group": null
                                },
                                {
                                "event_key": 1173072,
                                "event_date": "2023-06-01",
                                "event_time": "01:30",
                                "event_home_team": "Columbus Crew",
                                "home_team_key": 306,
                                "event_away_team": "Colorado Rapids",
                                "away_team_key": 7961,
                                "event_halftime_result": "1 - 1",
                                "event_final_result": "1 - 1",
                                "event_ft_result": "",
                                "event_penalty_result": "",
                                "event_status": "58",
                                "country_name": "USA",
                                "league_name": "MLS - Regular Season",
                                "league_key": 332,
                                "league_round": "Round 21",
                                "league_season": "2023",
                                "event_live": "1",
                                "event_stadium": "Lower.com Field, Columbus",
                                "event_referee": "Tori Penso, USA",
                                "home_team_logo": "https://apiv2.allsportsapi.com/logo/306_columbus-crew.jpg",
                                "away_team_logo": "https://apiv2.allsportsapi.com/logo/7961_colorado-rapids.jpg",
                                "event_country_key": 114,
                                "league_logo": "https://apiv2.allsportsapi.com/logo/logo_leagues/332_mls.png",
                                "country_logo": "https://apiv2.allsportsapi.com/logo/logo_country/114_usa.png",
                                "event_home_formation": "3-4-2-1",
                                "event_away_formation": "3-5-2",
                                "fk_stage_key": 1718,
                                "stage_name": "Regular Season",
                                "league_group": null
                                }
                                ]
                                }
                                """
    let teamsMockResponse = """
                            {
                            "success": 1,
                            "result": [
                            {
                            "team_key": 103,
                            "team_name": "Istanbul Basaksehir",
                            "team_logo": "https://apiv2.allsportsapi.com/logo/103_istanbul-basaksehir.jpg",
                            "players": [
                            {
                            "player_key": 4085214559,
                            "player_name": "V. Babacan",
                            "player_number": "1",
                            "player_country": null,
                            "player_type": "Goalkeepers",
                            "player_age": "34",
                            "player_match_played": "21",
                            "player_goals": "0",
                            "player_yellow_cards": "0",
                            "player_red_cards": "0",
                            "player_image": "https://apiv2.allsportsapi.com/logo/players/10249_v-babacan.jpg"
                            },
                            {
                            "player_key": 2689992073,
                            "player_name": "M. Şengezer",
                            "player_number": "16",
                            "player_country": null,
                            "player_type": "Goalkeepers",
                            "player_age": "26",
                            "player_match_played": "11",
                            "player_goals": "0",
                            "player_yellow_cards": "2",
                            "player_red_cards": "0",
                            "player_image": "https://apiv2.allsportsapi.com/logo/players/64746_m-engezer.jpg"
                            },
                            {
                            "player_key": 934451939,
                            "player_name": "Y. Erataman",
                            "player_number": "78",
                            "player_country": null,
                            "player_type": "Goalkeepers",
                            "player_age": "17",
                            "player_match_played": "0",
                            "player_goals": "0",
                            "player_yellow_cards": "0",
                            "player_red_cards": "0",
                            "player_image": null
                            }
                            ]
                            },
                            {
                            "team_key": 163,
                            "team_name": "Sivasspor",
                            "team_logo": "https://apiv2.allsportsapi.com/logo/163_sivasspor.jpg",
                            "players": [
                            {
                            "player_key": 1642348556,
                            "player_name": "B. Kuçkar",
                            "player_number": "16",
                            "player_country": null,
                            "player_type": "Goalkeepers",
                            "player_age": "20",
                            "player_match_played": "0",
                            "player_goals": "0",
                            "player_yellow_cards": "0",
                            "player_red_cards": "0",
                            "player_image": "https://apiv2.allsportsapi.com/logo/players/192972_b-kuckar.jpg"
                            },
                            {
                            "player_key": 1191136313,
                            "player_name": "E. Satılmış",
                            "player_number": "18",
                            "player_country": null,
                            "player_type": "Goalkeepers",
                            "player_age": "26",
                            "player_match_played": "0",
                            "player_goals": "0",
                            "player_yellow_cards": "0",
                            "player_red_cards": "0",
                            "player_image": "https://apiv2.allsportsapi.com/logo/players/62492_e-satilmi.jpg"
                            },
                            {
                            "player_key": 3065749055,
                            "player_name": "M. Yıldırım",
                            "player_number": "25",
                            "player_country": null,
                            "player_type": "Goalkeepers",
                            "player_age": "32",
                            "player_match_played": "5",
                            "player_goals": "0",
                            "player_yellow_cards": "0",
                            "player_red_cards": "0",
                            "player_image": "https://apiv2.allsportsapi.com/logo/players/8257_m-yildirim.jpg"
                            }
                            ]
                            }
                            ]
                            }
                            """
}
