require 'pry'

class Doctor
  attr_reader(:name, :specialty, :id)

  def initialize(attributes)
    @name = attributes[:name]
    @specialty = attributes[:specialty]
    @id = attributes[:id]
  end

  def self.all()
    doctors = []
    doctor_db_rows = DB.exec("SELECT * FROM doctors")
    doctor_db_rows.each do |row|
      name = row["name"]
      specialty = row["specialty"]
      id = row["id"].to_i
      doctor = Doctor.new({:name => name, :specialty => specialty, :id => id})
      doctors.push(doctor)
    end
    doctors
  end

  def self.find(doctor_id)
    found_doctor = nil
    all_doctors = Doctor.all
    all_doctors.each do |doctor|
      if doctor.id == doctor_id
        found_list = doctor
      end
    end
    found_doctor
  end

  def save
    values = DB.exec("INSERT INTO doctors (name, specialty) VALUES ('#{@name}', '#{@specialty}') RETURNING id")
    @id = values.first["id"].to_i
  end

  def tasks
    list_tasks = []
    tasks = DB.exec("SELECT * FROM tasks WHERE list_id = #{@id}")
    tasks.each do |task|
      description = task["description"]
      list_id = task["list_id"]
      list_tasks.push(Task.new({:description => description, :list_id => list_id}))
    end
    list_tasks
  end

  def ==(other)
    @name == other.name
  end
end
