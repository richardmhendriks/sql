# Assignment 1: Meet the farmersmarket.db and Basic SQL

🚨 **Please review our [Assignment Submission Guide](https://github.com/UofT-DSI/onboarding/blob/main/onboarding_documents/submissions.md)** 🚨 for detailed instructions on how to format, branch, and submit your work. Following these guidelines is crucial for your submissions to be evaluated correctly.

#### Submission Parameters:
* Submission Due Date: `January 25, 2025`
* Weight: 30% of total grade
* The branch name for your repo should be: `assignment-one`
* What to submit for this assignment:
    * This markdown (Assignment1.md) with written responses in Section 4
    * One Entity-Relationship Diagram (preferably in a pdf, jpeg, png format).
    * One .sql file 
* What the pull request link should look like for this assignment: `https://github.com/<your_github_username>/sql/pulls/<pr_id>`
    * Open a private window in your browser. Copy and paste the link to your pull request into the address bar. Make sure you can see your pull request properly. This helps the technical facilitator and learning support staff review your submission easily.

Checklist:
- [ ] Create a branch called `assignment-one`.
- [ ] Ensure that the repository is public.
- [ ] Review [the PR description guidelines](https://github.com/UofT-DSI/onboarding/blob/main/onboarding_documents/submissions.md#guidelines-for-pull-request-descriptions) and adhere to them.
- [ ] Verify that the link is accessible in a private browser window.

If you encounter any difficulties or have questions, please don't hesitate to reach out to our team via our Slack. Our Technical Facilitators and Learning Support staff are here to help you navigate any challenges.

*** 

## Section 1:
You can start this section following *session 1*.

Steps to complete this part of the assignment:
- Load the farmersmarket.db and browse its content
- Create a logical data model

<br>
If this is your first time in DB Browser for SQLite, the following instructions may help:

#### 1) Load Database
- Open DB Browser for SQLite
- Go to File > Open Database
- Navigate to your farmersmarket.db 
	- This will be wherever you cloned the GH Repo (within the **SQL** folder)
	- ![db_browser_for_sqlite_choose_db.png](./images/01_db_browser_for_sqlite_choose_db.png)

#### 2) Configure your windows
By default, DB Browser for SQLite has three windows, with four tabs in the main window and three tabs in the bottom right window
- Window 1: Main Window (Centre)
	- Stay in the Database Structure tab for now
- Window 2: Edit Database Cell (Top Right)
- Window 3: Remote (Bottom Right)
	- Switch this to DB Schema tab (very bottom)

Your screen should look like this (or very similar)
![db_browser_for_sqlite.png](./images/01_db_browser_for_sqlite.png)

#### 3) The farmersmarket.db
There are 10 tables in the Main Window:
1) booth
2) customer
3) customer_purchases
4) market_date_info
5) product
6) product_category
7) vendor
8) vendor_booth_assignments
9) vendor_inventory
10) zip_data

Switch to the Browse Data tab, booth is selected by default

<img src="./images/01_the_browse_data_tab.png" width="900">


Using the table drop down at the top left, explore some of the contents of the database

<img src="./images/01_the_table_drop_down_at_the_top_left.png" width="200">

Move on to the Logical Data Model task when you have looked through the tables


### Build Logical Data Model

Recall during session 1:

I diagramed the following four tables:
- product
- product_category
- vendor
- vendor_inventory

 <img src="./images/01_farmers_market_logical_model_partial.png" width="500">


#### Prompt 1:
Choose two tables and create a logical data model. There are lots of tools you can do this (including drawing this by hand), but I'd recommend [Draw.io](https://www.drawio.com/) or [LucidChart](https://www.lucidchart.com/pages/). 

A logical data model must contain:
- table name
- column names
- relationship type

Please do not pick the exact same tables that I have already diagrammed. For example, you shouldn't diagram the relationship between `product` and `product_category`, but you could diagram `product` and `customer_purchases`.

**HINTS**:
- You will need to use the Browse Data tab in the main window to figure out the relationship types.
- You can't diagram tables that don't share a common column
	- These are the tables that are connected
	- <img src="./images/01_farmers_market_conceptual_model.png" width="600">
- The column names can be found in a few spots (DB Schema window in the bottom right, the Database Structure tab in the main window by expanding each table entry, at the top of the Browse Data tab in the main window)

***

