# Pewlett-Hackard-Analysis


## Overview of the analysis

### Requirements

A large company Pewlett-Hackard which has rapid rate of retiring employees
initially required some answers to create a retiring package for a particular set of
employees and to manage which position they need to fill in the near future. Now the company requires to answer some question to manage as many current employees reach the retirement rate.

The questions are listed below:

- Number of retiring employees per tittle
- Employees who are eligible to participate in a mentorship program

### Purpose

  The purpose of this analysis is to answer the questions required by
  Pewlett-Hackard to manage and control their future retiring employees.  

## Results

- retirement_titles.csv Provides the employees who were born between
January 1, 1952 and December 31, 1955 including employees who were already
retired and some employees have more that one job title because they have switched titles over the years. The total of this particular multiset of employees retired
and not retired is 133.776.


![retirement_titles.csv](https://github.com/lindaperez/pewlett-hackard-analysis/blob/main/images/derivable_1_ALL.png)


To remove this duplicates the file  unique_titles.csv was created:

- unique_titles.csv Provides employees with their job titles who aren't retired
yet who were born between  January 1, 1952 and December 31, 1955. The total
amount of this employees with titles is 72458


![unique_titles.csv](https://github.com/lindaperez/pewlett-hackard-analysis/blob/main/images/derivable_1_2_unique.png)

To organize better the distribution of employees and titles the filledretiring_titles.csv was created:

- retiring_titles.csv Provides the Retiring Titles table that contains
the number of titles filled by employees who are retiring and who were born
between  January 1, 1952 and December 31, 1955. The Number of
Retiring Employees by Job Title is 72458 and the list of title includes
the set of {"Senior Engineer", "Senior Staff", "Engineer", "Staff",
"Technique Leader", "Assistant Engineer", "Manager" }

![retiring_titles.csv ](https://github.com/lindaperez/pewlett-hackard-analysis/blob/main/images/derivable_1_3.png)


 To hold the employees who are eligible to participate in a mentorship program
the file mentorship_eligibilty.csv was created

- mentorship_eligibilty.csv Provides the Mentorship Eligibility table for current employees who were born between January 1, 1965 and December 31, 1965.
The total mentorship is 1549

![mentorship_eligibilty.csv ](https://github.com/lindaperez/pewlett-hackard-analysis/blob/main/images/derivable_2.png)

## Summary

- How many roles will need to be filled as the "silver tsunami" begins to make an impact?

  The amount of roles that need to be filled is 72458

![impact_query](https://github.com/lindaperez/pewlett-hackard-analysis/blob/main/images/summary_1.png)

- Are there enough qualified, retirement-ready employees in the departments to mentor the next generation of Pewlett Hackard employees?

  No, there are only 1549
  
![qualified_query](https://github.com/lindaperez/pewlett-hackard-analysis/blob/main/images/summary_2.png)

