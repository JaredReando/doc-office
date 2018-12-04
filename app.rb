require("sinatra")
require("sinatra/reloader")
also_reload("lib/**/*.rb")
require("./lib/doctor")
require("./lib/patient")
require("pg")

DB = PG.connect({:dbname => "doc_office"})


get("/") do
@doctors = Doctor.all
(erb :index)
end

post("/") do
  if (params[:list_entry] == "")
    redirect "/"
  else
    list_entry = params[:list_entry].capitalize
    new_list = List.new(:name => list_entry)
    new_list.save
    @lists = List.all
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
