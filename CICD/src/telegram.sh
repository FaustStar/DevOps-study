#!/bin/bash

if [[ $CI_JOB_NAME != "deploy-job" ]]; then
    CI_OR_CD="CI"
else
    CI_OR_CD="CD"
fi

if [[ $CI_JOB_STATUS = "success" ]]; then
    JOB_STATUS="SUCCESS😎"
else
    JOB_STATUS="FAILED💀"
fi

URL="https://api.telegram.org/bot$TELEGRAM_BOT_TOKEN/sendMessage"
TEXT="$CI_OR_CD%0A%0AProject:+$CI_PROJECT_NAME%0ABranch:+$CI_COMMIT_REF_SLUG%0AStage:+$CI_JOB_STAGE%0AJob:+$CI_JOB_NAME%0AStatus:+$JOB_STATUS"
TIME=10

curl -s --max-time $TIME -d "chat_id=$TELEGRAM_USER_ID&disable_web_page_preview=1&text=$TEXT" $URL > /dev/null