greg = User.create! do |user|
  user.email = 'greg@gnfisher.com'
  user.password = 'test1234'
end
greg.create_profile!(username: 'gnfisher')

daniela = User.create! do |user|
  user.email = 'daniela@gnfisher.com'
  user.password = 'test1234'
end
daniela.create_profile!(username: 'daniela')

lucas = User.create! do |user|
  user.email = 'lucas@gnfisher.com'
  user.password = 'test1234'
end
lucas.create_profile!(username: 'lucas')

lucas_bday = greg.projects.create! do |project|
  project.title = "Lucas's Birthday"
  project.description = "Planing Lucas's big No. 2 birthday bash!"
end

lucas_bday.team_members.create(user: daniela, role: 'edit')
lucas_bday.team_members.create(user: lucas, role: 'view')

