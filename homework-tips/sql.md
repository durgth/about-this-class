- How to visualize a SQL database:
	- The entire database is an Excel spreadsheet
	- Individual tables are sheets within the spreadsheet
	- Each table (i.e. sheet) can have its own fields (column names), 
      and you can also have cross-table references

- Useful commands for exploring your SQL database:
	- `sqlite3 foo.db` - enters the interactive shell for the database called `foo.db`
	- `.exit` - quits the interactive shell
	- `.schema` - shows the schema for the database's tables
	- `.tables` - lists the tables in the database
    - read more [here](https://www.sqlite.org/cli.html)

- For this assignment:
    - Make sure you create the questions in the directory that you plan on submitting.
      E.g., I have a directory called `assignment_sql-kljensen` with contents like
      the following

      ```
      .
      ├── README.md
      ├── p1.sql
      ├── p2.sql
      ├── p3.sql
      ├── p4.sql
      ├── p5.sql
      ├── p6.sql
      └── p7.sql
      ```

      You'll be adding those to version control and submitting.

	- If everything looks about right but the tests aren't passing, 
	make sure that you're sorting the results in the right order
	- Don't forget the semicolon at the end of each SQL command!
	- Committing your work to git after each part will help prevent 
	tragic mistakes 
    - The first question may say you need an "ORDER BY" clause. I didn't,
      and that is misleading. 

- Latest binaries for testing code. Fixes a bug affecting some windows and linux systems
    - http://public.cpsc213.io/cpsc213sqlhw-linux-v2.0
    - http://public.cpsc213.io/cpsc213sqlhw-mac-v2.0
