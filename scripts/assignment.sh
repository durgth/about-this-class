#!/bin/bash
# this assumes you have jq installed! if not: https://stedolan.github.io/jq/
# you'll also need to make this file executable, probably by running something like `chmod +x assignment.sh` or something similar
# then run with ./assignment.sh

# reads in user's JWT if $JWT doesn't exist
if [[ -z $JWT ]]; then
    read -p "JWT: " JWT
fi

# reads in user's id (found on dashboard of 213 site)
read -p "User id: " userId

# gets list of assignments
echo "Assignment list:"
curl -H "Authorization: Bearer $JWT" "https://www.cpsc213.io/rest/assignments?select=slug,is_open" | jq

# reads in assignment slug
read -p "Slug: " slug

# creates assignment submission
curl -X POST -H "Authorization: Bearer $JWT" -d "user_id=$userId&assignment_slug=$slug" "https://www.cpsc213.io/rest/assignment_submissions" | jq

# gets list of assignment submissions
echo "Submission list:"
curl -H "Authorization: Bearer $JWT"  'https://www.cpsc213.io/rest/assignment_submissions' | jq

# reads in submission id
read -p "Assignment submission id: " submissionId

# gets assignment fields
echo "Fields:"
curl -H "Authorization: Bearer $JWT" "https://www.cpsc213.io/rest/assignment_fields?assignment_slug=eq.$slug" | jq

echo "Enter a field id, hit enter, then the text/link you're submitting for that field, then hit enter again"
while true
do
    read fieldId
    read body
    curl -X POST -H "Content-Type: application/json" \
    -H "Authorization: Bearer $JWT" \
    -d "{\"assignment_submission_id\": $submissionId, \"assignment_field_id\": $fieldId, \"body\": \"$body\"}" "https://www.cpsc213.io/rest/assignment_field_submissions" | jq
    echo
    echo "Enter another field id and link, or hit ctrl-c to exit."
    echo
done
