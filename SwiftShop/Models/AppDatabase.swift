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
    try migrator.migrate(dbPool)
    return dbPool
  }
}

extension AppDatabase {
  static var migrator: DatabaseMigrator {
    var migrator = DatabaseMigrator()

    migrator.registerMigration("createList") { db in
      try db.create(table: "List") { t in
        t.autoIncrementedPrimaryKey("id")
        
        t.column("name", .text)
          .notNull()
          .collate(.localizedCaseInsensitiveCompare)
      }
    }
    
    migrator.registerMigration("createProduct") { db in
      try db.create(table: "Product") { t in
        t.autoIncrementedPrimaryKey("id")
        
        t.column("name", .text)
          .notNull()
          .collate(.localizedCaseInsensitiveCompare)
        
        t.column("price", .double)
      }
    }
    
    migrator.registerMigration("createProductState") { db in
      try db.create(table: "ProductState") { t in
        t.column("productId", .integer)
          .references("Product", onDelete: .cascade)
        
        t.column("listId", .integer)
          .references("List", onDelete: .cascade)
      }
    }
    
    migrator.registerMigration("createTag") { db in
      try db.create(table: "Tag") { t in
        t.autoIncrementedPrimaryKey("id")
        
        t.column("name", .text)
          .notNull()
          .collate(.localizedCaseInsensitiveCompare)
        
        t.column("color", .text)
      }
    }

    return migrator
  }
}
