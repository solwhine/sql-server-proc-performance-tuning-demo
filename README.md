# SQL Server Stored Procedure Performance Tuning Demo

This project demonstrates how to analyze and improve the performance of a SQL Server stored procedure using:
- Execution plans
- IO and TIME statistics
- Query rewrites and indexing insights

##  Objective

To showcase practical skills in:
- Writing and executing stored procedures
- Capturing and analyzing query performance using `SET STATISTICS IO` and `SET STATISTICS TIME`
- Understanding execution plans (`.sqlplan`)
- Isolating bottlenecks in SQL Server

---

##  Project Contents

| File                     | Description |
|--------------------------|-------------|
| `CreateSchema.sql`       | Creates necessary schema/tables for the tuning scenario |
| `CreateProcedure.sql`    | Defines the stored procedure to be optimized |
| `ExecuteWithStats.sql`   | Executes the procedure with `SET STATISTICS IO, TIME ON` |
| `IOStats.txt`            | Captured IO and TIME stats for analysis |
| `ExecutionPlan.sqlplan`  | Actual execution plan saved from SSMS |
| `README.md`              | Project overview and usage instructions |
| `LICENSE`                | MIT License for open use |

---

##  How to Use

1. Run `CreateSchema.sql` to create the schema
2. Run `CreateProcedure.sql` to create the stored procedure
3. Run `ExecuteWithStats.sql` to execute and measure performance
4. Open `ExecutionPlan.sqlplan` in SSMS to view the graphical plan
5. Review `IOStats.txt` to analyze logical reads, CPU time, and duration

---

## Skills Demonstrated

- SQL Server stored procedure development
- Performance troubleshooting (IO, TIME, execution plan)
- T-SQL scripting and optimization
- Git branching and pull request workflows
- TSQLT framework

---

##  Why This Project?

This repo is designed to reflect hands-on, real-world database development practices — from writing T-SQL to performance tuning and source control. Ideal for:

- Showcasing SQL Server development experience to recruiters
- Practicing execution plan reading and optimization techniques
- Showcasing the exposure to TSQLT framework via creation of unit tests using the framework
- Building a strong GitHub portfolio
  

---
## tSQLt Unit Tests

Stored procedure `usp_calculateSales` is tested using the `tSQLt` framework.

Test class: `calculateSalesTests`

Test procedure:
- Verifies that the output parameter returns the expected number of products sold in the last year.

##  License

MIT — feel free to use and extend.
