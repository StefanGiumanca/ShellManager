x#!/bin/bash

# Files for storing users and sessions
USERS_FILE="users.txt"
LOGGED_IN_FILE="logged_in.txt"

# Function to create a new user account
create_account() {
    echo "Creating a new account"
    read -p "Enter username: " username
    read -sp "Enter password: " password
    echo

    # Check if the user already exists
    if grep -q "^$username" $USERS_FILE; then
        echo "Account already exists!"
    else
        echo "$username $password" >> $USERS_FILE
        echo "Account created successfully!"
    fi
}

# Function to log in
login() {
    echo "Login"
    read -p "Enter username: " username
    read -sp "Enter password: " password
    echo

    # Check if the username and password are correct
    if grep -q "^$username $password" $USERS_FILE; then
        echo "$username" > $LOGGED_IN_FILE
        echo "Logged in successfully!"
    else
        echo "Incorrect username or password."
    fi
}

# Function to log out
logout() {
    if [ -f $LOGGED_IN_FILE ]; then
        rm $LOGGED_IN_FILE
        echo "Logged out successfully!"
    else
        echo "You are not logged in."
    fi
}

# Function to check if anyone is logged in
check_logged_in() {
    if [ -f $LOGGED_IN_FILE ]; then
        echo "Logged-in user: $(cat $LOGGED_IN_FILE)"
    else
        echo "No one is logged in."
    fi
}

# Function to create a "word" directory
create_word_dir() {
    if [ -f $LOGGED_IN_FILE ]; then
        echo "Creating word directory"
        read -p "Enter the name of the word directory: " dir_name
        mkdir -p "$HOME/$dir_name"
        echo "Directory $dir_name created successfully!"
    else
        echo "You must be logged in to create a directory."
    fi
}

# Function to create an "exit" directory
create_exit_dir() {
    if [ -f $LOGGED_IN_FILE ]; then
        echo "Creating exit directory"
        read -p "Enter the name of the exit directory: " dir_name
        mkdir -p "$HOME/$dir_name"
        echo "Directory $dir_name created successfully!"
    else
        echo "You must be logged in to create a directory."
    fi
}

#MAIN MENU
while true; do
    echo "Menu:"
    echo "1. Create account"
    echo "2. Login"
    echo "3. Logout"
    echo "4. Check logged-in users"
    echo "5. Create word directory"
    echo "6. Create exit directory"
    echo "7. Exit"
    read -p "Choose an option: " option

    case $option in
        1) create_account ;;
        2) login ;;
        3) logout ;;
        4) check_logged_in ;;
        5) create_word_dir ;;
        6) create_exit_dir ;;
        7)
           if [ -n "$logged_in_user" ]; then
                echo "Goodbye, $logged_in_user! You've successfully exited the program."
            else
                echo "Goodbye! You've successfully exited the program."
            fi
            exit 0
            ;;
        *) echo "Invalid option!" ;;
    esac
done
