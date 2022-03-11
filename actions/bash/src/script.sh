#!/bin/sh
PR_NUMBER=$(jq -r ".pull_request.number" "$GITHUB_EVENT_PATH")
if [[ "$PR_NUMBER" == "null" ]]; then
	echo "This isn't a PR."
	exit 0
fi

COMMAND=$1
# Arg 2 is input. We strip ANSI colours.
INPUT=$(echo "$2" | sed 's/\x1b\[[0-9;]*m//g')
INPUT = $INPUT_INPUT

# Read TF_WORKSPACE environment variable or use "default"
WORKSPACE=${TF_WORKSPACE:-default}

# Read EXPAND_SUMMARY_DETAILS environment variable or use "true"
if [[ ${EXPAND_SUMMARY_DETAILS:-true} == "true" ]]; then
  DETAILS_STATE=" open"
else
  DETAILS_STATE=""
fi

# Read HIGHLIGHT_CHANGES environment variable or use "true"
COLOURISE=${HIGHLIGHT_CHANGES:-true}

ACCEPT_HEADER="Accept: application/vnd.github.v3+json"
AUTH_HEADER="Authorization: token $GITHUB_TOKEN"
CONTENT_HEADER="Content-Type: application/json"

PR_COMMENTS_URL=$(jq -r ".pull_request.comments_url" "$GITHUB_EVENT_PATH")
PR_COMMENT_URI=$(jq -r ".repository.issue_comment_url" "$GITHUB_EVENT_PATH" | sed "s|{/number}||g")
PR_COMMENT_ID=$(curl -sS -H "$AUTH_HEADER" -H "$ACCEPT_HEADER" -L "$PR_COMMENTS_URL" )
# | jq '.[] | select(.body|test ("### Terraform `init` Failed")) | .id')
echo PR_COMMENT_ID
PR_COMMENT_URL="$PR_COMMENT_URI/$PR_COMMENT_ID"
echo PR_COMMENT_URL

echo -e "\033[34;1mINFO:\033[0m Terraform init completed with no errors. Continuing."
PR_COMMENT="### Terraform \`init\` Failed
<details$DETAILS_STATE><summary>Show Output</summary>
\`\`\`
$INPUT
\`\`\`
</details>"
exit 0


##curl -sS -X DELETE -H "$AUTH_HEADER" -H "$ACCEPT_HEADER" -L "$PR_COMMENT_URL" > /dev/null
#
#
#
#  echo -e "\033[34;1mINFO:\033[0m Looking for an existing init PR comment."
#  PR_COMMENT_ID=$(curl -sS -H "$AUTH_HEADER" -H "$ACCEPT_HEADER" -L "$PR_COMMENTS_URL" | jq '.[] | select(.body|test ("### Terraform `init` Failed")) | .id')
#  if [ "$PR_COMMENT_ID" ]; then
#    echo -e "\033[34;1mINFO:\033[0m Found existing init PR comment: $PR_COMMENT_ID. Deleting."
#    
#    curl -sS -X DELETE -H "$AUTH_HEADER" -H "$ACCEPT_HEADER" -L "$PR_COMMENT_URL" > /dev/null
#  else
#    echo -e "\033[34;1mINFO:\033[0m No existing init PR comment found."
#  fi
#
#  # Exit Code: 0
#  # Meaning: Terraform successfully initialized.
#  # Actions: Exit.
#  if [[ $EXIT_CODE -eq 0 ]]; then
#    echo -e "\033[34;1mINFO:\033[0m Terraform init completed with no errors. Continuing."
#
#    exit 0
#  fi
#
#  # Exit Code: 1
#  # Meaning: Terraform initialize failed or malformed Terraform CLI command.
#  # Actions: Build PR comment.
#  if [[ $EXIT_CODE -eq 1 ]]; then
#    PR_COMMENT="### Terraform \`init\` Failed
#<details$DETAILS_STATE><summary>Show Output</summary>
#\`\`\`
#$INPUT
#\`\`\`
#</details>"
#  fi
#
#  # Add init failure comment to PR.
#  PR_PAYLOAD=$(echo '{}' | jq --arg body "$PR_COMMENT" '.body = $body')
#  echo -e "\033[34;1mINFO:\033[0m Adding init failure comment to PR."
#  curl -sS -X POST -H "$AUTH_HEADER" -H "$ACCEPT_HEADER" -H "$CONTENT_HEADER" -d "$PR_PAYLOAD" -L "$PR_COMMENTS_URL" > /dev/null
#
#  exit 0
#fi