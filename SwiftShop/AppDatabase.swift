//
//  AppDatabase.swift
//  SwiftShop
//
//  Created by Geordie Powers on 2019-12-05.
//  Copyright © 2019 Geordie Powers. All rights reserved.
//

import GRDB

struct AppDatabase {
  static func openDatabase(atPath path: String) throws -> DatabasePool {
    let dbPool = try DatabasePool(path: path)
    
    try dbPool.erase()
    try migrator.migrate(dbPool)
    
    return dbPool
  }
}

extension AppDatabase {
  static var migrator: DatabaseMigrator {
    var migrator = DatabaseMigrator()
    
    migrator.eraseDatabaseOnSchemaChange = true
    
    migrator.registerMigration("createList") { db in
      try db.create(table: "listEntity") { t in
        t.autoIncrementedPrimaryKey("id")
        
        t.column("name", .text)
          .notNull()
          .collate(.localizedCaseInsensitiveCompare)
      }
    }
    
    migrator.registerMigration("createProduct") { db in
      try db.create(table: "productEntity") { t in
        t.autoIncrementedPrimaryKey("id")
        
        t.column("name", .text)
          .notNull()
          .collate(.localizedCaseInsensitiveCompare)
        
        t.column("price", .double)
      }
    }
    
    migrator.registerMigration("createProductStatus") { db in
      try db.create(table: "productStatusEntity") { t in
        t.column("listId", .integer)
          .references("listEntity", onDelete: .cascade)
        t.column("productId", .integer)
          .references("productEntity", onDelete: .cascade)
        
        t.column("complete", .boolean)
          .notNull()
          .defaults(to: false)
      }
    }
    
    migrator.registerMigration("createTag") { db in
      try db.create(table: "tagEntity") { t in
        t.autoIncrementedPrimaryKey("id")
        
        t.column("name", .text)
          .notNull()
          .collate(.localizedCaseInsensitiveCompare)
        
        t.column("color", .text)
      }
    }
    
    migrator.registerMigration("createProductTag") { db in
      try db.create(table: "productTagEntity") { t in
        t.column("productId", .integer)
          .references("productEntity", onDelete: .cascade)
        t.column("tagId", .integer)
          .references("tagEntity", onDelete: .cascade)
      }
    }
    
    return migrator
  }
}
