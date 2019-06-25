# BinChecker

Checks bin directories on linux comparing with a snapshot, using built-in bash and linux commands. 

An snapshot is a file containing a table with rows with different columns:

- Filename
- Permissions
- MD5sum

Each time the program runs, it compares the snapshot with the current status of the bin directories. It is thought to be run as a cronjob.
