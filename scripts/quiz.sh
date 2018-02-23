#!/bin/bash
# this assumes you have jq installed! if not: https://stedolan.github.io/jq/
# you'll also need to make this file executable, probably by running something like `chmod +x quiz.sh` or something similar
# then run with ./quiz.sh

# gets the full list of classes
curl -s 'https://www.cpsc213.io/rest/meetings?order=begins_at&select=id,title,slug,begins_at' | jq

# reading in the specific class' id and the user's JWT, if it's not already stored
read -p "Class id: "  classid

if [[ -z $JWT ]]; then
    read -p "JWT: " JWT
fi

# gets the quiz information for the class
curl -s -H "Authorization: Bearer $JWT" "https://www.cpsc213.io/rest/quizzes?meeting_id=eq.$classid" | jq

# reading in the quiz id (not the same as the class id)
read -p "Quiz id: " quizid

open=$(curl -s -o /dev/null -w "%{http_code}" -H "Authorization: Bearer $JWT" -X POST -d "quiz_id=$quizid" 'https://www.cpsc213.io/rest/quiz_submissions')

if [[ $open -ne 200 ]] && [[$open -ne 201 ]]; then
    echo
    echo "Can't create submission, exiting"
    echo "HTTP status code: $open"
    echo
    exit 1
fi

# starts the quiz submission
curl -s -H "Authorization: Bearer $JWT" -X POST -d "quiz_id=$quizid" 'https://www.cpsc213.io/rest/quiz_submissions'

# gets the list of questions
curl -s -H "Authorization: Bearer $JWT" "https://www.cpsc213.io/rest/quiz_questions?quiz_id=eq.$quizid&select=id,body,quiz_question_options(id,body)" | jq

echo "Answers: (type quit to quit)"
echo

# gets answers and sends requests out
while true
do
    read answer
    if [[ $answer =~ ^[0-9]+$ ]]; then
        curl -s -H "Authorization: Bearer $JWT" -X POST -d "quiz_question_option_id=$answer" 'https://www.cpsc213.io/rest/quiz_answers'
        echo "POSTed answer $answer"
    elif [[ "$answer" == "quit" ]]; then
        exit
    else
        echo "That wasn't an integer -- please only enter integer ids!"
    fi
done
