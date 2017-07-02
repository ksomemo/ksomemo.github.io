PHPで書いてみた。

* INFORMATION_SCHEMA.PARTITIONSからデータ取得
* schema, table のようなグループ分けをどうしたら良いのか…ネストが深い。

```php
<?php
$partitionsSelectQuery = 
    "select
    TABLE_SCHEMA
    , TABLE_NAME
    , PARTITION_NAME
    , PARTITION_ORDINAL_POSITION
    , PARTITION_METHOD
    , PARTITION_EXPRESSION
    , PARTITION_DESCRIPTION
    , PARTITION_COMMENT
    from INFORMATION_SCHEMA.PARTITIONS
    where TABLE_SCHEMA like '%schema%'
    and PARTITION_NAME is not null
    and PARTITION_METHOD in ('LIST')";

$partitions = array(); // クエリからデータ取得

// schema, table 別パーティション
$partitionsGrouping = array();
foreach ($partitions as $partition) {
    $tableSchema = $partition['TABLE_SCHEMA'];
    $tableName   = $partition['TABLE_NAME'];

    $partitionsGrouping[$tableSchema][$tableName][] = $partition;
}

// alter partition query
$partitionAlterQuerys = array();
foreach ($partitionsGrouping as $schema => $partitionsBySchema) {
    foreach ($partitionsBySchema as $tableName => $partitionsByTable) {
        $partitionAlterQuery = "ALTER TABLE $schema.$tableName REMOVE PARTITIONING; \n"
                            . "ALTER TABLE $schema.$tableName \n"
                            . "PARTITION BY RANGE( {$partitionsByTable[0]['PARTITION_EXPRESSION']} ) ( \n";
        foreach ($partitionsByTable as $partition) {
            // each partitios
            $partitionName            = $partition['PARTITION_NAME'];
            $partitionOrdinalPosition = $partition['PARTITION_ORDINAL_POSITION'];
            $partitionComment         = $partition['PARTITION_COMMENT'];

            // 未満を対象とするため調整
            $lessThan = $partitionOrdinalPosition + 1;
            $partitionAlterQuery .= "PARTITION $partitionName VALUES LESS THAN ($lessThan) COMMENT = '$partitionComment' ENGINE = InnoDB, \n";
        }
        $partitionAlterQuery .= "PARTITION pmax VALUES LESS THAN MAXVALUE); \n\n";

        $partitionAlterQuerys[] = $partitionAlterQuery;
    }
}

echo implode('', $partitionAlterQuerys);
```
