#!/bin/bash

# Set the personal access token and Jira ticket ID
PAT=""


# Set the time spent, category, and description
TICKET_ID="-1"
TIME_SPENT="1d"
CATEGORY="New Feature/CR implementation"
DESCRIPTION="187579 500 valmin"
USER="n.rovdo"

# ORGANIZATION="clarksonscloud"
# PROJECT="CTrade"
# PATAZURE=""

ORGANIZATION="chinsay"
PROJECT="Sea%20Phoenix"
PATAZURE=""


WORK_ITEMS=$(curl -s -u :$PATAZURE "https://dev.azure.com/$ORGANIZATION/$PROJECT/_apis/wit/wiql?api-version=6.0&queryType=tree" \
-H "Content-Type: application/json" \
--data-binary "{\"query\": \"select [System.Id], [System.TeamProject] from WorkItems where [System.AssignedTo] = @me  ORDER BY [System.ChangedDate] DESC\"}")

TICKETID=$(echo $WORK_ITEMS | jq -r '.workItems[0]."id"')


ITEM_URL=$(echo $WORK_ITEMS | jq -r '.workItems[0]."url"')
FIRST_ITEM=$(curl -s -u :$PATAZURE $ITEM_URL)
TICKETTITLE=$(echo $FIRST_ITEM | jq -r '.fields."System.Title"')

DESCRIPTION="${TICKETID} ${TICKETTITLE}"


# Set the Jira REST API URL
URL="https://jira.itransition.com/rest/itransition-worklog/2/worklog/create?userName=${USER}"

# Create the JSON payload
JSON="{\"comment\": \"${DESCRIPTION}\",\"timeSpent\": \"${TIME_SPENT}\",\"issueKey\": \"${TICKET_ID}\",\"startDate\": \"$(date +%Y-%m-%d) 06:00:00\",\"category\": \"${CATEGORY}\",\"author\": \"${USER}\"}"

echo ${JSON} | python -m json.tool

echo "Press [Enter] to send request to JIRA"
read -rsn2 key

# Call the Jira REST API with the personal access token
curl -X POST \
  --write-out "%{http_code}\n" --silent --output /dev/null \
  -H "Authorization: Bearer ${PAT}" \
  -H "Content-Type: application/json" \
  -d "${JSON}" \
  "${URL}"
  
read -rsn2 key
