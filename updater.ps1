# message
# file name, version, description, usage, design tips
# params and vars
$datetime = (Get-Date -Format 'yyyy-MMM-dd, HH:mm:ss')
$msgbody = 'moved variables and secrets in the YML to the top position at each step, added parameters and modified resource in main.bicep'
$commitmessage = "$msgbody at $datetime"
$addtorepository = '.' #'deploy/azure-pipelines.yml'
#command body
git add $addtorepository
git commit -m $commitmessage
git push
# post operation, output handling, etc.