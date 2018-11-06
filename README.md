App created to upload a csv file into a db

How To Import CSV Files In Rails
Before working on software, my job, like so many others, used to revolve around excel spreadsheets. They’re a valuable tool for organizations to store and manipulate large quantities of data. So naturally upon getting involved with Rails, I knew it would be helpful to learn how to upload spreadsheet data into web interfaces for organizations and employees to view, share, and add to their data.

Although it’s possible to do this manually using a graphical user interface, one of the core tenants of programming is that if you’re going to do something repeatedly, you should probably automate it.

Let’s explore how to get sample data to render as a table on a skeleton rails application. We’ll use activity tracker data to build a steps leaderboard for a fitness challenge.

When working with a new concept in software development, I’ve found it extremely useful to create a sample application that correctly incorporates the feature before building it into a larger existing application. This helps separate concerns and establishes a baseline level of familiarity before handling more complex scenarios. We'll start with just one user story: 
As a user
  I want to upload and view CSV files
  So that I can integrate existing data with our rails app 
So let’s create a brand new rails app, with:
rails new importCSV
We'll work backwards from the database to the browser, generating a model, controller, and view for our single class, User.

MODEL

Our model’s attributes should match the CSV data we want to store and display. Don’t forget to migrate it into the database 

Next we’ll need to write a method import in that model to import the data from our CSV file.
 app/models/user.rb 
app/models/user.rb

SIDEBAR: REQUIRE IN RAILS

You’ll notice here that we’re require ‘csv’, which is just a standard ruby class.  

One of the cool features in rails is that if it sees a model name (i.e. EstimationCalculator) somewhere else in the application, it automatically knows to run: 
require 'estimation_calculator'
without any developer input! Pretty nifty, huh? 

CONTROLLER

Any great model has a corresponding controller, so generate a controller with methods index and import. 
rails g controller Users index import
Then, we’ll modify the file to make the import method get our CSV file data and ensure the index method displays all of our Users.
 app/controllers/user_controller.rb 
app/controllers/user_controller.rb

VIEW

Our MVC paradigm won’t be complete without a view, so let’s display the CSV data in a table format. In lines 27-32, we’ll also use the view to build a form with the ability to upload our file, then submit it using the "Import CSV" submit button.
 app/view/users/index.html.erb 
app/view/users/index.html.erb

Finally, to render the view correctly we’ll need to add the proper routes. Here we're setting up all the resources for users, then adding the ability to post to the database using the import method by adding an additional route to the collection. We're also establishing our root route as the index page, where all our view code is. 
 config/routes.rb 
config/routes.rb

Alright, let’s fire up our server and see if it works!
rails s
localhost:3000
The root displays correctly, but have you noticed my mistake yet? When we try to import a file...

DEBUGGING

ActiveRecord::UnknownAttributeError!!? What could that possibly mean? When programming, it's vital to adopt a mindset of accepting and appreciating errors. Although they can be scary and naturally frustrating at first, errors are actually useful and insightful ways to de-bug and improve your application. 

In this instance, our user model is unable to find the attribute 'User' that's specified in our original CSV file because I never included it in the original model creation. In order to rectify the error, we can just add a new column to the database with: 
rails g migration add_column_user_to_user user:string
rake db:migrate
Here's the before and after in the Rails Console with our updated User schema: 
  If you're wondering how I get my rails console output to display so beautifully, gem  awesome_print  FTW!  
If you're wondering how I get my rails console output to display so beautifully, gem awesome_print FTW!

This isn't the most intuitive naming convention, but we need our column names to line up with the initial information in the spreadsheet.

When we try again, it should display correctly and all of our User data should be available in the database. Notice how the flash[:notice] renders upon redirection as well. 
Screen Shot 2015-03-22 at 4.39.09 PM.png
 User.all 
User.all

There's just one last technicality to take care of. Our initial intent was to create a steps leaderboard, but the table data isn't sorted correctly. Luckily, one quick addition to our table view can fix that. Just change line 14 in app/views/users/index.html.erb from:  
<% @users.each do |user| %>
to.

<% @users.order("steps desc").each do |user| %>
and everything should be working perfectly! Although it's not particularly beautiful, our final product accomplished the original intent from the user story. Moving forward, you should be much more comfortable integrating CSV into larger and more complex situations. 