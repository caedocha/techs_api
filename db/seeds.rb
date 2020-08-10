#
# API USERS
#

User.create(name: "cv_tool_api_user", password: "change_me")
User.create(name: "tech_stacks_api_user", password: "change_me")

#
# CATEGORIES
#

app_and_dev = Category.where(name: "App & Development", description: "All of the technologies used by the development teams and projects").first_or_create
analytics = Category.where(name: "Analytics", description: "All of the technologies used by the analytics teams and projects").first_or_create
qa = Category.where(name: "QA", description: "All of the technologies used by the QA teams and projects").first_or_create
devops = Category.where(name: "DevOps", description: "All of the technologies used by the devops teams and projects").first_or_create
utilities = Category.where(name: "Utilities", description: "Any misc utility tool or technology").first_or_create

#
# TECHS
#

python = Tech.where(name: "Python").first_or_create
java = Tech.where(name: "Java").first_or_create
ruby = Tech.where(name: "Ruby").first_or_create
go = Tech.where(name: "Go").first_or_create
javascript = Tech.where(name: "Javascript").first_or_create
net = Tech.where(name: ".Net").first_or_create
c_sharp = Tech.where(name: "C#").first_or_create
angular = Tech.where(name: "Angular").first_or_create
angularjs = Tech.where(name: "AngularJS").first_or_create
react = Tech.where(name: "React").first_or_create
mysql = Tech.where(name: "MySQL").first_or_create
postgresql = Tech.where(name: "PostgreSQL").first_or_create
sql_server = Tech.where(name: "SQL Server").first_or_create
mongo_db = Tech.where(name: "MongoDB").first_or_create
ruby_on_rails = Tech.where(name: "Ruby On Rails").first_or_create
laravel = Tech.where(name: "Laravel").first_or_create
kubernetes = Tech.where(name: "Kubernetes").first_or_create
docker = Tech.where(name: "Docker").first_or_create
chef = Tech.where(name: "Chef").first_or_create
datadog = Tech.where(name: "Datadog").first_or_create
vagrant = Tech.where(name: "Vagrant").first_or_create
kibana = Tech.where(name: "Kibana").first_or_create
sentry = Tech.where(name: "Sentry").first_or_create
jenkins = Tech.where(name: "Jenkins").first_or_create
capybara = Tech.where(name: "Capybara").first_or_create
saucelabs = Tech.where(name: "SauceLabs").first_or_create
robot = Tech.where(name: "Robot").first_or_create
cypress = Tech.where(name: "Cypress").first_or_create
cucumber = Tech.where(name: "Cucumber").first_or_create
testng = Tech.where(name: "TestNg").first_or_create
nunit = Tech.where(name: "NUnit").first_or_create
git = Tech.where(name: "Git").first_or_create
svn = Tech.where(name: "SVN").first_or_create

#
# CATEGORIES & TECHS
#

[python, java, ruby, go, javascript, net, c_sharp, angular, angularjs, react, mysql, postgresql, sql_server, mongo_db, ruby_on_rails, laravel]
  .each_with_object(app_and_dev) do |tech, category|
    Link.create(category: category, tech: tech)
  end
[python]
  .each_with_object(analytics) do |tech, category|
    Link.create(category: category, tech: tech)
  end
[capybara, python, ruby, saucelabs, java, robot, cypress, cucumber, testng, nunit]
  .each_with_object(qa) do |tech, category|
    Link.create(category: category, tech: tech)
  end
[docker, chef, datadog, vagrant, kibana, sentry, jenkins]
  .each_with_object(devops) do |tech, category|
    Link.create(category: category, tech: tech)
  end
[git, svn]
  .each_with_object(utilities) do |tech, category|
    Link.create(category: category, tech: tech)
  end
