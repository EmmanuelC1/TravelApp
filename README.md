Group Project - README Template
===

# Travel App

## Table of Contents
1. [Overview](#Overview)
1. [Product Spec](#Product-Spec)
1. [Wireframes](#Wireframes)
2. [Schema](#Schema)

## Overview
### Description
Create an app for tourists who want to know about local food, movies, and physical events in relation to their current location.

### App Evaluation
[Evaluation of your app across the following attributes]
- **Category:**
- **Mobile:**
- **Story:**
- **Market:**
- **Habit:**
- **Scope:**

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

- [x] User login
- [x] Save user data(favorites)
- [x] Find user's current location using appropriate privacy settings
- [x] Home Screen with 3 tab buttons
- [x] Query DB for images to populate tabs
- [x] User must be able to select an item and see details (book button)
- [x] Give user ability to book event (mock up)
- [x] Give user ability to cancel a booked event(mock up)



**Optional Nice-to-have Stories**

* Add pins on map to display favorites or searched items

## Video Walkthrough

Here's a walkthrough of implemented user stories:

<img src='http://g.recordit.co/fpHhqkOWxx.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

Businesses by local area, Favorites saving, Logout feature:

<img src='http://g.recordit.co/oZlk2QrI2v.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

Search and view business details through MapKit:

<img src='http://g.recordit.co/RtL8udizW1.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

Updated design:

<img src='http://g.recordit.co/v8I3W0cAFv.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

Booking features: 
<img src='https://recordit.co/8R80aqrlOD.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

### 2. Screen Archetypes

* Login page
   * User enters login valid information
* Home page
   * Displays categories: "Movies", "Food"
   * Tabs in tabbar: "Home", "Search", "Favorites"
* Category-specific-page ie: "Food"
  * Display table with corresponding places ie: "McDonalds"
* Place details page corresponding to cell from category table
  * Display information about the place/event, booking button
* Search tab -> Maps page
  * Search for specific place/activity -> give details and allow to reserve/book event
* Booking tab ->  list of users booking and details ie: Place, time and date 
### 3. Navigation

**Tab Navigation** (Tab to Screen)

* Home Tab
* Map Search Tab
* User favorite Tab
* User Bookings Tab

**Flow Navigation** (Screen to Screen)

* Login page
   * Home page
* Home page w/categories
   * Home tab
   * Map Search tab
   * Favorite tab
   * Booking tab
* Home page w/ categories
   * List matching corresponding category
   * Click cell to view More Details page
* Category details page
   * Allows for booking the place/event
   * Allows for favoriting places
* Map Search tab
   * Map and search for places
   * Pins clickable and seque to Details View
* Details page
   * List more information on local business: Hours of operation, Address, Contact Information
* Booking page
   * Allows user to enter time, date and locaton of booking 
 * My Bookings page: 
   * List of save confirmed booking by user. 
   * Allows user to Cancel booking with Alert pop for confirmation and refresh feature for instant update.
## Wireframes
Add picture of your hand sketched wireframes in this section
<img src="https://i.imgur.com/eyTqj2Z.jpg" width=600>
### [BONUS] Digital Wireframes & Mockups

### [BONUS] Interactive Prototype

## Schema 

### Models
  | User     | Type   |
  | -------- | ------ |
  | username | String |
  | password | String |

  | Favorites      | Type            | Description  |
  | -------------- | --------------- | ------------ |
  | username       | Pointer to User | unique username for the user (default field) |
  | name (business)| String          | name of favorited place |
  | image          | File            | image of favorited place |
  | address        | String          | address of favorited place |
  | phone number   | String          | phone number of favorited place |
  | coordinates    | Number          | coordinates of favorited palace (later to be used with MapKit) |
  | booked?        | Boolean         | has the user booked this place? |
  
  | Bookings            | Type            |  Description |
  | ------------------- | --------------- | ------------ |
  | username            | Pointer to User | unique username for the user (default field) |
  | name (business)     | String          | name of booked place |
  | image               | File            | image of booked place |
  | address             | String          | address of booked place |
  | phone number        | String          | phone number of booked place |
  | coordinates         | Number          | coordinates of booked palace (later to be used with MapKit) |
  | booked?             | Boolean         | has the user booked this place? |
  | Date                | Date            | date of reservation
  | Time                | Time            | time of reservation

### Networking
**List of network requests by screen**
* Login/SignUp Screen
   * (POST) creates new user
   <img src="https://imgur.com/nYYijVq.jpg" width=500>
   
   * (GET) allows user to login
* Home Screen 
   * (GET) Retrieves basic categories from API
* Favorites Screen
   * (GET) Retrieves user's favorites
* Map/Search Screen  
   * (GET) Gets user location information (in compliance with privacy settings)
   * (GET) Gets search information from API
* Detail Screen
   * (GET) retrieves detailed information depending on place/event
* Booking Screen
   * (GET) user booking details of time date  
   * (GET) user locaton of booking API
  Mybooking
    * (GET) Retrieves user booking - parse
    * (GET) Removes User booking - parse 
- [Create basic snippets for each Parse network request]
- [OPTIONAL: List endpoints if using existing API such as Yelp]