## Section 2:
You can start this section following *session 2*.

Steps to complete this part of the assignment:
- Open the assignment1.sql file in DB Browser for SQLite:
	- from [Github](./02_activities/assignments/assignment1.sql)
	- or, from your local forked repository  
- Complete each question

### Write SQL

#### SELECT
1. Write a query that returns everything in the customer table.
2. Write a query that displays all of the columns and 10 rows from the customer table, sorted by customer_last_name, then customer_first_ name.

<div align="center">-</div>

#### WHERE
1. Write a query that returns all customer purchases of product IDs 4 and 9.
2. Write a query that returns all customer purchases and a new calculated column 'price' (quantity * cost_to_customer_per_qty), filtered by vendor IDs between 8 and 10 (inclusive) using either:
	1.  two conditions using AND
	2.  one condition using BETWEEN

<div align="center">-</div>

#### CASE
1. Products can be sold by the individual unit or by bulk measures like lbs. or oz. Using the product table, write a query that outputs the `product_id` and `product_name` columns and add a column called `prod_qty_type_condensed` that displays the word “unit” if the `product_qty_type` is “unit,” and otherwise displays the word “bulk.”

2. We want to flag all of the different types of pepper products that are sold at the market. Add a column to the previous query called `pepper_flag` that outputs a 1 if the product_name contains the word “pepper” (regardless of capitalization), and otherwise outputs 0.

<div align="center">-</div>

#### JOIN
1. Write a query that `INNER JOIN`s the `vendor` table to the `vendor_booth_assignments` table on the `vendor_id` field they both have in common, and sorts the result by `vendor_name`, then `market_date`.

***

## Section 3:
You can start this section following *session 3*.

Steps to complete this part of the assignment:
- Open the assignment1.sql file in DB Browser for SQLite:
	- from [Github](./02_activities/assignments/assignment1.sql)
	- or, from your local forked repository  
- Complete each question

### Write SQL

#### AGGREGATE
1. Write a query that determines how many times each vendor has rented a booth at the farmer’s market by counting the vendor booth assignments per `vendor_id`.
2. The Farmer’s Market Customer Appreciation Committee wants to give a bumper sticker to everyone who has ever spent more than $2000 at the market. Write a query that generates a list of customers for them to give stickers to, sorted by last name, then first name.
   
**HINT**: This query requires you to join two tables, use an aggregate function, and use the HAVING keyword.

<div align="center">-</div>

#### Temp Table
1. Insert the original vendor table into a temp.new_vendor and then add a 10th vendor: Thomass Superfood Store, a Fresh Focused store, owned by Thomas Rosenthal
   
**HINT**: This is two total queries -- first create the table from the original, then insert the new 10th vendor. When inserting the new vendor, you need to appropriately align the columns to be inserted (there are five columns to be inserted, I've given you the details, but not the syntax)

To insert the new row use VALUES, specifying the value you want for each column:  
`VALUES(col1,col2,col3,col4,col5)`

<div align="center">-</div>

#### Date
1. Get the customer_id, month, and year (in separate columns) of every purchase in the customer_purchases table.
   
**HINT**: you might need to search for strfrtime modifers sqlite on the web to know what the modifers for month and year are!

2. Using the previous query as a base, determine how much money each customer spent in April 2022. Remember that money spent is `quantity*cost_to_customer_per_qty`.
   
**HINTS**: you will need to AGGREGATE, GROUP BY, and filter...but remember, STRFTIME returns a STRING for your WHERE statement!!

*** 

## Section 4:
You can start this section anytime.

Steps to complete this part of the assignment:
- Read the article
- Write, within this markdown file, <1000 words.

### Ethics

Read: Qadri, R. (2021, November 11). _When Databases Get to Define Family._  Wired. <br>
    https://www.wired.com/story/pakistan-digital-database-family-design/

Link if you encounter a paywall: https://web.archive.org/web/20240422105834/https://www.wired.com/story/pakistan-digital-database-family-design/

**What values systems are embedded in databases and data systems you encounter in your day-to-day life?**

Consider, for example, concepts of fariness, inequality, social structures, marginalization, intersection of technology and society, etc.


```
Your thoughts...
```
A key issue in conceptualizing, formulating and applying database systems concerns cognitive biases, particularly those related to human value systems. These cognitive biases can be conceived as systematic errors in the way we reason about our surroundings and the world in general due to our subjective perception of reality. They are particularly salient in contemporary life because they are heavily reinforced by algorithmic social media, politically-captured mainstream media and increasingly ideological institutions. 

The circulated article identifies perceived biases in the identity verification processes of Pakistan’s National Database and Registration Authority in the form of value judgements respecting family structure and formation, “gender schema”, and parentage, while making key observations of relevance to this course, including that:
•	i) the lack of design consideration before implementation can result in inflexible databases;
•	ii) the importance and intensiveness of citizen verification increases the need for data quality; and
•	iii) it is challenging to “impos[e] computational structures on complex social phenomena”

