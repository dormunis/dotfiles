#!/bin/bash

BEARER=$(security find-generic-password -a todoist-next-actions -D bearer -s todoist -w)
if [ -z "$BEARER" ]; then
    echo "No bearer token saved as 'todoist-next-actions' (type 'bearer', service 'todoist')"
    exit 1
fi

TASKS=$(curl -XGET -s https://api.todoist.com/rest/v2/tasks?filter=%28%40next%20%7C%20today%20%7C%20overdue%29%20%26%20%28%21due%20after%3A%20today%29%20%26%20%21%40someday_maybe%20%7C%20%28p1%20%26%20no%20date%29 -H "Authorization: Bearer $BEARER")
TOTAL=`echo $TASKS | jq length`

echo "total $TOTAL"
echo $TASKS | jq -r 'sort_by(.priority) | .[] | "\(.id)  p\(.priority)\(if .due.is_recurring then "r" else "t" end)\t\(.created_at | sub("\\.[0-9]+Z$"; "Z") | fromdate | strftime("%b %d %H:%M"))  \(.content)"'

