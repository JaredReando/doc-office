require("sinatra")
require("sinatra/reloader")
also_reload("lib/**/*.rb")
require("./lib/doctor")
require("./lib/patient")
require("pg")

DB = PG.connect({:dbname => "doc_office"})


get("/") do
@doctors = Doctor.all
@patients = Patient.all
(erb :index)
end

post("/doctor") do
  if (params[:doc_name] == "") || (params[:doc_specialty] == "")
    redirect "/"
  else
    doc_entry = params[:doc_name]
    doc_specialty = params[:doc_specialty]
    new_doctor = Doctor.new(:name => doc_entry, :specialty => doc_specialty, :id => nil)
    new_doctor.save
    # @doctors = Doctor.all
    redirect "/"
  end
end

post("/patient") do
  if (params[:patient_name] == "") || (params[:birth_date] == "")
    redirect "/"
  else
    name = params[:patient_name]
    birth_date = params[:patient_dob]
    new_patient = Patient.new(:name => name, :birth_date => birth_date, :id => nil)
    new_patient.save
    redirect "/"
  end
end

get("/tasks/:id") do
@list_id = params[:id].to_i
@list = List.find_list(@list_id)
@tasks = @list.tasks

(erb :tasks)
end


post("/tasks/:id") do
list_id = params[:id]
task_description = params[:task_entry]
  if (task_description == "")
    redirect "/tasks/#{list_id}"
  else
    task = Task.new(:description => task_description, :list_id => list_id)
    task.save
    redirect "/tasks/#{list_id}"
  end
end
