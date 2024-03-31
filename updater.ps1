# message
# file name, version, description, usage, design tips
# params and vars
$datetime = (Get-Date -Format 'yyyy-MMM-dd, HH:mm:ss')
$msgbody = 'relocating variables'
$commitmessage = "Try to resolve 'Error: Login failed with Error: Using auth-type: SERVICE_PRINCIPAL. Not all values are present. Ensure 'client-id' and 'tenant-id' are supplied.. Double check if the 'auth-type' is correct. Refer to https://github.com/Azure/login#readme for more information.' at $datetime"
$addtorepository = '.' #'deploy/azure-pipelines.yml'
#command body
git add $addtorepository
git commit -m $commitmessage
git push
# post operation, output handling, etc.