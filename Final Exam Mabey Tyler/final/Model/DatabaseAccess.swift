//
//  DatabaseAccess.swift
//  final
//
//  Created by Tyler Mabey on 12/18/17.
//  Copyright © 2017 Tyler Mabey. All rights reserved.
//

import Foundation
import GRDB

class DatabaseAccess {
    
    // MARK: - Constants
    
    struct Constant {
        static let dbName = "core.23"
        static let dbExtension = "db"
    }
    
    // MARK: - Properties
    
    var dbQueue: DatabaseQueue!
    
    // MARK: - Singleton
    
    static let sharedDatabaseAccess = DatabaseAccess()
    
    fileprivate init () {
        dbQueue = try? DatabaseQueue(path: Bundle.main.path(forResource: Constant.dbName, ofType: Constant.dbExtension)!)
    }
    
    // MARK: - Helpers
    
    func lastUpdated() -> String {
        do {
            let last = try dbQueue.inDatabase { (db: Database) -> String in
                let row = try String.fetchOne(db, "select * from updated")
               
                return row!
                
            }
            return last
        } catch {
            return "Error"
        }
    }
    
    func getAllConferences() -> [(Int, String)] {
        do {
            let conferences = try dbQueue.inDatabase { (db: Database) -> [(Int, String)] in
                var conferences = [(Int, String)]()
                
                for row in try Row.fetchAll(db, "SELECT ID, Abbr FROM conference ORDER BY IssueDate DESC;") {
                    conferences.append((row[0], row[1]))
                }
                return conferences
            }
            return conferences
        } catch {
            return [(1, "None")]
        }
    }
    
    func getTalksFromConference(_ conferenceId: Int) -> [Talk] {
        do {
            let talks = try dbQueue.inDatabase{ (db: Database) -> [Talk] in
                var talks = [Talk]()
                
                for row in try Row.fetchAll(db,
                                            "SELECT t.ID, t.Title, s.Description" +
                    "FROM talk t JOIN conference_talk c JOIN conf_session s" +
                    "WHERE t.ID=c.TalkID AND c.SessionID=s.ID AND s.ConferenceID=\(conferenceId) ORDER BY s.Sequence, c.Sequence;") {
                         talks.append(Talk(row: row))
                }
                return talks
            }
            return talks
        } catch {
            return []
        }
    }
    
}
