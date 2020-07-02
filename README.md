# Github Webhook Project

This project gets GitHub's issue events on a repository and saves those modifications on database, making it possible to get it by specific endpoints.
It uses Ruby 2.7.1, Rails 6 and it is needed Postgres 12.

# What do you need to run the project

Clone this project and run those commands in sequence:

* bundle install
* rails db:create
* rails db:migrate
* rails db:seed 
* rails s

# API documentation

[API mind map](http://www.xmind.net/m/nW3WDE)

# How it works

* Put the post path (**'(your url)/api/v1/event'**) in Payload URL field on Settings/Webhooks at your repository;
* Select **'Issue comments'** and **'Issues'** on **Let me select individuals events** at this same page;
* Click on **Confirm** button at the bottom of the page and we are set to go. 

With all this set, every time that an issue is created or updated, this event will be saved at your database.

# How to get events

## To authenticate: 
### You need to generate a Bearer token by accessing 'POST: authenticate' route. 
* For this, you need to pass a JSON in this of request like that:
{
	"email": "teste@mail.com",
	"password": "123456"
}

* This will return a token to be used at others requests.

## To get a single issue: 
### You need to access 'GET: api/v1/issue/:id' route passing a valid token. 

## To get a list of issues: 
### You need to access 'GET: api/v1/issue' route passing a valid token. 

# TODO list (improvements for the future):

* Refactor tests setup, creating factories.
* Create a new route to save new users.
* Add more Github actions mapping.

