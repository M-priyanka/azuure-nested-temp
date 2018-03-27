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
        #continue
        print("Details are already in use")
else :
    print ('{')
    print ('\"INPUTURL\":{\"value\":\"'+task.INPUTURL+'\"},')
    print ('\"username\":{\"value\":\"'+task.username+'\"},')
    print ('\"password\":{\"value\":\"'+task.password+'\"},')
    print ('\"tenant\":{\"value\":\"'+task.tenant+'\"}')
    print ('}')

    # Update the entity created earlier
    task={'PartitionKey': partitionKey, 'RowKey': rowkey,'ISUSED':'YES','INPUTURL':task.INPUTURL,'username':task.username,'password':task.password,'tenant':task.tenant}
    table_service.update_entity('demolabtable', task)
