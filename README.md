# simple_app_with_firestore

A new Flutter project.

## Getting Started

This project uses firestore to store user input data and views it.

# Widgets used in InputPage:

  - Scaffold
      - body
          - Center to centeralize content of the page
            - SingleChildScrollView to make page scrollable
                - Form to take data from user and validate it
                    - Column to put widgets vertically
                        - Image.asset to add and image
                        - CustomTextField to ask the user to enter his username, age and favorite hobby
                        - Row to put two of CustomButton horizontally
                            - The first CustomTextField is used to save user data to firestore
                            - The second CustomTextField shows up after the data is saved successfully to go to the next page
# Widgets used in UserDetails Page:

 - Scaffold
     - appBar to put title of the page
     - body
         - Column to put widgets vertically
             - CircleAvatar to put a circular image
             - Text to add username
             - UserDetailItem to view username, age and favorite hobby
