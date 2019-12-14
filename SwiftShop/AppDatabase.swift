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
    
    #if DEBUG
      try dbPool.erase()
    #endif

    try setupMigrations.migrate(dbPool)
    
    #if DEBUG
      try debugMigrations.migrate(dbPool)
    #endif
    
    return dbPool
  }
}

extension AppDatabase {
  static var setupMigrations: DatabaseMigrator {
    var migrator = DatabaseMigrator()

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
        t.autoIncrementedPrimaryKey("id")
        
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
  
  static var debugMigrations: DatabaseMigrator {
    var migrator = DatabaseMigrator()

    migrator.registerMigration("createDevEntities") { db in
      var list = ListEntity(id: nil, name: AppConstants.DEFAULT_LIST_NAME)
      try list.insert(db)

      var product1 = ProductEntity(id: nil, name: "First product", price: 3.00)
      var product2 = ProductEntity(id: nil, name: "Second product", price: 2.00)
      var product3 = ProductEntity(id: nil, name: "Third product", price: 1.00)
      var product4 = ProductEntity(id: nil, name: "Fourth product", price: 16.00)
      try product1.insert(db)
      try product2.insert(db)
      try product3.insert(db)
      try product4.insert(db)

      var tag1 = TagEntity(id: nil, name: "BlueTag", color: "blue")
      var tag2 = TagEntity(id: nil, name: "GreenTag", color: "green")
      try tag1.insert(db)
      try tag2.insert(db)
      
      var productStatus1 = ProductStatusEntity(listId: list.id!, productId: product1.id!, complete: false)
      try productStatus1.insert(db)
      var productStatus2 = ProductStatusEntity(listId: list.id!, productId: product2.id!, complete: true)
      try productStatus2.insert(db)
      
      var productTag1 = ProductTagEntity(productId: product1.id!, tagId: tag1.id!)
      var productTag2 = ProductTagEntity(productId: product1.id!, tagId: tag2.id!)
      var productTag3 = ProductTagEntity(productId: product3.id!, tagId: tag2.id!)
      var productTag4 = ProductTagEntity(productId: product4.id!, tagId: tag1.id!)
      try productTag1.insert(db)
      try productTag2.insert(db)
      try productTag3.insert(db)
      try productTag4.insert(db)
    }
    
    return migrator
  }
}
