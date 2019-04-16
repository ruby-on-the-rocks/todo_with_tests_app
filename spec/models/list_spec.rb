require "rails_helper"

RSpec.describe List, type: :model do
  describe "#complete_all_tasks!" do
    it "should mark all tasks in the list as complete" do
      list = List.create(name: "Chores")
      task1 = Task.create(list_id: list.id, complete: false)
      task2 = Task.create(list_id: list.id, complete: false)
      list.complete_all_tasks!

      list.tasks.each do |task|
        expect(task.complete).to eq(true)
      end
    end
  end

  describe "#snooze_all_tasks!" do
    it "should increase each task deadline by 1 hour" do
      list = List.create(name: "Chores")
      Task.create(list_id: list.id, deadline: Time.new(2019, 1, 1))
      Task.create(list_id: list.id, deadline: Time.new(2019, 1, 1))
      Task.create(list_id: list.id, deadline: Time.new(2019, 1, 1))
      list.snooze_all_tasks!

      list.tasks.each do |task|
        expect(task.deadline).to eq(Time.new(2019, 1, 1) + 1.hour)
      end
    end
  end

  describe "#total_duration" do
    it "should return the sum of task durations" do
      list = List.create(name: "Chores")
      Task.create(list_id: list.id, duration: 50)
      Task.create(list_id: list.id, duration: 150)

      expect(list.total_duration).to eq(200)
    end
  end

  describe "#incomplete_tasks" do
    it "should return an array of only incomplete tasks" do
      list = List.create(name: "Chores")
      Task.create(list_id: list.id, complete: true)
      Task.create(list_id: list.id, complete: true)
      Task.create(list_id: list.id, complete: false)
      Task.create(list_id: list.id, complete: true)
      Task.create(list_id: list.id, complete: false)
      the_incomplete_tasks = list.incomplete_tasks

      # Make sure the array is the correct length
      expect(the_incomplete_tasks.length).to eq(2)
      # Make sure each item in the array is incomplete
      the_incomplete_tasks.each do |task|
        expect(task.complete).to eq(false)
      end
    end
  end

  describe "#favorite_tasks" do
    it "should return an array of only favorite tasks" do
      list = List.create(name: "Chores")
      Task.create(list_id: list.id, favorite: true)
      Task.create(list_id: list.id, favorite: true)
      Task.create(list_id: list.id, favorite: false)
      Task.create(list_id: list.id, favorite: true)
      Task.create(list_id: list.id, favorite: false)
      the_favorite_tasks = list.favorite_tasks

      # Make sure the array is the correct length
      expect(the_favorite_tasks.length).to eq(3)
      # Make sure each item in the array is favorite
      the_favorite_tasks.each do |task|
        expect(task.favorite).to eq(true)
      end
    end
  end
end
