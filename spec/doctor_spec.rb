require 'spec_helper'

describe(Doctor) do
  describe(".all") do
    it("starts off with no doctors") do
      expect(Doctor.all()).to(eq([]))
    end
  end

  describe("#name") do
    it("returns its name") do
      doctor = Doctor.new({:name => "Jim", :specialty => "heart", :id => nil})
      expect(doctor.name()).to(eq("Jim"))
    end
  end

  # describe("#id") do
  #   it("sets its id when saved") do
  #     test_doctor1 = Doctor.new({:name => "Jim", :specialty => "heart", :id => nil})
  #     test_doctor1.save()
  #     expect(test_doctor1.id()).to(be_an_instance_of(Integer))
  #     binding.pry
  #   end
  # end

    describe("#id") do
    it("sets its id when saved") do
      doctor = Doctor.new({:name => "Jim", :specialty => "head", :id => nil})
      doctor.save()
      expect(doctor.id()).to(be_an_instance_of(Integer))
    end
  end

  describe("#save") do
    it("saves doctor to the database") do
      test_doctor1 = Doctor.new({:name => "Jim", :specialty => "heart", :id => nil})
      test_doctor1.save
      expect(Doctor.all()).to(eq([test_doctor1]))
    end
  end

  describe("#==") do
    it("is the same if the id and name match") do
      test_doctor1 = Doctor.new({:name => "Jim", :specialty => "heart", :id => nil})
      test_doctor2 = Doctor.new({:name => "Jim", :specialty => "heart", :id => nil})
      expect(test_doctor1).to(eq(test_doctor2))
    end
  end

  describe(".find") do
    it("resturns a doctor by its ID") do
      test_doctor1 = Doctor.new({:name => "Jim", :specialty => "heart", :id => nil})
      test_doctor1.save()
      test_doctor2 = Doctor.new({:name => "Erica", :specialty => "hand", :id => nil})
      test_doctor2.save()
      expect(Doctor.find(test_doctor1.id)).to(eq(test_doctor1))
    end
  end
  #
  # describe("#tasks") do
  #   it("resturns an array of tasks for that list") do
  #     test_list = Doctor.new({:name => "Epicodus stuff", :id => nil})
  #     test_list.save()
  #     test_task = Task.new({:description => "Learn SQL", :list_id => test_list.id()})
  #     test_task.save()
  #     test_task2 = Task.new({:description => "Review Ruby", :list_id => test_list.id()})
  #     test_task2.save()
  #     expect(test_list.tasks()).to(eq([test_task, test_task2]))
  #   end
  # end


end
