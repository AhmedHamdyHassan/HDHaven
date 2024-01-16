# HDHaven
Flutter app for displaying wallpapers that allow user to download them to their device Note-> To Clone the code press on Master not Main

# App Features
## 1-User Authentication using Firebase
## 2-Dealing with Pixels API
## 3-Local Database using Sqflite to Store user's data and favorite images
## 4-Allow user to download images
## 5-Allow user to search for images like->(Nature, Tigers,...etc)
## 6-Infinity scroll to fetch more data from API->Pagination
# Folders
## Common
Which includes the shared items along the app
### Common Subfolders
#### components
Which includes the used Widgets along the App
#### enums
Which includes the used enums along the App
#### functionss
Which includes the Generic Functions that can be used in many screens
#### providers
Which includes the shared Provider along the whole app note-> not specefic for a single view
#### routess
Which includes the Routing in the App
## Models
Which includes all Data Models through the app note-> All Models are generated using Json Serializable Package (json_serializable: ^6.7.1)
## Repository
Which includes The class that will Deal with API (Pexils API)
## Services
Which includes Classes that will deal with (Sqlite Database , Firebase for Authentication , Shared Preferences , Dio) note -> all services are made in Singleton design pattern
## Utils
Which includes the Designing classes like app theme and app colors
## Views
Which includes Screens that will deal with User Interactions
# Screens
## Init Screen
Init Screens handle the Authentication Status if user is Already signed up or need to sign up -> if already signed up user will navigate to Home Screen directly if not user will be navigated to Login Screen
## Login Screen
Login Screen handles User Registration like if user have an account or user need to register
## Home Screen
Home Screen shows the Wallpaper and allow user to Search for Image or Scroll down to load more images or Select an image by pressing on it
## Details Screen
Details Screen Display the selected Image from Home Screen and display 2 Icon buttons that allow user to like or dislike the wallpaper or save it on download Folder on android device
## Favorite Screen
Favorite Screen display only the liked wallpapers

