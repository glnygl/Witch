//
//  QueryBuilder.swift
//  Witch
//
//  Created by Glny Gl on 15/10/2024.
//
enum QueryFields: String {
    case id
    case name
    case url
    case cover = "cover.url"
    case storyline
    case summary
    case rating
    case similarGameIds = "similar_games"
}

struct Condition {
    let field: QueryFields
    let `operator`: ConditionOperator
    let value: String

    func build() -> String {
        return "\(field.rawValue) \(`operator`.rawValue) \(value)"
    }
}

enum ConditionOperator: String {
    case equal = "="
    case notEqual = "!="
}

final class QueryBuilder {
    private var fields: [QueryFields] = []
    private var conditions: [Condition] = []
    private var limit: Int?
    
    func addLimit(_ limit: Int) -> QueryBuilder {
        self.limit = limit
        return self
    }
    
    func addField(_ field: QueryFields) -> QueryBuilder {
        fields.append(field)
        return self
    }
    
    func addFields(_ fields: [QueryFields]) -> QueryBuilder {
        for field in fields {
            self.fields.append(field)
        }
        return self
    }
    
    func addCondition(field: QueryFields, operator: ConditionOperator, value: String) -> QueryBuilder {
        let condition = Condition(field: field, operator: `operator`, value: value)
        conditions.append(condition)
        return self
    }
    
    func build() -> String {
        var query = ""
        
        if !fields.isEmpty {
            let fieldStrings = fields.map { $0.rawValue }
            query += "\nfields " + fieldStrings.joined(separator: ",") + "; "
        }
        
        if !conditions.isEmpty {
            let conditionStrings = conditions.map { $0.build() }
            query += "\nwhere " + conditionStrings.joined(separator: "&") + "; "
        }
        
        if let limit = limit {
            query += "\nlimit" + "\(limit)" + ";"
        }
        
        return query
    }
}
