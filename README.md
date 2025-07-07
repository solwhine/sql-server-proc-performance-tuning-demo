# SQL Server Stored Procedure Performance Tuning Demo

This project showcases SQL Server development with a strong emphasis on:
- 📈 Performance optimization
- ✅ Unit testing using [`tSQLt`](https://tsqlt.org)
- ⚙️ Index tuning, statistics interpretation, and memory grant analysis

---

##  Key Features

###  Stored Procedure: `usp_calculateSales`
Calculates per-product revenue and quantity sold in the last 1 year.

- Aggregates product sales using recent data
- Outputs total number of products sold (via `OUTPUT` parameter)
- Uses a temporary table for intermediate aggregation

###  Optimization Highlights
- Replaced `DATEADD(...)` filter with **SARGable filter using variables**
- Replaced `@table variable` with `#temp table` for better plan quality
- Added **nonclustered index** on `Sales(SaleDate, ProductID)` with INCLUDE for optimal coverage
- Improved execution plan to reduce page reads and elapsed time
- Analyzed and explained **memory grants** and **cardinality mismatch**

---

##  tSQLt Unit Testing

This repo uses [`tSQLt`](https://tsqlt.org) for SQL unit testing.

Test class: `calculateSalesTests`

| Test File                                                      | Purpose                                        |
|----------------------------------------------------------------|------------------------------------------------|
| `00_createtestclass.sql`                                     | Registers test class using `tSQLt.NewTestClass` |
| `01_test_usp_calculateSales_returns_correct_count.sql`         | Validates output count based on controlled test data |
| `02_run_all_tests.sql`                                         | Runs the full test suite                       |

###  Fake Tables
We use `tSQLt.FakeTable` to isolate data and test logic.

---

##  Performance Analysis Files

| File                                     | Description                                |
|------------------------------------------|--------------------------------------------|
| `plan before optimization.sqlplan`       | Actual execution plan (before tuning)       |
| `plan after optimization.sqlplan`        | Optimized plan showing index seek, reduced I/O |
| `io and time statistics before.txt`      | `SET STATISTICS IO, TIME` output (before)   |
| `io and time stats after optimization.txt` | `SET STATISTICS IO, TIME` output (after)    |
