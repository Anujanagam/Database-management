# Load necessary libraries
library(DBI)
library(dplyr)

# Create a connection to the database (modify connection parameters as needed)
con <- dbConnect(RMySQL::MySQL(), 
                 dbname = "DBstudent119", 
                 host = "dbcourse-unh.cykbzjtad3ic.us-east-1.rds.amazonaws.com",
                 port = 3306,     
                 user = "student119", 
                 password = "cinema62")

# SQL Query equivalent to your SQL code
query <- "
SELECT 
    p.Product_name, 
    SUM(od.Quantity) AS Total_Quantity_Sold, 
    AVG(p.Price) AS Average_Price
FROM 
    Products p
INNER JOIN 
    OrderDetails od ON p.ProductID = od.ProductID
INNER JOIN 
    Orders o ON od.OrderID = o.OrderID
GROUP BY 
    p.Product_name
"

# Execute the query and fetch the results
result <- dbGetQuery(con, query)

# Print the result
print(result)

# Close the connection
dbDisconnect(con)
