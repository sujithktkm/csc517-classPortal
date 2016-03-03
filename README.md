# CSC 517 Program 1 - Class Portal
Class Portal is submitted as Program 1 for CSC 517 Spring 2016 and is deployed to [Heroku](https://skataka-portal.herokuapp.com/login). The application adheres to this [requirements](https://docs.google.com/document/d/1xmeH4MAlUs6QfPoC4J4bsMKYWkawDZrsZDFM7S1G8ag/edit) document.

##Build Environment
* This Class Portal uses Ruby <tt>Version 2.2.3</tt>, Rails <tt>Version 4.2.4</tt> and postgres as database.
* The following link is used to install Rails and setup postgres(https://gorails.com/setup/ubuntu/15.10)
* JetBrains [RubyMine](https://www.jetbrains.com/ruby/) is recommended IDE for ruby development.

##Setup
The below steps are recommended to setup the application in RubyMine.
Before starting to work on this application, start <tt>postgres</tt> and connect to <tt>development</tt> database. (As your local machine is your development branch)

```
postgres -D postgres # to start postgres
```
Also, you can install [pgAmin](http://www.pgadmin.org/download/). For Ubuntu users, <tt>sudo apt-get install pgadmin3</tt> does the trick. pgAdmin helps in easily managing your database.

Clone the repository from [csc517-classPortal](https://github.com/sujithktkm/csc517-classPortal.git) and run following commands (in order) in terminal.

```
bundle install
rake db:migrate
rake db:seed
rails server # starts the server
```

Open any browser and visit <tt>http://localhost:3000</tt> (Assuming that you are using the default port)

##Configuration
The default admin login information for this portal is (**Please don't change these details while testing the app**)
```
Name:     admin
Email:    admin@csc517.com
Password: csc517
```

##Usage
- Students can sign up at login page by entering name, email (should be unique) and password. Admins can create students, instructors and other admins. Users can change their passwords any time by clicking 'Edit Profile' found at right corner of page.
- Student can enroll in a course and it shows up in 'My Courses' tab.
- User history can be seen by the admin once they click 'View details' button adjacent to corresponding user's name in 'Manage Users' tab.
- Instructor can view course content/material when they click the course they wish to look at (In 'My Courses' tab)
- Admin can view course content/material when they click 'View details' button adjacent to corresponding course in 'Manage Courses' tab.
- Grades assigned to students are only numeric (0-100) in steps on 1. (If you try to enter alphabets, the field doesn't even take your input)
- Student can cancel Enrollment Request only by using 'Search Courses' tab, searching for the course they sent a Enrollment Request for, clicking the course (only for Active courses) and hitting 'Cancel Enrollment Request' button.

##Assumptions
Here are assumptions as part of development of this application -
* This model assumes that when an Admin creates a user with login email and password, admin communicates the same to the user and the use can login using these details. The user can change his password after his first login using 'Edit Profile' option.
* If an Instructor is deleted, history of courses (active) Instructor is currently teaching and that are scheduled for future will be lost. The history of already taught courses is saved so that student who had taken the course can view their grades.
* If an active course is deleted, then student enrollments, enrollment requests and history information (of this specific course) of users and instructors related to that particular course are all removed from system.
* There can be more than one section for a given course (same course number) and a student can only enroll in one of these sections.
* Having multiple instructors for a given course is implemented as creating mutiple sections for the same course.

##Extra Credit
This application has the following features, which fall under Bonus/Extra Credit -
* Students and Instructors can exchange private messages. Messages can only be exchanged between an Instructor and students enrolled in his/her course(s).
* An Instructor of the course can request to make a course “Inactive”. The request can be viewed by the admins only.

##References
1. https://www.codecademy.com/learn/rails-auth
2. https://getbootstrap.com/components/#navbar
3. https://docs.google.com/document/d/1xmeH4MAlUs6QfPoC4J4bsMKYWkawDZrsZDFM7S1G8ag/edit
