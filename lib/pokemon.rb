class Pokemon

  require 'pry'

attr_accessor :name, :type, :id, :db

def initialize(props={})
   @id = props['id']
   @name = props['name']
   @type = props['type']
   @db = db
 end

def self.save(name, type, db)

  sql = <<-SQL
  INSERT INTO pokemon(name, type)
  VALUES (?, ?)
  SQL
  db.execute(sql, name, type)
  @id = db.execute("SELECT last_insert_rowid() FROM pokemon")[0][0]
end

def self.new_from_db(row)
  new_pokemon = self.new
  new_pokemon.id = row[0]
  new_pokemon.name = row[1]
  new_pokemon.type = row[2]
  new_pokemon
end

def self.find(id, db)
  sql = <<-SQL
  SELECT *
  FROM pokemon
  WHERE id = ?
  LIMIT 1
  SQL
  db.execute(sql, id).map{|row|
  self.new_from_db(row)}[0]
  end


end
