import org.apache.spark.sql.SparkSession
import org.apache.spark.sql.functions._

val spark = SparkSession.builder().appName("WordCount").enableHiveSupport().getOrCreate()
import spark.implicits._

val data = Seq(
  (1, "hello spark world"),
  (2, "hello spark"),
  (3, "hello big data"),
  (4, "spark is fast")
)

val df = data.toDF("id", "text")

// Split and explode, making sure the column is named "word"
val wordsDF = df.select(explode(split($"text", " ")).as("word"))

// Now group by "word"
val wordCounts = wordsDF.groupBy("word").count().orderBy(desc("count"))

wordCounts.show()

// Read existing Hive table "people"
val peopleDF = spark.table("people")
peopleDF.show()
spark.stop()


/*
USE default;
CREATE TABLE people (id INT, name STRING );
INSERT INTO people VALUES (4, '4lice'),(2, 'Bob'),(3, 'Carol'),(4, 'David'),(5, 'Eve');


HADOOP_OPTS="--add-opens java.base/java.net=ALL-UNNAMED --add-opens java.base/java.lang=ALL-UNNAMED --add-opens java.base/java.nio=ALL-UNNAMED --add-opens java.base/java.util.concurrent.atomic=ALL-UNNAMED"



rm $SPARK_HOME/jars/hive-*-2.3.9.jar
rm $SPARK_HOME/jars/hive-service-rpc-3.1.3.jar
rm $SPARK_HOME/jars/hive-storage-api-2.8.1.jar
cp /opt/apache-hive-4.0.1-bin/lib/hive-*.jar $SPARK_HOME/jars/
cp /opt/apache-hive-4.0.1-bin/lib/hive-storage-api-*.jar $SPARK_HOME/jars/
cp /opt/apache-hive-4.0.1-bin/lib/datanucleus-*.jar $SPARK_HOME/jars/

grep -Fxq "host    all       all       0.0.0.0/0         md5" /etc/postgresql/15/main/pg_hba.conf || echo "host    all       all       0.0.0.0/0         md5" | sudo tee -a /etc/postgresql/15/main/pg_hba.conf > /dev/null

/etc/postgresql/15/main/pg_hba.conf
postgresql-9.4.1208.jre7.jar
*/