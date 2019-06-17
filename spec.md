# Specifications for the Sinatra Assessment

Specs:
- [x] Use Sinatra to build the app
    Used Sinatra, required in Gems
- [x] Use ActiveRecord for storing information in a database
    Database and Models use ActiveRecord and inherit from it
- [x] Include more than one model class (e.g. User, Post, Category)
    Two Models User and Entry
- [x] Include at least one has_many relationship on your User model (e.g. User has_many Posts)
    User has_many Entries
- [x] Include at least one belongs_to relationship on another model (e.g. Post belongs_to User)
    Entries belong_to user
- [x] Include user accounts with unique login attribute (username or email)
    User Controller verifies that if username OR email exist it will route them to login page
- [x] Ensure that the belongs_to resource has routes for Creating, Reading, Updating and Destroying
    Entries can be Created, Read, Updated, and Destroyed
- [x] Ensure that users can't modify content created by other users
    Disabled Edit Entry on View and in created failsafe in Controller checked that post belongs to current_user otherwise routed to own profile in case user tried to route to entry/id/edit
- [x] Include user input validations
    Verified that user could not leave the field blank otherwise entry would not be saved to database
- [ ] BONUS - not required - Display validation failures to user with error message (example form URL e.g. /posts/new)
- [x] Your README.md includes a short description, install instructions, a contributors guide and a link to the license for your code

Confirm
- [x] You have a large number of small Git commits
- [x] Your commit messages are meaningful
- [x] You made the changes in a commit that relate to the commit message
- [x] You don't include changes in a commit that aren't related to the commit message
