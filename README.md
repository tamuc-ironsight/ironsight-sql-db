# Ironsight SQL Database

![SQL Database EER Diagram](/ironsight_db_image.png)

Database that Ironsight uses for storing users, virtual machines, labs and templates

***

## Installation

Prerequisites:

- MySQL server [(Recommended instructions)]("https://www.digitalocean.com/community/tutorials/how-to-install-mysql-on-ubuntu-20-04")
- Linux server (untested on other operating systems)

Best practices:

- It is ideal to run the SQL server on the same host as the Ironsight API handler. This ensures secure communication between the web dashboard and the data since we can guarantee that the only network traffic will be between the dashboard and the API, not the API handler and another host. <strong>However</strong>, please note that the API handler and the SQL server <strong>must</strong> be able to communicate with each other.
- While not required, it is recommended that stored passwords are hashed. Cloud-init can read plaintext passwords, but they recommend using the following command to generate a hash: 
  - `mkpasswd --method=SHA-512 --rounds=4096`

Clone this repo to a folder accessible by the user that will import this SQL schema into their database

```bash
git clone git@github.com:tamuc-ironsight/ironsight-sql-db.git
```

Once this is complete, navigate to the folder and run the following commands:

```bash
mysql -u username -p database_name < ironsight_db.sql
```

It is recommended to use the full path for `ironsight_db.sql` but it isn't required.
Lastly, make sure the database is accessible in the environment Ironsight API will be running.
