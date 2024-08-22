-- models/clean_orders.sql
-- BRIAN WALKER MODEL

{{ config(materialized='table') }}

with source_data as (
    select *
    from DBT_DB.DBT_DB.ORDERS_EX  -- Referencia directa a la tabla en el mismo esquema
),

cleaned_data as (
    select
        ORDER_ID,
        AMOUNT,
        PROFIT,
        QUANTITY,
        CATEGORY,
        SUBCATEGORY,
        -- Eliminar el prefijo 'B-' y asignar a ORDER_ID2
        case
            when ORDER_ID like 'B-%' then substring(ORDER_ID, 3) -- Remove 'B-' from ORDER_ID
            else ORDER_ID
        end as ORDER_ID2
    from source_data
)

select * from cleaned_data