//
//  AppDatabase.swift
//  SwiftShop
//
//  Created by Geordie Powers on 2019-12-05.
//  Copyright © 2019 Geordie Powers. All rights reserved.
//

import GRDB

struct TableNames {}

struct AppDatabase {
  static func openDatabase(atPath path: String) throws -> DatabasePool {
    let dbPool = try DatabasePool(path: path)
    
//    try dbPool.erase()
    try migrator.migrate(dbPool)
    
    return dbPool
  }
}

extension AppDatabase {
  static var migrator: DatabaseMigrator {
    var migrator = DatabaseMigrator()
    
    migrator.eraseDatabaseOnSchemaChange = true
    
    migrator.registerMigration("createList") { db in
      try db.create(table: TableNames.ProductListEntity) { t in
        t.autoIncrementedPrimaryKey("id")
        
        t.column("name", .text)
          .notNull()
          .collate(.localizedCaseInsensitiveCompare)
      }
    }
    
    migrator.registerMigration("createProduct") { db in
      try db.create(table: TableNames.ProductEntity) { t in
        t.autoIncrementedPrimaryKey("id")
        
        t.column("name", .text)
          .notNull()
          .collate(.localizedCaseInsensitiveCompare)
        
        t.column("price", .double)
      }
    }
    
    migrator.registerMigration("createProductState") { db in
      try db.create(table: TableNames.ProductStateEntity) { t in
        t.column("productId", .integer)
          .references(TableNames.ProductEntity, onDelete: .cascade)
        
        t.column("listId", .integer)
          .references(TableNames.ProductListEntity, onDelete: .cascade)
        
        t.column("complete", .boolean)
          .notNull()
          .defaults(to: false)
      }
    }
    
    migrator.registerMigration("createTag") { db in
      try db.create(table: TableNames.TagEntity) { t in
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
