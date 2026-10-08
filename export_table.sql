COPY (
    SELECT * 
    FROM your_table
    WHERE some_column = 'some_value'
) TO '/chemin/vers/le/fichier/output.csv' 
WITH CSV HEADER;
