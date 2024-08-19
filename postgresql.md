# PostgreSQL

**Logical replication** is a method of replicating data objects and their changes, based on the replication identity of the objects and their changes.

Logical replication uses **publish and subscribe model** where one or more subscribers subscribes to one or more publications on a publisher node.

Logical replication gives you control over data replication and security.

Logical replication architecture
1. Take a snapshot of the data on the publisher database and copy it to the subscriber database.
2. The changes in the publisher databases are sent to the subscriber in real time
3. The subscriber applies the data in the same order as the publisher, so that transactional consistency is guaranteed for publications within a single subscription.

**XMIN replication** is to use the hidden PostgreSQL system column `xmin` to select only the new or changed rows since the last update. But XMIN method has disadvantages.
- Cannot replicate row deletions
- Slower than logical replication

