# Recursive CTEs

## Simple Definition
A recursive CTE is a CTE that refers to itself.

## Intuition
It is useful when data forms a hierarchy or chain.
Sakila does not have a perfect employee-manager tree table, so recursive examples often use generated sequences or custom hierarchy examples.

## Syntax

```sql
WITH RECURSIVE cte_name AS (
    -- base query
    SELECT ...

    UNION ALL

    -- recursive query
    SELECT ...
    FROM cte_name
    WHERE ...
)
SELECT *
FROM cte_name;
```

## Sakila-Friendly Example 1: Generate numbers 1 to 10

```sql
WITH RECURSIVE numbers AS (
    SELECT 1 AS n
    UNION ALL
    SELECT n + 1
    FROM numbers
    WHERE n < 10
)
SELECT *
FROM numbers;
```

This is useful for understanding how recursion works:
- Base case starts with 1
- Recursive step adds 1
- Stop when `n < 10` is no longer true

## Sakila-Friendly Example 2: Staff reporting hierarchy
Sakila's built-in schema does not provide a full employee hierarchy table, but you can learn the pattern with a small custom example.

```sql
WITH RECURSIVE staff_hierarchy AS (
    SELECT 1 AS staff_id, 'Manager' AS role, NULL AS manager_id
    UNION ALL
    SELECT 2 AS staff_id, 'Assistant Manager' AS role, 1 AS manager_id
    UNION ALL
    SELECT 3 AS staff_id, 'Clerk' AS role, 2 AS manager_id
),
org_chart AS (
    SELECT staff_id, role, manager_id, 1 AS level
    FROM staff_hierarchy
    WHERE manager_id IS NULL

    UNION ALL

    SELECT s.staff_id, s.role, s.manager_id, o.level + 1
    FROM staff_hierarchy s
    JOIN org_chart o
        ON s.manager_id = o.staff_id
)
SELECT *
FROM org_chart
ORDER BY level, staff_id;
```

## When to Use
- Hierarchies
- Trees
- Sequence generation
- Path traversal problems

## Common Mistakes
- Missing a stop condition
- Using `UNION` when `UNION ALL` is better
- Not understanding the difference between base and recursive parts

## Interview Tips
- Clearly explain:
  - Base case
  - Recursive case
  - Termination condition
- Even if the company uses Sakila-like data, recursive CTE questions usually target general SQL skill

## Advanced Example
Generate monthly numbers for reporting logic.

```sql
WITH RECURSIVE months AS (
    SELECT 1 AS month_num
    UNION ALL
    SELECT month_num + 1
    FROM months
    WHERE month_num < 12
)
SELECT month_num
FROM months;
```

This can help build reporting scaffolds when some months have no data.
