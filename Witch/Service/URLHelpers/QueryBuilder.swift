//
//  QueryBuilder.swift
//  Witch
//
//  Created by Glny Gl on 15/10/2024.
//

class QueryBuilder {
    private var fields: [String] = []
    private var conditions: [String] = []
    
    func addField(_ field: String) -> QueryBuilder {
        fields.append(field)
        return self
    }
    
    func addFields(_ fields: [String]) -> QueryBuilder {
        for field in fields {
            self.fields.append(field)
        }
        return self
    }
    
    func addCondition(_ condition: String) -> QueryBuilder {
        conditions.append(condition)
        return self
    }
    
    func build() -> String {
        var query = ""
        
        if !fields.isEmpty {
            query += "\nfields " + fields.joined(separator: ",") + ";"
        }
        
        if !conditions.isEmpty {
            query += "\nwhere " + conditions.joined(separator: " and ") + ";"
        }
        
        return query
    }
}
