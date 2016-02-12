JPMML-R
=======

Java library and command-line application for converting [R] (http://www.r-project.org/) models to PMML.

# Features #

* Fast and memory-efficient:
  * Can produce a 5 GB Random Forest PMML file in less than 1 minute on a desktop PC
* Supported model types:
  * `stats` package:
    * `kmeans` - K-Means clustering
  * [`gbm` package] (http://cran.r-project.org/web/packages/gbm/):
    * `gbm` - Gradient Boosting Machine (GBM) regression and classification
  * [`party` package] (http://cran.r-project.org/web/packages/party/):
    * `ctree` - Conditional Inference Tree (CIT) classification
  * [`randomForest` package] (http://cran.r-project.org/web/packages/randomForest/):
    * `randomForest.formula` ("formula interface") - Random Forest (RF) regression and classification
    * `randomForest` ("matrix interface") - Random Forest regression and classification
  * [`caret` package] (http://cran.r-project.org/web/packages/caret/):
    * `train.formula` ("formula interface") - All JPMML-R supported model types
    * `train` ("matrix interface") - All JPMML-R supported model types
* Production quality:
  * Complete test coverage.
  * Fully compliant with the [JPMML-Evaluator] (https://github.com/jpmml/jpmml-evaluator) library.

# Prerequisites #

* Java 1.7 or newer.

# Installation #

Enter the project root directory and build using [Apache Maven] (http://maven.apache.org/):
```
mvn clean install
```

The build produces an executable uber-JAR file `target/converter-executable-1.1-SNAPSHOT.jar`.

# Usage #

A typical workflow can be summarized as follows:

1. Use R to train a model.
2. Serialize the model in [RDS data format] (https://stat.ethz.ch/R-manual/R-devel/library/base/html/readRDS.html) to a file in a local filesystem.
3. Use the JPMML-R command-line converter application to turn the RDS file to a PMML file.

### The R side of operations

The following R script trains a Random Forest (RF) model and saves it in RDS data format to a file `rf.rds`:
```R
library("randomForest")

rf = randomForest(Species ~ ., data = iris)

saveRDS(rf, "rf.rds")
```

### The JPMML-R side of operations

Converting the RDS file `rf.rds` to a PMML file `rf.pmml`:
```
java -jar target/converter-executable-1.1-SNAPSHOT.jar --rds-input rf.rds --pmml-output rf.pmml
```

The conversion of large files (1 GB and beyond) can be sped up by increasing the JVM heap size using `-Xms` and `-Xmx` options:
```
java -Xms4G -Xmx8G -jar target/converter-executable-1.1-SNAPSHOT.jar --rds-input rf.rds --pmml-output rf.pmml
```

# License #

JPMML-R is dual-licensed under the [GNU Affero General Public License (AGPL) version 3.0] (http://www.gnu.org/licenses/agpl-3.0.html) and a commercial license.

# Additional information #

Please contact [info@openscoring.io] (mailto:info@openscoring.io)