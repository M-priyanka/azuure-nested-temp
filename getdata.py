import sys
from azure.cosmosdb.table.tableservice import TableService
from azure.cosmosdb.table.models import Entity
partitionKey='1000'
rowkey=sys.argv[1]
tablename='demolabtable'

table_service = TableService(account_name='demolabsstorage', account_key='nO8J3JrzA+8+hvGT/HzjwkJFNPb0j+BQlUBWpU+TQuadjdhB1rKDX2HD/OEol6Y0x/9SV4RnX+7MvwDmiiiJVg==')

#Query for an entity
task = table_service.get_entity(tablename, partitionKey, rowkey)
ISUSED=task.ISUSED
if(ISUSED == "YES"):
    print("Details are already in use")
else :
    print ('{\"$schema\":\"https://schema.management.azure.com/schemas/2015-01-01/deploymentParameters.json#\",\"contentVersion\":\"1.0.0.0\",')
    print ('\"parameters\": {')
    print ('\"SQLADMINISTRATORLOGIN\":{\"value\":\"'+task.SQLADMINISTRATORLOGIN+'\"},')
    print ('\"SQLADMINISTRATORLOGINPASSWORD\":{\"value\":\"'+task.SQLADMINISTRATORLOGINPASSWORD+'\"},')
    print ('\"IOTHUBSKUNAME\":{\"value\":\"'+task.IOTHUBSKUNAME+'\"},')
    print '\"CAPACITYUNITS\":{\"value\":'+task.CAPACITYUNITS+'},'
    print ('\"D2CMESSAGERETENTIONINDAYSPERIOD\":{\"value\":'+task.D2CMESSAGERETENTIONINDAYSPERIOD+'},')
    print ('\"D2CPARTITIONCOUNT\":{\"value\":'+task.D2CPARTITIONCOUNT+'},')
    print ('\"NUMBEROFSTREAMINGUNITS\":{\"value\":'+task.NUMBEROFSTREAMINGUNITS+'},')
    print ('\"username\":{\"value\":\"'+task.username+'\"},')
    print ('\"password\":{\"value\":\"'+task.password+'\"},')
    print ('\"tenant\":{\"value\":\"'+task.tenant+'\"}')
    print ('}')
    print ('}')

    # Update the entity created earlier
    task={'PartitionKey': partitionKey, 'RowKey': rowkey,'SQLADMINISTRATORLOGIN':task.SQLADMINISTRATORLOGIN,'SQLADMINISTRATORLOGINPASSWORD':task.SQLADMINISTRATORLOGINPASSWORD,'ISUSED':'YES','IOTHUBSKUNAME':task.IOTHUBSKUNAME,'CAPACITYUNITS':task.CAPACITYUNITS,'D2CMESSAGERETENTIONINDAYSPERIOD':task.D2CMESSAGERETENTIONINDAYSPERIOD,'D2CPARTITIONCOUNT':task.D2CPARTITIONCOUNT,'NUMBEROFSTREAMINGUNITS':task.NUMBEROFSTREAMINGUNITS,'username':task.username,'password':task.password,'tenant':task.tenant}
    table_service.update_entity('demolabtable', task)
