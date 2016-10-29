#!/bin/bash

# Custom made .gitconfig.local using .gitconfig.local.example

source ./lib/utils.sh

setup_gitconfiglocal() {
    grep 'user = GITHUBUSER' ./example/.gitconfig.local.example > /dev/null 2>&1
    if [[ $? = 0 ]]; then

        read -r -p "What is your github.com username? " githubuser

        fullname=`osascript -e "long user name of (system info)"`

        if [[ -n "$fullname" ]];then
            lastname=$(echo $fullname | awk '{print $2}');
            firstname=$(echo $fullname | awk '{print $1}');
        fi

        if [[ -z $lastname ]]; then
            lastname=`dscl . -read /Users/$(whoami) | grep LastName | sed "s/LastName: //"`
        fi
        if [[ -z $firstname ]]; then
            firstname=`dscl . -read /Users/$(whoami) | grep FirstName | sed "s/FirstName: //"`
        fi

        email=`dscl . -read /Users/$(whoami)  | grep EMailAddress | sed "s/EMailAddress: //"`

        if [[ ! "$firstname" ]];then
            response='n'
        else
            echo -e "I see that your full name is $COL_YELLOW$firstname $lastname$COL_RESET"
            read -r -p "This will be used as your github author name. Is this correct? [Y|n] " response
        fi

        if [[ $response =~ ^(no|n|N) ]];then
            read -r -p "What is your first name? " firstname
            read -r -p "What is your last name? " lastname
        fi
        fullname="$firstname $lastname"

        bot "Great $fullname, "

        if [[ ! $email ]];then
            response='n'
        else
            echo -e "The best I can make out, your email address is $COL_YELLOW$email$COL_RESET"
            read -r -p "Is this correct? [Y|n] " response
        fi

        if [[ $response =~ ^(no|n|N) ]];then
            read -r -p "What is your email? " email
            if [[ ! $email ]];then
                error "you must provide an email to configure .gitconfig.local"
                exit 1
            fi
        fi

        sed -e "s/GITHUBUSER/$githubuser/g" -e "s/AUTHORNAME/$firstname $lastname/g" -e "s/AUTHOREMAIL/$email/g" example/.gitconfig.local.example > git/.gitconfig.local
        
        bot "putting items in .gitconfig.local with your info ($COL_YELLOW$fullname, $email, $githubuser$COL_RESET)"
        ok
    fi
}

bot "setup personal github information"

setup_gitconfiglocal
