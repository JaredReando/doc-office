require'pry'

class Patient
  attr_reader(:name, :birth_date, :id, :my_doctor)

  def initialize(attributes)
    @name = attributes[:name]
    @birth_date = attributes[:birth_date]
    @id = attributes[:id]
    @my_doctor = attributes[:my_doctor]
  end

  def self.all
    patients = []
    patients_db_table = DB.exec("SELECT * FROM patients;")
    patients_db_table.each() do |patient|
      name = patient["name"]
      birth_date = patient["birth_date"]
      patients.push(Patient.new({:name => name, :birth_date => birth_date, :id => nil}))
    end
    patients
  end

  def ==(other_instance)
    @name == other_instance.name && @birth_date == other_instance.birth_date
  end

  def save
    result = DB.exec("INSERT INTO patients (name, birth_date) VALUES ('#{@name}', '#{@birth_date}') RETURNING id;")
    @id = result.first["id"].to_i
  end

end
