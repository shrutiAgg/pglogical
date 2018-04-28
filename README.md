# pglogical data extraction and replication
This repository depicts how postgres replication takes place using pglogical plugin.
Old applications running postgres will be configured to point to new postgres databases along with pglogical plugin.
Two nodes needs to be created for postgres. Master will be called as provider and replicated one will be called as subscriber.

Provider Setup:

1. Take backup of data from the existing applications which are pointing to postgres docker container and then stop the applications so as not to add/update any data untill migration is done. Script to perform this is kept at path : 
2. Remove the old postgres container and install the new postgres container which is having pglogical plugin. Load the docker image and docker file to create new postgres container. The dockerfile is kept at path :
3. Start the applications and perform data migration from the backup of data that has been taken in step 1. 
4. Once the data migration is done successfully then run the script kept at path: for configuring pglogical nodes on provider node.
5.	Once the subscriber setup is completed then the status of all nodes can be checked using sql command select * from pg_replication_slots.

Subscriber Setup:

1. Load the docker image and docker file to create new postgres container. 
2. Run the DDL scripts to create tables present in provider node. Scripts are present at path:
3. Now run the scripts to configure pglogical node. This script requires hostname as an argument.
   Example ./ pglogical-subscriber.sh 10.0.0.23. This ip is  the ip address of Provider database. 
4. After it is configured go to subscriber node using docker exec -it ldars-postgres-replica sh and the login to individual database to see    if subscription is working or not by following command
    Select * from pglogical.show_subscription_status();

