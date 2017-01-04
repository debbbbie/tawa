Todo.seed do |todo|
  todo.id = 1
  todo.user = User.find 1
  todo.project_id = 1
  todo.name = 'todo1'
end

Todo.seed do |u|

  todo = Todo.find 1
  user = User.find 2
  todo.user = User.find 1
  todo.update_attributes(assigned_user: user)


  todo = Todo.find 1
  user = User.find 3
  todo.user = User.find 1
  todo.update_attributes(assigned_user: user)


  todo = Todo.find 1
  user = User.find 1
  todo.user = user
  todo.update_attributes(deadline: 1.day.since)


  u.id = 2
  u.user = User.find 1
  u.project_id = 1
  u.name = 'todo2'
end

Todo.seed do |u|
  u.id = 3
  u.user = User.find 1
  u.project_id = 1
  u.name = 'todo3'
end