Here, I further explore the last of these observations, namely the challenge of designing data surveys and databases for handling complex social data, by considering the handling of “gender identity” in the University of Toronto’s Equity Survey, a database survey made available to every student and employee. This particularly issue of “gender identity” is near (if not at) the top of the list of culture war topics. One reason that ‘gender’ has proven so useful in the culture wars (and so difficult for data surveyors and database designers) is that both conservatives and progressives use this term to mean different things in different contexts for different agendas. One of the fundamentals of any database is to clearly define the meaning of terms as they are used within a database, as well as how they might be used in other contexts outside of that database. 

So, what is “gender”? One of the more thorough efforts that I have seen to define this term is as follows:

“GENDER1. A polite sounding word for the division between men and women, understood as a traditional alternative word for biological sex/the division between biological males and females. …

GENDER2. A word for social stereotypes, expectations and norms of ‘masculinity’ and ‘femininity’, originally directed towards biological males and females respectively. …

GENDER3. A word for the division between men and women, understood, by definition, as a division between two sets of people: those who have the social role of masculinity projected onto them, and those who have the social role of femininity projected onto them. …

GENDER4. A shortened version of the term ‘gender identity’.” (Stock, K. 2021. Material Girls, at p. 38)

This last of these meanings provides a nice segue into the UofT Equity Survey. The survey queries into 1) Indigenous Identity; 2) Racial/Ethnocultural Identity; 3) Religious or Spiritual Affiliations; 4) Gender Identity; 5) Sexual Orientation; and 6) Disability. The Gender Identity question reads as follows:

“Please indicate which of the following best describe your gender identity. … check as many as apply:
•	Genderqueer
•	Man (cis, trans)
•	Nonbinary
•	Questioning
•	Two-spirit
•	Woman (cis, trans)
•	My Gender Identity is best described as (please specify)
•	Prefer not to answer   
[A link leads to definitions and below, for brevity, are two illustrative definitions:]
•	Genderqueer: A person who does not conform to social expectations of binary gender identity and gender expression, a person who might challenge social expectations of masculine and feminine behaviour and appearance.
•	Man (cis, trans): A person whose gender identity may correspond with social expectations associated with being a man and/or masculine. People who identify as men may be cis (gender identity ‘aligns’ with birth assigned sex) or trans (gender identity is different from birth assigned sex).

Below are three categories of questions (with examples) that I might ask when reviewing a survey design of this kind.
1.	Defined and not defined
•	What is the meaning of “gender identity” and why is it not defined? We are told that it is “different … from … sex” and so presumably excludes GENDER1, and the definition of “genderqueer” suggests that “gender” refers to GENDER2, but nowhere is the term defined.  
•	Several of the “gender identity” definitions refer to “sex”. What is “sex”, and why is it not defined?
•	Why is “man” defined in terms of GENDER2 and not in terms of GENDER1 (i.e. biological sex, a universally common definition) or for that matter GENDER3 (i.e., a person onto whom the social role of masculinity is projected, a common experience of many men)?  
2.	Inclusions and exclusions
•	Why are respondents not provided the opportunity to indicate “No gender identity”?
•	Why does the survey contain no core question about biological sex, despite asking about sexual orientation, and frequently referring to “sex”? 
3.	Values, biases and implications
•	What values underly the survey design? (e.g., equity vs. equality, authority vs. subversion, liberty, individuality vs. collectivity, etc.)
•	How might this survey be biased to promote some findings while downplaying others?
•	What are the potential implications for survey data results of key definitions?

In summary, political, social and moral biases find their way into data surveys and database designs. Surveyors and designers need to be cognizant of these realities and the manner in which our biases may influence our work and research.
